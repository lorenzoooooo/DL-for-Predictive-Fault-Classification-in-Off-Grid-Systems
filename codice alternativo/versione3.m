function temp_data=versione3(temp_data,var)

b={};
b{1,1}=nan;
for i=2:size(var,1)+1
    b{i,1}=isnan(temp_data(i,:));          
    b{i,1}=find(b{i,1}==0,1);
end
b=cell2mat(b);
primo=max(b);
sottomatrice(1,1)=temp_data(1,primo);
for j=1:size(var,1)
    k=j+1;
    if ~isnan(temp_data(k,primo))                   % Se in questa colonna c'è un valore num allora sarà il valore iniziale della variabile j
        sottomatrice(k,1)=temp_data(k,primo);
        continue;
    end
    counter=isnan(temp_data(k,primo-1:-1:1));       % Altrimenti cerco il primo valore diverso da NaN
    counter=find(counter==0,1);
    counter=primo-counter;
    sottomatrice(k,1)=temp_data(k,counter);
end
temp_data(:,1:primo-1)=[];
temp_data(:,1)=sottomatrice;