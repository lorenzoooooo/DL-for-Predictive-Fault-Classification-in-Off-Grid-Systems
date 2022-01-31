% function [seq_def,variabili] = estrazione_sequenze(data,variabili)
span=1;
lasso=3;
%% Trovo le sequenze che sono più lunghe di 30 ore
% variabili.nome= ["min cell voltage";"panel power";"max cell voltage"];  %; "consumer current"
y={};
idx={};
for j=1:size(p,1)
    [dhour,d0]=mezzanotte(p{j,1}.time);
    d1=duration();
    for i=2:size(dhour,2)
        d1(i-1)= d0(i)-d0(i-1);
    end
    tolleranza=7;                    % metto un 20% di tolleranza
    treshold=24 + tolleranza;       
    treshold=hours(treshold);
    err=find(d1(1,:)>treshold); 
    
    %% Ottengo sequenze di 24 ore
    % variabili=discrimina(variabili);    % da l'indice delle righe corrispondenti alle variabili che vogliamo usare in base al tipo di torre
    % variabili.nb=string();              % contiene il nome delle variabili senza spazi
    % for i=1:size(variabili.nome,1)
    %     variabili.nb(i,1)=nome_cartella(variabili.nome(i,1));
    % end
%     sequenze={};
    i=1;
    temp=[];
    for i=1:size(dhour,2)-1
        if ~ismember(i,err)
            temp=[temp dhour(i)];
        end
    %     seq=estraggo(data,dhour,i,variabili.righe);
    %     sequenze{i,1}=seq;
    %     if ismember(i,err)
    %         sequenze{i,1}=[];
    %     end
    end
    idx{j,1}=p{j,1}.time(temp);
    y{j,1}=temp;
end
for i = 1:size(p,1)
    x(i)=size(y{i,1},2);
end
[~, aa]=max(x);
idx=idx{aa,1};
idx.Second=00;
idx.Minute=00;
idx.Hour=00;
idx.Format='dd-MMM-yyy'; 
seq={};
counter=1;
for i=1:size(idx,2)
    a=idx(i);
    b=find(idx==idx(i)+1);
    c=find(idx==idx(i)+2);
    d=find(idx==idx(i)+3);
    if ~isempty(b) && ~isempty(c) && ~isempty(d)
        a=find(nuova_struct.time==a,1);
        d=find(nuova_struct.time==idx(i)+3,1);
        if ~isempty(a) && ~isempty(d)
            seq{counter,1}.time=nuova_struct.time(a:d);
            for k=1:size(p,1)
                seq{counter,1}.(p{k,1}.name)= nuova_struct.(p{k,1}.name)(a:d);
            end
            counter=counter+1;
        end
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

% duration(datetime(2021,11,27,01,24,06)-datetime(2021,07,02,05,24,28));
% a=ans;
% a=seconds(a);
% b=floor(a/900);
% x=find(coord{1,1}.time==datetime(2021,11,27,01,24,06));
% y=find(coord{1,1}.time==datetime(2021,07,02,05,24,28));
% c=x-y;
% 
% 
% x= convertTo(coord{1,1}.time,'excel');
% % j=[datetime(2021,11,27,01,24,06), datetime(2021,11,27,01,24,07)];
% % i=convertTo(j,'excel');
% % i=i(2)-i(1);
% y=coord{1,1}.value;
% z=[x(1):i:x(end)];
% a=interp1(x,y,z);
% j=[datetime(2021,11,27,01,15,0), datetime(2021,11,27,01,30,00)];
% i=convertTo(j,'excel');
% i=i(2)-i(1);
% c=[x(1):i:x(end)];
% b1=interp1(z,a,c);
% c=datetime(c,'ConvertFrom','excel');