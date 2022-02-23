function []=dataset1()

global lasso span int_predizione soglia_bad_mincellv rapporto proporzione;
Y_sane=categorical();
X_sane={};
Y_patologiche=categorical();
X_patologiche={};
tralicci=string();
XTest={};
XTrain={};
YTest=categorical();
YTrain=categorical();

fclose('all');
fileID = fopen('mat.txt','r');
a = fgetl(fileID);
while ischar(a)                                         %ciclo che prende i dati di una torre per volta
    load(a);
    sane=find(Y=='1');
    patologiche=find(Y=='0');
    X_sane=[X_sane; X(sane)];
    Y_sane=[Y_sane; Y(sane)];
    X_patologiche=[X_patologiche; X(patologiche)];
    Y_patologiche=[Y_patologiche; Y(patologiche)];
    tralicci=[tralicci; torre];                          
    a = fgetl(fileID);
end
fclose(fileID);

x=[1:size(X_sane,1)];
a=randsample(x,round(rapporto*numel(x)));

y=[1:size(X_patologiche,1)];
b=randsample(y,round(rapporto*numel(y)));

XTest=[X_sane(a); X_patologiche(b)];
YTest=[Y_sane(a); Y_patologiche(b)];

temp_a= find(~ismember(x,a));
temp_b= find(~ismember(y,b));

XTrain=[X_sane(temp_a); X_patologiche(temp_b)];
YTrain=[Y_sane(temp_a); Y_patologiche(temp_b)];


tralicci(1)=[];
tralicci=nome_cartella(tralicci);
features=nome_cartella(variabili.nome);
parametri=strcat(string(lasso),'_',string(span),'_',string(int_predizione),'_',string(proporzione),'_',string(rapporto));                                                            %,'_',string(quota_vs)
soglia=string(soglia_bad_mincellv);
path=strcat('risultati_int\',tralicci,{'\'},features,{'\'},parametri,{'\'},soglia,{'\'});
path=string(path);
mkdir(path);
save(strcat(path,'dataset'),"YTest","YTrain","XTest","XTrain","path","int_predizione", "lasso", "span", "proporzione","soglia_bad_mincellv", "rapporto","sequenze");