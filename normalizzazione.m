function sequenze = normalizzazione(nuova_struct,sequenze,variabili)
media=[];
dev_std=[]; 
start=find(convertTo(nuova_struct.time,'excel')==sequenze{1,1}.time(1));
finish=find(convertTo(nuova_struct.time,'excel')==sequenze{end,1}.time(end));
for j=1:size(variabili.nb,1)
    media(j,1)=mean(nuova_struct.(variabili.nb(j))(start:finish));
    dev_std(j,1)=std(nuova_struct.(variabili.nb(j))(start:finish));
end
for i=1:size(sequenze,1)
    for j=1:size(sequenze{i,1}.time,2)
        for k=1:size(variabili.nb,1)
            sequenze{i,1}.(variabili.nb(k))(j)=(sequenze{i,1}.(variabili.nb(k))(j)-media(k,1))/dev_std(k,1);
        end
    end
end