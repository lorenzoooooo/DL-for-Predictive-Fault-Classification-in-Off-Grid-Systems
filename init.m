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
% time = datetime(sqldata{:,1});
% % time = convertTo(time,'excel');
% time = transpose(time);
% count = transpose(sqldata{:,2});
% codice = transpose(sqldata{:,3});
% diag= transpose(sqldata{:,4});
% bozza_dati = {time;count;codice;diag};
% clearvars time count codice diag;

%%
coord=cell(size(var,1),1);
for i=1:size(var,1)
    mystruct.name=var{i,1};
    idx= find(eq(bozza_dati{3,:}, var{i,2}));
    mystruct.value=bozza_dati{2,1}(idx);
    mystruct.time=bozza_dati{1,1}(idx);
    mystruct.diag=bozza_dati{4,1}(idx);
    coord{i,1}=mystruct;
end

