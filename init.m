% global tipo name torre;
% name=input('se la box NON è munita di stazione meteo scrivi var_iotbox, sennò var:','s');
load(name,name);
ref=eval(name);
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
% time = convertTo(time,'excel');
% time = transpose(time);
% count = transpose(sqldata{:,2});
% codice = transpose(sqldata{:,3});
% diag= transpose(sqldata{:,4});
% bozza_dati = {time;count;codice;diag};
% clearvars time count codice diag;

%%
d=[datetime(2021,11,27,01,15,0), datetime(2021,11,27,01,30,00)];
d=convertTo(d,'excel');
std_freq=d(2)-d(1);             % 15 min
d=[datetime(2021,11,27,01,0,0), datetime(2021,11,27,01,20,00)];
d=convertTo(d,'excel');
max_timeout=d(2)-d(1);          % 20 min
d=[datetime(2021,11,27,01,19,0), datetime(2021,11,27,01,20,00)];
d=convertTo(d,'excel');
final_freq=d(2)-d(1);           % 1 min

coord=cell(size(ref,1),1);
for i=1:size(ref,1)
    mystruct.name=ref{i,1};
    idx= find(eq(bozza_dati{3,:}, ref{i,2}));
    mystruct.value=bozza_dati{2,1}(idx);
    mystruct.time=bozza_dati{1,1}(idx);
    mystruct.diag=bozza_dati{4,1}(idx);
    coord{i,1}=mystruct;
end
p=coord;

for i=1:size(coord,1)
    coord{i,1} = interpola(coord{i,1});
    coord{i,1} = traslazione(coord{i,1},max_timeout, std_freq);
    coord{i,1} = sovracampiona(coord{i,1},final_freq);
    p{i,1}.time=datetime(p{i,1}.time,'convertfrom','excel');
end

coord = allineo(coord);

nuova_struct.time=coord{1,1}.time;
for i=1:size(ref,1)
    coord{i,1}.name=nome_cartella(ref{i,1});
    nuova_struct.(coord{i,1}.name)=coord{i,1}.value;
end

% for i=1:size(coord,1)
%     figure;
%     plot(p{i,1}.time,p{i,1}.value,'r');
%     hold on;
%     plot(coord{i,1}.time, coord{i,1}.value,'b');
%     title(coord{i,1}.name);
%     hold off;
% end
 
clearvars mystruct idx i var_iotbox var ref
% addr=strcat(tipo,{'\'},{torre},{'\'},{torre});
% addr=char(addr);
% save(addr);