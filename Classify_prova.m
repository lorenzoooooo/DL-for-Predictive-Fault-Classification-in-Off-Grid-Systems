close all force;
clear;

%% Load
input('controlla che stai usando il giusto dataset!');
% dataset_path=['dataset\t13008_t16399_t1059_t1021_t1025\mincellvoltage_panelpower\1_1_7_3_0.25'];
dataset_path=['dataset\t13008_t16399_t1059_t1021\mincellvoltage_panelpower_soc_irradiation\3_1_1_3_0.25'];
load(dataset_path, 'XT*', 'YT*','path');

%% Parametri della rete
inputSize = 2;
numHiddenUnits =8;
numClasses = 2;
maxEpochs = 15;
lr=0.04;
miniBatchSize =14;

%% Visualize the first time series in a plot. Each line corresponds to a feature.
figure;
d=[1:size(XTrain,1)];
d=randsample(d,1);
plot(XTrain{d}')
xlabel("Time Step")
title(strcat("Training Observation ",string(YTrain(d))));
numFeatures = size(XTrain{1},1);
legend("Feature " + string(1:numFeatures),'Location','northeastoutside')

%% Define LSTM Network Architecture


layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

% Training options

options = trainingOptions('adam', ...
    'InitialLearnRate', lr, ...
    'ExecutionEnvironment','cpu', ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',2, ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','every-epoch', ...
    'Verbose',0, ...
    'Plots','training-progress');   

% Train LSTM Network
[net,info] = trainNetwork(XTrain,YTrain,layers,options);

% Classify the test data
YPred = classify(net,XTest);

% Calculate the classification accuracy of the predictions.
acc = sum(YPred == YTest)./numel(YTest)
figure;
conf_chart=confusionchart(YTest,YPred);
conf_chart.RowSummary = 'row-normalized';

%% salvataggio
currentfig = findall(groot, 'Tag', 'NNET_CNN_TRAININGPLOT_UIFIGURE');
if options.LearnRateSchedule=="none"  
    file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(numHiddenUnits),'_',string(maxEpochs),'_',string(lr),'_',string(round(acc,2))));
else
    file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(numHiddenUnits),'_',string(maxEpochs),'_',string(lr),'_',string(options.LearnRateDropFactor),'_',string(round(acc,2)),'_piecewise_',string(miniBatchSize)));
end
% path="risultati_2bilstm\t13008_t16399_t1059_t1021_t1025\mincellvoltage_panelpower\3_1_7_3_0.25\";
path_def=strcat(path,{'\'},file,{'\'});
mkdir(path_def);
savefig(currentfig,strcat(path_def,'training_progress.fig'));
savefig(strcat(path_def,'confusion_chart'));
save(strcat(path_def,'risultati'));