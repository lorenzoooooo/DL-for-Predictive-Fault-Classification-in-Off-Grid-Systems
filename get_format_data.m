%% Query
input('ricordati di cambiare il numero della torre nella query!');
query=input('scegli query:\n','s');
eval(query);
%% Prima formattazione dei dati
global tipo name torre;
[sqldata, bozza_dati, p, nuova_struct]=init(sqldata_grezzo);
% xlswrite('sqldata_grezzo.xlsx',table2cell(sqldata_grezzo));
% movefile ("C:\Users\UTENTE\Desktop\elaborazione_dati\sqldata_grezzo.xlsx", string(strcat('C:\Users\UTENTE\Desktop\py\',tipo,{'\'},torre)));
pulizia;
salvataggio;
% figure;
% plot(nuova_struct.time,nuova_struct.mincellvoltage);