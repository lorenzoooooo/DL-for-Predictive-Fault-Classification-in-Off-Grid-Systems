function [d1,d2,d3,empty]=durata_seq(sequenze,treshold,op)
numele=size(sequenze,1);   
d1=datetime(); 
d2=duration();
notempty=[];
for i=1:numele
    notempty(i)=~isempty(sequenze{i,1});
    if notempty(i)
        [d1(i,1),d1(i,2)]=date_conversion(sequenze{i,1}.time(1),sequenze{i,1}.time(end));
        d2(i,1)=d1(i,2)-d1(i,1);
    end
end
if op=="<="
    d3=find(d2 <= treshold);
elseif op==">="
    d3=find(d2 >= treshold);
end
empty=~notempty;
