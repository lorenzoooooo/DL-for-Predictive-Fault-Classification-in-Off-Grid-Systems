% % t### è una tabella 
% clearvars -except sqldata;
% global tipo name torre;
% name=input('se la box NON è munita di stazione meteo scrivi var_iotbox, sennò var:','s');
load(name,name);
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
% time = datetime(sqldata{:,1});
% % time = convertTo(time,'excel');
% time = transpose(time);
% count = transpose(sqldata{:,2});
% codice = transpose(sqldata{:,3});
% diag= transpose(sqldata{:,4});
% bozza_dati = {time;count;codice;diag};
% clearvars time count codice diag;
%%
std_freq=900;
max_timeout=seconds(1200);

coord=cell(size(var,1),1);
for i=1:size(var,1)
    mystruct.name=var{i,1};
    idx= find(eq(bozza_dati{3,:}, var{i,2}));
    mystruct.value=bozza_dati{2,1}(idx);
    mystruct.time=bozza_dati{1,1}(idx);
    mystruct.diag=bozza_dati{4,1}(idx);
    coord{i,1}=mystruct;
end

for j=1:size(coord,1)
    int=diff(coord{j,1}.time);                         % differenza tra 2 campioni consecutivi: X(2)-X(1)
%     int_q=floor(seconds(int),std_freq);
    int_idx=find(int>max_timeout)+1;                   % voglio l'indice del campione X(2)
    no_diag=[];
    for i=1:size(int_idx,2)
        if coord{j,1}.diag(int_idx(i))==0              % trovo di int_idx quei campioni che hanno diag=0
            no_diag=[no_diag int_idx(i)];
        end
    end
    p{j,1}=coord{j,1};
    d{j,1}=no_diag;
    for i=1:size(no_diag,2)-1
        coord = inserisci(coord,no_diag,std_freq,i,j);
        no_diag(i+1:end)=no_diag(i+1:end)+1;    %ogni volta che inserisco una colonna incremento l'indice delle colonne seguenti di 1
    end
    coord = inserisci(coord,no_diag,std_freq,i,j);
    unchanged{j,1}=no_diag;
end


for j=1:size(coord,1)
%     b=48;
%     a=find(p.time==coord{10,1}.time(b));
    figure;
    plot(coord{j,1}.time, coord{j,1}.value,'b');
    hold on;
    plot(p{j,1}.time,p{j,1}.value);
    title(coord{j,1}.name);
    hold off;
end

% addr=strcat(tipo,{'\'},{torre},{'\'},{torre});
% addr=char(addr);
% save(addr);