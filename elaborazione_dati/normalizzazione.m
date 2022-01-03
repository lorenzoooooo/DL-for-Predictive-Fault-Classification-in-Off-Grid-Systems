function sequenze = normalizzazione(data,sequenze,variabili)
global name;
righe=discrimina(variabili);
media=[];
dev_std=[]; 
for j=1:size(righe,2)
    k=j+1;
    media(k,1)=mean(data(righe(j),:));
    dev_std(k,1)=std(data(righe(j),:));
end
for i=1:size(sequenze,1)
    seq=sequenze{i,1};
    for j=2:size(seq,1)
        seq(j,:)=(seq(j,:)-media(j,1))/dev_std(j,1);
    end
    sequenze{i,1}=seq;
end