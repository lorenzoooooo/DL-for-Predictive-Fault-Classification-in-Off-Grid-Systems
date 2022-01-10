function variabili = discrimina (variabili)
global name;
variabili.righe=[];
var={};
if name =="var"
    load('var.mat');
    for i=1:size(var,1)
        for j=1:size(variabili.nome,1)
            if variabili.nome(j)==var{i,1}
                variabili.righe = [variabili.righe; i];
            end
        end
    end
elseif name =="var_iotbox"
    load('var_iotbox.mat');
    for i=1:size(var_iotbox,1)
        for j=1:size(variabili.nome,1)
            if variabili.nome(j)==var_iotbox{i,1}
                variabili.righe = [variabili.righe; i];
            end
        end
    end
end
variabili.righe=variabili.righe+1;      %la prima riga è per il timestamp