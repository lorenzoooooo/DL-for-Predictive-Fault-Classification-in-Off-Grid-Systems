%% inizializzo i dati (formo una colonna con valori diversi da 0 per tutte le variabili)
%parto dal primo valore diverso da NaN dell'irradiazione
b={};
b{1,1}=nan;
for i=2:righe_var+1
    b{i,1}=isnan(bozza_dati(i,:));          
    b{i,1}=find(b{i,1}==0);
    b{i,1}=b{i,1}(1,1);
end
b=cell2mat(b);
[primo,idx_primo]=max(b);
sottomatrice(1,1)=bozza_dati(1,primo);
i=primo;
for j=1:righe_var
    k=j+1;
    if ~isnan(bozza_dati(k,i))
        sottomatrice(k,1)=bozza_dati(k,i);
        continue;
    end
    counter=isnan(bozza_dati(k,i-1:-1:1));
    counter=find(counter==0,1);
    counter=i-counter; %colonna della variabile con valore numerico
    sottomatrice(k,1)=bozza_dati(k,counter);
end      
temp_data=bozza_dati;

%% sostituisco NaN con il valore precedente diverso da zero più vicino

start_idx=isnan(temp_data(2,:));
start_idx=find(start_idx==0,1);
temp_data(:,1:start_idx-1)=[];
temp_data(:,1)=sottomatrice;
data=[];
for i=2:size(temp_data,2)
    data=[data sottomatrice];
    c=~isnan(temp_data(:,i));
    sottomatrice(1,1)=temp_data(1,i);
    if c                            %se tt i val sulla colonna sono diversi da NaN
        sottomatrice=temp_data(:,i);
        continue
    end
    if c(2)==0                      %se l'irradiazione è NaN allora, se i valori delle altre variabili sono NaN vuol dire non sono variati rispetto all'ultimo campione e quindi riscrivo l'ultimo campione
        sottomatrice(2,1)=NaN;
        for j=3:size(temp_data,1)
             if c(j)                %se il valore non è NaN passo alla prossima riga
                 sottomatrice(j,1)=temp_data(j,i);
                 continue
             else                   %altrimenti ricopio l'ultimo campione diverso da NaN
                 counter=isnan(temp_data(j,i-1:-1:1));
                 counter=find(counter==0,1);
                 counter=i-counter; %colonna della variabile con valore numerico
                 sottomatrice(j,1)=temp_data(j,counter);
             end
        end
    else                            %se l'irradiazione è diverso da NaN allora ricopio la matrice
        if c(3:end)==zeros(size(c(3:end))) & i~=size(temp_data,2)
            sottomatrice(:,1)=temp_data(:,i);
        else
            sottomatrice(2,1)=temp_data(2,i);
            for j=3:size(temp_data,1)
                if c(j)                %se il valore non è NaN passo alla prossima riga
                    sottomatrice(j,1)=temp_data(j,i);
                    continue
                else                   %altrimenti ricopio l'ultimo campione diverso da NaN
                    counter=isnan(temp_data(j,i-1:-1:1));
                    counter=find(counter==0,1);
                    counter=i-counter; %colonna della variabile con valore numerico
                    sottomatrice(j,1)=temp_data(j,counter);
                end
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