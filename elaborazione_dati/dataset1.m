function []=dataset1()

tralicci=string();
YTrain=categorical();
XTrain={};
XTest={};
YTest=categorical();
XVal={};
YVal=categorical();
fclose('all');
fileID = fopen('mat.txt','r');
a = fgetl(fileID);
while ischar(a)                                         %ciclo che prende i dati di una torre per volta
    load(a);
    for i=1:size(XTr,1)                                 %Mergio tutti i Trset dlle singole torri in uno solo globale
        XTrain=[XTrain; XTr{i,1}];
        YTrain=[YTrain; YTr(i,1)];
    end
    for i=1:size(XTs,1)                                 %Mergio tutti i Tsset dlle singole torri in uno solo globale
        XTest=[XTest; XTs{i,1}];
        YTest=[YTest; YTs(i,1)];
    end
    for i=1:size(XVs,1)                                 %Mergio tutti i Tsset dlle singole torri in uno solo globale
        XVal=[XVal; XVs{i,1}];
        YVal=[YVal; YVs(i,1)];
    end
    tralicci=[tralicci; torre];
    a = fgetl(fileID);

end
fclose(fileID);

tralicci(1)=[];
tralicci=nome_cartella(tralicci);
features=nome_cartella(variabili);
path=strcat('risultati\',tralicci,{'\'},features,{'\'});
path=string(path);
mkdir(path);
save(strcat(path,'dataset'),"YTest","YTrain","XTest","XTrain","XVal","YVal","path");



