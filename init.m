% % t### è una tabella 
% clearvars -except sqldata;
% global tipo name torre;
% name=input('se la box NON è munita di stazione meteo scrivi var_iotbox, sennò var:','s');
% load(name,name);
% var=eval(name);
% torre=input('numero della torre preceduto da t:','s');
% if name == "var"
%     tipo=input('Se è un digil puro scrivi digil senno scrivi iotbox-digil:','s');
%     if not(isfolder(strcat(tipo,{'\'},{torre})))
%         mkdir(string(strcat(tipo,{'\'},{torre})));
%     end
% elseif name == "var_iotbox"
%     tipo="iotbox";
%     if not(isfolder(strcat(tipo,{'\'},{torre})))
%         mkdir(string(strcat(tipo,{'\'},{torre})));
%     end
% end
time = datetime(sqldata{:,1});
time = convertTo(time,'excel');
time = transpose(time);
count = transpose(sqldata{:,2});
codice = transpose(sqldata{:,3});
bozza_dati = {time;count;codice};

temp_data=versione1(bozza_dati,var);

% data=temp_data;
%% compatto tutte le colonne di campioni riguardanti lo stesso istante
col=2;
counter=1;
bozza_dati=temp_data(:,1);
y=zeros;
bug_addr=strcat(tipo,{'\'},{torre},'\bug.txt');
bug_addr=char(bug_addr);
fileID = fopen(bug_addr,'w');
fprintf(fileID,'coordinate delle variabili che hanno diversi campioni allo stesso istante di tempo\n');
fprintf(fileID,'cerca in bug con le coordinate inserite in bug_idx per trovare le sequenze sospette:\n\tbug(bug_idx(1,1),bug_idx(1:2,2))\n\td=bug(1,bug_idx(1,2))\n\td1 = datetime(d,''ConvertFrom'',''excel'')\n');
bug_idx={};
while col<size(temp_data,2) %scelgo la colonna
    if temp_data(1,col)==temp_data(1,col+1)
        counter=find(temp_data(1,col)==temp_data(1,:)); %conto quante colonne rappresentano lo stesso istante
        sottomatrice=temp_data(:,counter); %estraggo la sottomatrice di dati rappresentanti lo stesso istante
        valori_NaN = isnan(sottomatrice);
        stringa_NaN=~zeros(1,size(sottomatrice,2));
        for j=1:righe_var
            k=j+1;
            if valori_NaN(k,:)== stringa_NaN %se una variabile non è stata sovrascritta passo alla riga seguente
                continue;
            else
                a=find(valori_NaN(k,:)==0);
                if size(a,2)>1
                    for h=1:size(a,2) %se size(a)>1 allora ci sono diversi valori allo stesso istante
                        fprintf(fileID,'(%d,%d)\n',k,col+a(1,h)-1);
                        y(1,h)=sottomatrice(k,a(1,h));
                        bug_idx=[bug_idx;[k,col+a(1,h)-1]];
                    end
                    fprintf(fileID,'\n');
                    sottomatrice(k,1)= mean(y,2); %il dato acquisito è la media dei campioni
                else
                    sottomatrice(k,1)=sottomatrice(k,a);
                end
            end
        end
        col=col+length(counter);
    else
        sottomatrice=temp_data(:,col);
        col=col+1;
    end
    bozza_dati=[bozza_dati sottomatrice(:,1)];
end
fclose(fileID);
bug=temp_data;
bug_idx=cell2mat(bug_idx); %visual(bug(1,1),bug(1:2,2))
clear sottomatrice;