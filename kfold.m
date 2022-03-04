close all force;
clear;

input('controlla che stai usando il giusto dataset!');
dataset_path=['risultati_int\t13008_t16399_t1059_t1021\mincellvoltage_panelpower_soc_irradiation\3_1_1_3_0.25\3200\dataset'];
load(dataset_path, 'X', 'Y','path');

inputSize = 4;
numHiddenUnits =20;
numClasses = 2;
maxEpochs = 8;
miniBatchSize = 53;
miniBatchSizets = 53;
lr=0.04;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];
            
options = trainingOptions('adam', ...
    'InitialLearnRate', lr, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',2, ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0);
%     'Plots','training-progress');

%%
n_runs=2;
k_fold=4;
testX={};
a=[];
 for z=1:n_runs
        fprintf('--- RUN %i / %i ---\n', z, n_runs);
        rng(z,'Threefry');
        gpurng(z,'Threefry');
        cv = cvpartition(Y,'KFold',k_fold);
        for i = 1:cv.NumTestSets
            clear testX trainX
            fprintf('\t--- Fold %i / %i ---\n', i, cv.NumTestSets);
            testY = Y(cv.test(i));
            trainY = Y(cv.training(i));
            testX(:,1)= X(cv.test(i),:);
            trainX(:,1) = X(cv.training(i),:);
%Obtain Sequence length
            numObservations = numel(trainX);
            for j=1:numObservations
                sequence = trainX{j};
                sequenceLengths(j) = size(sequence,2);
            end
            numObservationsTest = numel(testX);
            for j=1:numObservationsTest
                sequence = testX{j};
                sequenceLengthsTest(j) = size(sequence,2);
            end
%Training
            net = trainNetwork(trainX,trainY,layers,options);
%Test
            YPred(cv.test(i),z) = classify(net,testX, ...
            'MiniBatchSize',miniBatchSizets, ...
            'SequenceLength','longest');
            a(i,1)=numel(find(trainY=='0'));
            a(i,2)=numel(find(testY=='0'));
        end
%accuracy    
        [cm(:,:,z),order]=confusionmat(Y,YPred(:,z),'Order',categories(Y));     
        figure;
        cm_c= confusionchart(cm(:,:,z),order);
        cm_c.Title=sprintf('Confusion matrix on run %i',z);
        cm_c.RowSummary = 'row-normalized';
        cm_c.ColumnSummary = 'column-normalized';
        acc(z,1) = sum(YPred(:,z) == Y)./numel(Y);
        fprintf('\t--- Final accuracy on run %i: %.2f%% ---\n\n', z, 100*acc(z,1));
        drawnow;
    end
    
cm_avg=mean(cm,3);
fprintf('Average confusion matrix (true classes by rows):\n');
disp(cm_avg);  

cm_std=std(cm,0,3);
fprintf('Std. confusion matrix (true classes by rows):\n');
disp(cm_std);  

acc_avg=mean(acc*100);
acc_std=std(acc*100,0);
fprintf('Overall classification accuracy: %.2f%% %c %.2f%%\n', acc_avg,char(177),acc_std);

err_avg=mean(100*(1-acc));
err_std=std(100*(1-acc),0);
fprintf('\nOverall classification error: %.2f%% %c %.2f%%\n\n', err_avg,char(177),err_std);

%% salvataggio

file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(numHiddenUnits),'_',string(maxEpochs),'_',string(lr),'_',string(options.LearnRateDropFactor),'_',string(round(acc_avg/100,2)),'_kfold','_',string(n_runs),'_',string(k_fold)));
path_def=strcat(path,{'\'},file,{'\'});
mkdir(path_def);
save(strcat(path_def,'risultati'));