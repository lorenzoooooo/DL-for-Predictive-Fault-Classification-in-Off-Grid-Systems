function righe = discrimina (variabili)
global name;
righe=[];
var={};
if name =="var"
    load('var.mat');
    for i = 1:size(var,1)
        for j=1:size(variabili,1)
            if variabili(j)==var{i,1}
                righe = [righe i];
            end
        end
    end
elseif name =="var_iotbox"
    load('var_iotbox.mat');
    for i = 1:size(var_iotbox,1)
        for j=1:size(variabili,1)
            if variabili(j)==var_iotbox{i,1}
                righe = [righe i];
            end
        end
    end
end
righe=righe+1;      %la prima riga è per il timestamp