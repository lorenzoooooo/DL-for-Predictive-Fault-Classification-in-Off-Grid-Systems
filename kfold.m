close all force;
clear;

input('controlla che stai usando il giusto dataset!');
% dataset_path=['dataset\t13008_t16399_t1059_t1021_t1025\mincellvoltage_panelpower\1_1_7_3_0.25'];
dataset_path=['dataset\t13008_t16399_t1059_t1021\mincellvoltage_panelpower_soc_irradiation\3_1_1_3_0.25'];
load(dataset_path, 'X', 'Y','path');

inputSize = 2;
numHiddenUnits =15;
numClasses = 2;
maxEpochs = 8;
miniBatchSize =10;
lr=0.04;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(19)
    reluLayer
    fullyConnectedLayer(10)
    reluLayer
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
    'Shuffle','every-epoch', ...
    'Verbose',0);
%     'Plots','training-progress');


n=randperm(numel(Y));
X=X(n);
Y=Y(n);
prova=[];

n_runs=10;
k_fold=4;
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
% Training
            net = trainNetwork(trainX,trainY,layers,options);
% Test
            YPred(cv.test(i),z) = classify(net,testX);
        end
% accuracy    
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
 
% figure;    
% cm_avg=confusionchart(round(mean(cm,3)),order);
% cm_avg.Title=sprintf('Mean confusion matrix');
% cm_avg.RowSummary = 'row-normalized';
% cm_avg.ColumnSummary = 'column-normalized';

cm_avg=mean(cm,3);
fprintf('\n  Average confusion matrix (true classes by rows):\n');
disp(cm_avg);  

cm_std=std(cm,0,3);
fprintf('  Std. confusion matrix (true classes by rows):\n');
disp(cm_std);  

acc_avg=mean(acc*100);
acc_std=std(acc*100,0);
fprintf('  Overall classification accuracy: %.2f%% %c %.2f%%\n', acc_avg,char(177),acc_std);

err_avg=mean(100*(1-acc));
err_std=std(100*(1-acc),0);
fprintf('\n  Overall classification error: %.2f%% %c %.2f%%\n\n', err_avg,char(177),err_std);

%% salvataggio
file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(numHiddenUnits),'_',string(maxEpochs),'_',string(lr),'_',string(options.LearnRateDropFactor),'_',string(round(acc_avg/100,2)),'_kfold','_',string(n_runs),'_',string(k_fold),'_',string(miniBatchSize)));
path="risultati_3fc\t13008_t16399_t1059_t1021_t1025\mincellvoltage_panelpower\1_1_7_3_0.25\";
% path="risultati_3fc\t13008_t16399_t1059_t1021\mincellvoltage_panelpower_soc_irradiation\1_1_7_3_0.25\";
path_def=strcat(path,{'\'},file,{'\'});
mkdir(path_def);
save(strcat(path_def,'risultati'));