% t### è una tabella 
clearvars -except sqldata;
global tipo name torre;
name=input('se la box NON è munita di stazione meteo scrivi var_iotbox, sennò var:','s');
load(name,name);
var=eval(name);
torre=input('numero della torre preceduto da t:','s');
if name == "var"
    tipo=input('Se è un digil puro scrivi digil senno scrivi iotbox-digil:','s');
    if not(isfolder(strcat(tipo,{'\'},{torre})))
        mkdir(string(strcat(tipo,{'\'},{torre})));
    end
elseif name == "var_iotbox"
    tipo="iotbox";
    if not(isfolder(strcat(tipo,{'\'},{torre})))
        mkdir(string(strcat(tipo,{'\'},{torre})));
    end
end
time = datetime(sqldata{:,1});
% time = convertTo(time,'excel');
time = transpose(time);
count = transpose(sqldata{:,2});
codice = transpose(sqldata{:,3});
diag= transpose(sqldata{:,4});
bozza_dati = {time;count;codice;diag};
clearvars time count codice diag;

%% prima versione della bozza di dati
 
temp_data=versione1(bozza_dati,var);

%% Seconda versione della bozza di dati. compatto tutte le colonne di campioni riguardanti lo stesso istante

[temp_data,bug,bug_idx]=versione2(temp_data,var);
 
%% Creo una colonna iniziale con i valori per tutte le variabili
 
temp_data=versione3(temp_data,var);

%% sostituisco NaN con il valore precedente diverso da zero più vicino
sottomatrice=temp_data(:,1);
data=[];
if name == "var"
    energy_idx=find(var{:,3}==2);
    energy_idx=energy_idx+1;
    meteo_idx=find(var{:,3}==1);
    meteo_idx=meteo_idx+1;
end
for i=2:size(temp_data,2)
    data=[data sottomatrice];
    c=~isnan(temp_data(2:end,i));
    sottomatrice(1,1)=temp_data(1,i);
%     if ~c                                                      %se tt i val sulla colonna sono diversi da NaN
%         sottomatrice=temp_data(:,i);
%         continue
%     end
    if ~c(meteo_idx)                                            %se tutte le variabili della centralina meteo sono NaN allora, se i valori delle altre variabili sono NaN vuol dire non sono variati rispetto all'ultimo campione e quindi riscrivo l'ultimo campione
        sottomatrice(meteo_idx,1)=NaN;
        for j=1:size(energy_idx)
             if c(energy_idx(j))                                %se il valore non è NaN passo alla prossima riga
                 sottomatrice(energy_idx(j),1)=temp_data(energy_idx(j),i);
                 continue
             else                                               %altrimenti ricopio l'ultimo campione diverso da NaN
                 counter=isnan(temp_data(energy_idx(j),i-1:-1:1));
                 counter=find(counter==0,1);
                 counter=i-counter;                             %colonna della variabile con valore numerico
                 sottomatrice(energy_idx(j),1)=temp_data(energy_idx(j),counter);
             end
        end
    elseif c(meteo_idx)                                                        %se almeno una delle variabili della centralina meteo è diversa da NaN allora ricopio la matrice
        if c(energy_idx)==zeros(size(energy_idx)) & i~=size(temp_data,2)
            sottomatrice(:,1)=temp_data(:,i);
        else
            sottomatrice(meteo_idx,1)=temp_data(meteo_idx,i);
            for j=3:size(temp_data,1)
                if c(j)                                         %se il valore non è NaN passo alla prossima riga
                    sottomatrice(j,1)=temp_data(j,i);
                    continue
                else                                %altrimenti ricopio l'ultimo campione diverso da NaN
                    counter=isnan(temp_data(j,i-1:-1:1));
                    counter=find(counter==0,1);
                    counter=i-counter;              %colonna della variabile con valore numerico
                    sottomatrice(j,1)=temp_data(j,counter);
                end
             end
        end
    else
        for j=1:size(meteo_idx)
             if c(meteo_idx(j))                                %se il valore non è NaN passo alla prossima riga
                 sottomatrice(meteo_idx(j),1)=temp_data(meteo_idx(j),i);
                 continue
             else                                               %altrimenti ricopio l'ultimo campione diverso da NaN
                 counter=isnan(temp_data(meteo_idx(j),i-1:-1:1));
                 counter=find(counter==0,1);
                 counter=i-counter;                             %colonna della variabile con valore numerico
                 sottomatrice(meteo_idx(j),1)=temp_data(meteo_idx(j),counter);
             end
        end 
    end
end
data=[data sottomatrice];

%% interpolo i valori NaN che corrispondono all'asincronità dei pacchetti

x=[1:size(data,2)];
c=[];
y=[];
p=[];
p(1,:)=data(1,:);
c=~isnan(data(2,:));
c1=find(c);                             %valori campionati di irradiazione
c0=find(c==0);                          %valori NaN di irradiazione
y=data(2,:);
p(2,:)=interp1(x(c1),y(c1),x,'linear'); %interpolo valori irradiazione
for k=3:size(data,1)                    %interpolo valori var energy management
    y=data(k,:);
    c_k=~isnan(data(k,:));
    c1_k=find(c_k);
    p(k,:)=interp1(x(c1_k),y(c1_k),x,'linear');
end
data=p;

%% aggiungo correzione anomalie
anomalie=find(data(3,:)<=2500);
for i=1:size(anomalie,2)
    data(2:end,anomalie(i))=data(2:end,anomalie(i)-1);
end