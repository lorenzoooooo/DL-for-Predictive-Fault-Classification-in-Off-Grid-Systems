%% creo un cell array composto da (numero di variabili +1) celle ognuno con un numero di colonne pari alle righe di bozza dati.
% la prima riga corrisponde al timestamp mentre le altre corrispondono ai valori campionati delle variabili.
% In questa prima fase ho una colonna per ogni campione in bozza dati, quindi può
% succedere che vado a creare diverse colonne per lo stesso istante di
% tempo.

function temp_data = versione1(bozza_dati,var)

righe_var=size(var,1);
coord={};                                   % coordinate delle colonne diverse da zero. Ogni cella rappresenta una variabile.
tot_colonne = size(bozza_dati{1,1},2);
temp_data=cell(righe_var+1,1);              % cell array in cui la prima riga è il tempo e le seguenti rappresentano ognuna una variabile
temp_data(1,:)=bozza_dati(1,:);             % la prima riga di temp_data deve essere il timestamp
for z=2:righe_var+1 
    temp_data(z,1)={NaN(1,tot_colonne)};    % I buchi lasciati nelle caselle dove non c'è un campione vengono riempiti con NaN per distinguerli 
end                                         % dagli zeri campionati

for i=1:righe_var
    coord{i,1}= eq(bozza_dati{3,:}, var{i,2});
    coord{i,1}=find(coord{i,1});
end
for i=1:righe_var
    k=i+1; 
    for j=1:size(coord{i,1},2)
       temp_data{k,1}(1,coord{i,1}(1,j))=bozza_dati{2,1}(1,coord{i,1}(1,j));
    end
    ultimo_val_non_nullo = coord{i,1}(1,j);
    temp_data{k,1}(1,ultimo_val_non_nullo+1:tot_colonne) =NaN; % riempio restanti campioni con NaN per avere vettori con la stessa lunghezza
end
temp_data=cell2mat(temp_data);