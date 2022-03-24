close all force;
clear;

%% Load
input('controlla che stai usando il giusto dataset!');
dataset_path=['risultati_int\t13008_t16399_t1059_t1021\mincellvoltage_panelpower_soc_irradiation\1_1_7_3_0.25\3200\dataset'];
load(dataset_path, 'XT*', 'YT*','path');

%% Parametri della rete
inputSize = 4;
numHiddenUnits =15;
numClasses = 2;
maxEpochs = 8;
miniBatchSize =30;
lr=0.04;
%%
% Visualize the first time series in a plot. Each line corresponds to a feature.

figure;
d=[1:size(XTrain,1)];
d=randsample(d,1);
plot(XTrain{d}')
xlabel("Time Step")
title(strcat("Training Observation ",string(YTrain(d))));
numFeatures = size(XTrain{1},1);
legend("Feature " + string(1:numFeatures),'Location','northeastoutside')
%% Prepare Data for Padding
numObservations = numel(XTrain);
for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end
%% 
% Sort the data by sequence length.

[sequenceLengths,idx] = sort(sequenceLengths);
XTrain = XTrain(idx);
YTrain = YTrain(idx);
%% 
% View the sorted sequence lengths in a bar chart.

figure
bar(sequenceLengths)
xlabel("Sequence")
ylabel("Length")

%% Define LSTM Network Architecture
layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]
%% Training options

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
    'Shuffle','every-epoch', ...
    'Verbose',0, ...
    'Plots','training-progress');   

%% Train LSTM Network

[net,info] = trainNetwork(XTrain,YTrain,layers,options);

%% Test LSTM Network

numObservationsTest = numel(XTest);
for k=1:numObservationsTest
    sequence = XTest{k};
    sequenceLengthsTest(k) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);

%% Classify the test data

YPred = classify(net,XTest, ...
    'SequenceLength','longest');

%% Calculate the classification accuracy of the predictions.

acc = sum(YPred == YTest)./numel(YTest)
figure;
conf_chart=confusionchart(YTest,YPred);
conf_chart.RowSummary = 'row-normalized';

%% salvataggio
currentfig = findall(groot, 'Tag', 'NNET_CNN_TRAININGPLOT_UIFIGURE');
if options.LearnRateSchedule=="none"  
    file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(numHiddenUnits),'_',string(maxEpochs),'_',string(lr),'_',string(round(acc,2))));
else
    file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(numHiddenUnits),'_',string(maxEpochs),'_',string(lr),'_',string(options.LearnRateDropFactor),'_',string(round(acc,2)),'_piecewise','_',string(options.Shuffle)));
end
path_def=strcat(path,{'\'},file,{'\'});
mkdir(path_def);
savefig(currentfig,strcat(path_def,'training_progress.fig'));
savefig(strcat(path_def,'confusion_chart'));
save(strcat(path_def,'risultati'));