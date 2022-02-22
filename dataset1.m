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
%     for i=1:size(XVs,1)                                 %Mergio tutti i Tsset dlle singole torri in uno solo globale
%         XVal=[XVal; XVs{i,1}];
%         YVal=[YVal; YVs(i,1)];
%     end
    tralicci=[tralicci; torre];
    a = fgetl(fileID);
end
fclose(fileID);

tralicci(1)=[];
tralicci=nome_cartella(tralicci);
features=nome_cartella(variabili.nome);
parametri=strcat(string(lasso),'_',string(span),'_',string(int_predizione(1)),'_',string(proporzione));  %,'_',string(quota_vs)
soglia=string(soglia_bad_mincellv);
path=strcat('risultati_7_15\',tralicci,{'\'},features,{'\'},parametri,{'\'},soglia,{'\'});
path=string(path);
mkdir(path);
save(strcat(path,'dataset'),"YTest","YTrain","XTest","XTrain","path","int_predizione", "lasso", "span","proporzione","soglia_bad_mincellv","sequenze");