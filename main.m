%% inserisco i parametri
% lasso è a durata in giorni della sequenza, span è l'intervallo tra una
% sequenza e l'altra e int_predizione è l'intervallo predittivo in giorni.
% proporzione è il rapporto tra sequenze patologiche e sane nel dataset (se
% è 2 allora avrò che per ogni sequenza patologica ne ho due sane).
% Quota_vs si riferisce alla frazione di test set che viene uat anche per
% il validation set.
% Torre è l'id della torre, name dice se la stazione contiene la stazione 
% meteo o meno e tipo differenzia tra digil pura e digil_iotbox
 
global lasso span int_predizione soglia_bad_mincellv proporzione rapporto;
lasso=3;
span=1;
int_predizione=3;
proporzione=3;              
soglia_bad_mincellv=3200;
rapporto=1/4;


% global soglia_bad_maxcellv soglia_good_mincellv soglia_good_maxcellv quota_vs;
% soglia_good_mincellv=3350;
% soglia_bad_maxcellv=3250;
% soglia_good_maxcellv=3350;
%quota_vs=3;
%% estraggo e etichetto le sequenze

fclose('all');
fileID = fopen('mat.txt','r');
a=fgetl(fileID);
while ischar(a)
    load(a);
    variabili.nome= ["min cell voltage";"panel power";"soc";"irradiation"; "tot battery current"];             % variabili usate nelle sequenze                                                                             %; "consumer current" "max cell voltage" ;"soc";"irradiation"
    [sequenze, variabili]=estrazione_sequenze(p,nuova_struct,variabili);  % suddivido in sequenze di 3 giorni
    [idx_b,idx_g,c]=sospetti(sequenze);                                   % identifico le sequenze patologiche

%     b=c{1}; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze patologiche'));
%     b=c{2}; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze sane'));
%     b=idx_b; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze patologiche a 7 giorni'));
%     b=idx_g; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze sane a 7 giorni'));

    sequenze=normalizzazione(nuova_struct,sequenze,variabili); % sottraggo il valor medio e divido per la deviazione standard 
    [XTr,YTr,XTs,YTs,tr,ts]= etichette(idx_b,idx_g,sequenze);  % Suddivido in Train e Test set
    pulizia;
    salvataggio;
    a=fgetl(fileID);
end
fclose(fileID);
dataset1();

%     nuova_struct.totbatterycurrent=nuova_struct.batterycurrentin-nuova_struct.batterycurrentout;
%     figure; plot(nuova_struct.time, nuova_struct.panelpower);
% plot(nuova_struct.time, nuova_struct.irradiation);
%     title(strcat("bilancio correnti batteria ",string(torre)));

%     grafico(sequenze,variabili);
%     close all;
%     b=idx_g; figure; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage,'g'); hold on; end
%         title(strcat(torre,' sequenze sane')); hold off
%     b=idx_b; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage,'r'); hold on; end
%         title(strcat(torre,' sequenze patologiche'));
%     b=c{1}; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.panelpower); hold on; end
%     title(strcat(torre,' sequenze patologiche'));
%     b=c{2}; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.panelpower); hold on; end
%     title(strcat(torre,' sequenze sane'));
% 
% 
% 
%     b=idx_b; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze patologiche a 7 giorni'));
%     b=idx_g; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze sane a 7 giorni'));