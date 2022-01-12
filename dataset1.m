function []=dataset1()
global lasso span int_predizione soglia_bad_mincellv soglia_good_mincellv soglia_bad_maxcellv soglia_good_maxcellv proporzione quota_vs;
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
features=nome_cartella(variabili.nome);
parametri=strcat(string(lasso),'_',string(span),'_',string(int_predizione),'_',string(proporzione),'_',string(quota_vs));
path=strcat('risultati\',tralicci,{'\'},features,{'\'},parametri,{'\'});
path=string(path);
mkdir(path);
dataset=strcat(string(soglia_bad_mincellv),'_',string(soglia_good_mincellv),'_',string(soglia_bad_maxcellv),'_',string(soglia_good_maxcellv),{'\'});
save(strcat(path,dataset,'dataset'),"YTest","YTrain","XTest","XTrain","XVal","YVal","path","int_predizione", "lasso", "span","soglia_bad_mincellv", "soglia_good_mincellv", "soglia_bad_maxcellv", "soglia_good_maxcellv","quota_vs");