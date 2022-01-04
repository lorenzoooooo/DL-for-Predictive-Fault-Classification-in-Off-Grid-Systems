close all force;
clear;
load('risultati\t1021-t16239-t16399-t13008-t1059\mincellvoltage-panelpower-maxcellvoltage\dataset.mat');
%% 
% Visualize the first time series in a plot. Each line corresponds to a feature.

% figure
% plot(XTrain{1}')
% xlabel("Time Step")
% title("Training Observation 1")
% numFeatures = size(XTrain{1},1);
% legend("Feature " + string(1:numFeatures),'Location','northeastoutside')
%% Prepare Data for Padding
% During training, by default, the software splits the training data into mini-batches 
% and pads the sequences so that they have the same length. Too much padding can 
% have a negative impact on the network performance.
% 
% To prevent the training process from adding too much padding, you can sort 
% the training data by sequence length, and choose a mini-batch size so that sequences 
% in a mini-batch have a similar length. The following figure shows the effect 
% of padding sequences before and after sorting data.
% 
% 
% 
% Get the sequence lengths for each observation.

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
% ylim([0 30])
xlabel("Sequence")
ylabel("Length")

%% Define LSTM Network Architecture
% Define the LSTM network architecture. Specify the input size to be sequences 
% of size 12 (the dimension of the input data). Specify an bidirectional LSTM 
% layer with 100 hidden units, and output the last element of the sequence. Finally, 
% specify nine classes by including a fully connected layer of size 9, followed 
% by a softmax layer and a classification layer.
% 
% If you have access to full sequences at prediction time, then you can use 
% a bidirectional LSTM layer in your network. A bidirectional LSTM layer learns 
% from the full sequence at each time step. If you do not have access to the full 
% sequence at prediction time, for example, if you are forecasting values or predicting 
% one time step at a time, then use an LSTM layer instead.

inputSize = 4;
numHiddenUnits =50;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]
%% 
% Now, specify the training options. Specify the solver to be |'adam'|, the 
% gradient threshold to be 1, and the maximum number of epochs to be 100. To reduce 
% the amount of padding in the mini-batches, choose a mini-batch size of 27. To 
% pad the data to have the same length as the longest sequences, specify the sequence 
% length to be |'longest'|. To ensure that the data remains sorted by sequence 
% length, specify to never shuffle the data.
% 
% Since the mini-batches are small with short sequences, training is better 
% suited for the CPU. Specify |'ExecutionEnvironment'| to be |'cpu'|. To train 
% on a GPU, if available, set |'ExecutionEnvironment'| to |'auto'| (this is the 
% default value).

maxEpochs = 30;
miniBatchSize = 25;

options = trainingOptions('adam', ...
    'InitialLearnRate', 0.01, ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'ValidationData',{XVal,YVal}, ...
    'ValidationFrequency',6, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',1, ...
    'OutputNetwork' ,'best-validation-loss', ...
    'Plots','training-progress')
%% Train LSTM Network
% Train the LSTM network with the specified training options by using |trainNetwork|.

[net,info] = trainNetwork(XTrain,YTrain,layers,options);
%% Test LSTM Network
% Load the test set and classify the sequences into speakers.
% 
% Load the Japanese Vowels test data. |XTest| is a cell array containing 370 
% sequences of dimension 12 of varying length. |YTest| is a categorical vector 
% of labels "1","2",..."9", which correspond to the nine speakers.

% [XTest,YTest] = japaneseVowelsTestData;
% XTest(1:3)
%% 
% The LSTM network |net| was trained using mini-batches of sequences of similar 
% length. Ensure that the test data is organized in the same way. Sort the test 
% data by sequence length.

numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);
%% 
% Classify the test data. To reduce the amount of padding introduced by the 
% classification process, set the mini-batch size to 27. To apply the same padding 
% as the training data, specify the sequence length to be |'longest'|.

miniBatchSizets = 25;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSizets, ...
    'SequenceLength','longest');

%% 
% Calculate the classification accuracy of the predictions.

acc = sum(YPred == YTest)./numel(YTest)
figure;
conf_chart=confusionchart(YTest,YPred);


%% salvataggio
currentfig = findall(groot, 'Tag', 'NNET_CNN_TRAININGPLOT_UIFIGURE');
file=strcat(strcat(string(day(datetime)),'-',string(month(datetime)),'_',string(hour(datetime)),'-',string(minute(datetime))),'_',string(round(acc,2)));
path=strcat(path,{'\'},file,{'\'});
mkdir(path);
savefig(currentfig,strcat(path,'training_progress.fig'));
savefig(strcat(path,'confusion_chart'));
save(strcat(path,'risultati'));
%% 
% _Copyright 2018 The MathWorks, Inc._