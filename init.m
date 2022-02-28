function [sqldata, bozza_dati, p, nuova_struct]=init(sqldata_grezzo)
global tipo name torre;
name=input('se la box NON è munita di stazione meteo scrivi var_iotbox, sennò var:','s');
load(name,name);
ref=eval(name);
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
sqldata=sqldata_grezzo;
switch torre
    case "t13008"
        t=find(sqldata{:,1}=="2021-08-11 00:08:52.0",1);
        sqldata([1:t-1],:)=[];
    case "t1025"
        t=find(sqldata{:,1}=="2021-07-02 00:09:27.0",1);
        sqldata([1:t-1],:)=[];
    case "t16399"
        t=find(sqldata{:,1}=="2021-09-23 00:07:31.0",1);
        sqldata([1:t-1],:)=[];
        t1=find(sqldata{:,1}=="2021-11-18 16:08:53.0",1);
        t2=find(sqldata{:,1}=="2021-11-18 16:08:54.0",1,'last');
        sqldata([t1:t2],:)=[];
    case "t7286"
        t=find(sqldata{:,1}=="2021-12-27 04:45:30.0",1);
        sqldata([t:end],:)=[];
end
time = datetime(sqldata{:,1});
time = convertTo(time,'excel');
time = transpose(time);
count = transpose(sqldata{:,2});
codice = transpose(sqldata{:,3});
diag= transpose(sqldata{:,4});
bozza_dati = {time;count;codice;diag};

% time = datetime(sqldata_grezzo{:,1});
% time = convertTo(time,'excel');
% time = transpose(time);
% count = transpose(sqldata_grezzo{:,2});
% codice = transpose(sqldata_grezzo{:,3});
% diag= transpose(sqldata_grezzo{:,4});
% bozza_dati= {time;count;codice;diag};
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

for i=1:size(coord,1)
    coord{i,1} = interpola(coord{i,1});
    p{i,1}=coord{i,1};
    p{i,1}.time=datetime(p{i,1}.time,'convertfrom','excel');
    coord{i,1} = traslazione(coord{i,1},max_timeout, std_freq);
    coord{i,1} = sovracampiona(coord{i,1},final_freq);
end

coord = allineo(coord);

nuova_struct.time=coord{1,1}.time;
for i=1:size(ref,1)
    coord{i,1}.name=nome_cartella(ref{i,1});
    p{i,1}.name=coord{i,1}.name;
    nuova_struct.(coord{i,1}.name)=coord{i,1}.value;
end

% 
% for i=1:size(coord,1)
%     figure;
% %     plot(p{i,1}.time,p{i,1}.value,'r');
% %     hold on;
%     plot(coord{i,1}.time, coord{i,1}.value,'b');
%     title(coord{i,1}.name);
% %     hold off;
% end
 
