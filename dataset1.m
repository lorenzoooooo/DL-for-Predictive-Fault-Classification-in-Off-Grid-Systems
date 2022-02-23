function []=dataset1()
global lasso span int_predizione soglia_bad_mincellv rapporto proporzione;
YTrain=categorical();
XTrain={};
XTest={};
YTest=categorical();
XVal={};
YVal=categorical();

tralicci=string();
fclose('all');
fileID = fopen('mat.txt','r');
a = fgetl(fileID);
while ischar(a)                                         %ciclo che prende i dati di una torre per volta
    load(a);                                            
    for i=1:size(XTr,1)                                 %Mergio tutti i Trset delle singole torri in uno solo globale
        XTrain=[XTrain; XTr{i,1}];
        YTrain=[YTrain; YTr(i,1)];
    end
    for i=1:size(XTs,1)                                 %Mergio tutti i Tsset delle singole torri in uno solo globale
        XTest=[XTest; XTs{i,1}];
        YTest=[YTest; YTs(i,1)];
    end
    tralicci=[tralicci; torre];                          
    a = fgetl(fileID);
end
fclose(fileID);

%     for i=1:size(XVs,1)                                 %Mergio tutti i Tsset delle singole torri in uno solo globale
%         XVal=[XVal; XVs{i,1}];
%         YVal=[YVal; YVs(i,1)];
%     end
tralicci(1)=[];


tralicci=nome_cartella(tralicci);
features=nome_cartella(variabili.nome);
parametri=strcat(string(lasso),'_',string(span),'_',string(int_predizione),'_',string(proporzione),'_',string(rapporto));                                                            %,'_',string(quota_vs)
soglia=string(soglia_bad_mincellv);
path=strcat('risultati_int\',tralicci,{'\'},features,{'\'},parametri,{'\'},soglia,{'\'});
path=string(path);
mkdir(path);
save(strcat(path,'dataset'),"YTest","YTrain","XTest","XTrain","path","int_predizione", "lasso", "span", "proporzione","soglia_bad_mincellv", "rapporto","sequenze");

