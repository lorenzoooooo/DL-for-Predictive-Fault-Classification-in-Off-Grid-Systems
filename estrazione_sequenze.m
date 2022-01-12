function [seq_def,variabili] = estrazione_sequenze(data,variabili)
global span lasso;
%% Trovo le sequenze che sono più lunghe di 30 ore
[dhour,d0]=mezzanotte(data(1,:));
err=[];
d1=duration();
for i=2:size(dhour,2)
    d1(i-1)= d0(i)-d0(i-1);
end
tolleranza=24/5;                    % metto un 20% di tolleranza
treshold=24 + tolleranza;       
treshold=hours(treshold);
err=find(d1(1,:)>treshold); 

%% Ottengo sequenze di 24 ore
variabili=discrimina(variabili);    % da l'indice delle righe corrispondenti alle variabili che vogliamo usare in base al tipo di torre
sequenze={};
variabili.nb=string();              % contiene il nome delle variabili senza spazi
for i=1:size(variabili.nome,1)
    variabili.nb(i,1)=nome_cartella(variabili.nome(i,1));
end
i=1;
if ~ismember(i,err)
    seq=estraggo(data,dhour,i,variabili.righe);
    sequenze{i,1}=seq;
end
for i=2:size(dhour,2)-1
    seq=estraggo(data,dhour,i,variabili.righe);
    sequenze{i,1}=seq;
    if ismember(i,err)
        sequenze{i,1}=[];
    end
end
% panel_power= pp_dy (sequenze);
%% creo sequenze di "lasso" giorni scalate di "span"

treshold_lasso_max=treshold*lasso;
seq_def={};
i=1;
j=size(sequenze,1);
while j-lasso+1>0                   % estraggo sequenze da 6 giorni,interrompo quando i dati rimanenti sono troppo pochi per fare una sequenza da 6 giorni
    seq=[];
    for k=lasso-1:-1:0
        seq=[seq sequenze{j-k,1}];
    end
    if ~isempty(seq)
        dati=crea_struct(seq,variabili.nb);
        seq_def{i,1}=dati;
        i=i+1;
    end
    j=j-span;
end
[~,~,d6,~]=durata_seq(seq_def,treshold_lasso_max,">=");     % trovo le sequenze più lunghe di 6 giorni
seq_def(d6,:)=[];                                           % e le elimino
[seq_def] = picchi_anomali(seq_def,variabili);  % trovo le sequenze che presentano discontinuità sul min cellv che portano il valore istantaneamente sotto la soglia di 2000 mV

treshold_lasso_min=treshold*(lasso-1);
[~,~,d6,~]=durata_seq(seq_def,treshold_lasso_min,"<=");   %trovo le sequenze più corte di 5 giorni
seq_def(d6,:)=[];                               %e le elimino