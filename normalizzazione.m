function sequenze = normalizzazione(data,sequenze,variabili)
media=[];
dev_std=[]; 
for j=1:size(variabili.righe,1)
    media(j,1)=mean(data(variabili.righe(j),:));
    dev_std(j,1)=std(data(variabili.righe(j),:));
end
for i=1:size(sequenze,1)
    for j=1:size(sequenze{i,1}.time,2)
        for k=1:size(variabili.nb,1)
            sequenze{i,1}.(variabili.nb(k))(j)=(sequenze{i,1}.(variabili.nb(k))(j)-media(k,1))/dev_std(k,1);
        end
    end
end