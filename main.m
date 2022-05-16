%% inserisco i parametri
% lasso è a durata in giorni della sequenza, span è l'intervallo tra una
% sequenza e l'altra e int_predizione è l'intervallo predittivo in giorni.
% proporzione è il rapporto tra sequenze patologiche e sane nel dataset (se
% è 2 allora avrò che per ogni sequenza patologica ne ho due sane).
% Quota_vs si riferisce alla frazione di test set che viene usato anche per
% il validation set.
% Torre è l'id della torre, name dice se la l'apparato contiene la stazione 
% meteo o meno e tipo differenzia tra digil pura e digil_iotbox
 
global lasso span int_predizione soglia_bad_mincellv proporzione rapporto;

lasso=3;
span=1;
int_predizione=1;
proporzione=3;              
soglia_bad_mincellv=3200;
rapporto=0.25;

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
    variabili.nome= ["min cell voltage";"panel power";"soc";"irradiation"];                     % varibili usate nelle sequenze  % ;"soc";"irradiation";"totbatterycurrent";"outputcurrentmppt"
    [sequenze, variabili]=estrazione_sequenze(p,nuova_struct,variabili);    % suddivido in sequenze di lasso giorni
    [idx_b,idx_g,c]=sospetti(sequenze);                                     % identifico le sequenze patologiche 
    sequenze=normalizzazione(nuova_struct,sequenze,variabili);              % sottraggo il valor medio e divido per la deviazione standard
    [X,Y]=etichette(idx_b,idx_g,sequenze);                                  % creo il dataset relat ad un dato traliccio
    pulizia;
    salvataggio;  
    a=fgetl(fileID);
end
fclose(fileID);
dataset1();

%     figure;
%     for i=1:size(sequenze,1)
%         k=find(sequenze{i}.mincellvoltage<3070);
%         if ~isempty(k)
%             plot(datetime(sequenze{i}.time,'convertfrom','excel'),sequenze{i}.mincellvoltage);
%             hold on;
%         end
%     end

%     figure; plot(nuova_struct.time, nuova_struct.panelpower);
% plot(nuova_struct.time, nuova_struct.irradiation);
%     title(strcat("bilancio correnti batteria ",string(torre)));

%     close all;
%     b=c{1}; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze patologiche di riferimento'));
%     b=c{2}; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze sane di riferimento'));
%     b=idx_b; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze patologiche predittive'));
%     b=idx_g; figure; hold off; for i=1:size(b,2) plot(datetime(sequenze{b(i)}.time,'ConvertFrom','excel'),sequenze{b(i)}.mincellvoltage); hold on; end
%     title(strcat(torre,' sequenze sane predittive'));