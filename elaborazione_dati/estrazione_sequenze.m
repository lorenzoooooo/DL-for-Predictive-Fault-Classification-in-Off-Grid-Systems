function seq_def = estrazione_sequenze(data,variabili)
%% Trovo le sequenze che sono più lunghe di 30 ore
global name;
[dhour,d0]=mezzanotte(data(1,:));
err=[];
d1=duration();
for i=2:size(dhour,2)
    d1(i-1)= d0(i)-d0(i-1);
end
treshold='30:00:00';
err=find(d1(1,:)>treshold); 

%% Ottengo sequenze di 24 ore
righe=discrimina(variabili);
sequenze={};
i=1;
if ~ismember(i,err)
    seq=estraggo(data,dhour,i,righe);
    sequenze{i,1}=seq;
end
for i=2:size(dhour,2)-1
    seq=estraggo(data,dhour,i,righe);
    sequenze{i,1}=seq;
    if ismember(i,err)
        sequenze{i,1}=[];
    end
end
panel_power= pp_dy (sequenze);
%% creo sequenze di 6 giorni
lasso=3;
span=1;
tolleranza=fix(24*lasso/10); %tolleranza sulla durata della sequenza del 10%
treshold=(24*lasso)+tolleranza;
treshold=hours(treshold);
seq_def={};
i=1;
j=size(sequenze,1);
while j-lasso+1>0   %estraggo sequenze da 6 giorni,interrompo quando i dati rimanenti sono troppo pochi per fare una sequenza da 6 giorni
    seq=[];
    for k=lasso-1:-1:0
        seq=[seq sequenze{j-k,1}];
%         if isempty(sequenze{j-k,1})
%             counter=[counter i];
%         end
    end
    seq_def{i,1}=seq;
    j=j-span;
    i=i+1;
end
[~,~,d6,~]=durata_seq(seq_def,treshold,">=");   %trovo le sequenze più lunghe di 6 giorni
seq_def(d6,:)=[];                               %e le elimino
[cell_idx, mat_idx] = picchi_anomali(seq_def);  % trovo le sequenze che presentano discontinuità sul min cellv che portano il valore istantaneamente sotto la soglia di 2000 mV
for i=1:size(cell_idx,1)                          % trovi i campioni e gli assegno l'ultimo vaore valido campionato
    for j=1:size(mat_idx,2)
        seq_def{cell_idx(i),1}(2,mat_idx(i,j))=seq_def{cell_idx(i),1}(2,mat_idx(i,j)-1);
    end
end

tolleranza=round(24/(lasso-1));                         %tolleranza sulla durata della sequenza di 20% di 24 ore
treshold=24*(lasso-1)+tolleranza;
treshold=hours(treshold);
[~,~,d6,~]=durata_seq(seq_def,treshold,"<=");   %trovo le sequenze più corte di 5 giorni
seq_def(d6,:)=[];                               %e le elimino