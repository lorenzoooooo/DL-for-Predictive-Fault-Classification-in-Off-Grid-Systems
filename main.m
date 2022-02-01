%% inserisco i parametri
% lasso è a durata in giorni della sequenza, span è l'intervallo tra una
% sequenza e l'altra e in_pred è l'intervallo predittivo in ore.
% proporzione è il rapporto tra sequenze patologiche e sane nel dataset (se
% è 2 allora avrò che per ogni sequenza patologica ne ho due sane).
% Quota_vs si riferisce alla frazione di test set che viene uat anche per
% il validation set.
% Torre è l'id della torre, name dice se la stazione contiene la stazione 
% meteo o meno e tipo differenzia tra digil pura e digil_iotbox
 
global lasso span int_predizione soglia_bad_mincellv soglia_good_mincellv soglia_bad_maxcellv soglia_good_maxcellv proporzione quota_vs;
lasso=3;
span=1;
int_predizione=24*3;
proporzione=3;              
soglia_bad_mincellv=3200;
soglia_good_mincellv=3300;
soglia_bad_maxcellv=3250;
soglia_good_maxcellv=3350;
%quota_vs=3;

%% estraggo e etichetto le sequenze
fclose('all');
fileID = fopen('mat.txt','r');
a=fgetl(fileID);
while ischar(a)
    load(a);
%     close all;
    variabili.nome= ["min cell voltage";"panel power";"max cell voltage"];  %; "consumer current"
    [sequenze, variabili]=estrazione_sequenze(data,variabili);                                            % suddivido in sequenze di 6 giorni
    [idx_b,idx_g]=sospetti(sequenze);                                          % identifico le sequenze patologiche
    sequenze=normalizzazione(data,sequenze,variabili);                                                 %sottraggo il valor medio e divido per la varianza ogni riga di ogni sequenze eccetto il time stamp
%     grafico(sequenze,variabili);
    [XTr,YTr,XTs,YTs,XVs,YVs,tr,ts,vs]= etichette(idx_b,idx_g,sequenze);   % Suddivido in Tr e Ts per una data torre
    pulizia;
    salvataggio;
    a=fgetl(fileID);
end
fclose(fileID);
% dataset1();