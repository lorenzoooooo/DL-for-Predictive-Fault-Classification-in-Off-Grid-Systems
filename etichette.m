
function [X,Y]= etichette(idx_b,idx_g, sequenze)
X={};
Y={};
k=1;
for j=1:size(sequenze,1)
    sequenze{j,1}=rmfield(sequenze{j,1},"time");
    if ismember(j,idx_b)
        [~,b]=ismember(j,idx_b);
        X{k,1}=cell2mat(struct2cell(sequenze{idx_b(b),1}));
        Y{k,1}='0';
        k=k+1;
    elseif ismember(j,idx_g)
        [~,b]=ismember(j,idx_g);
        X{k,1}=cell2mat(struct2cell(sequenze{idx_g(b),1}));
        Y{k,1}='1';
        k=k+1;
    end
end
Y=categorical(Y);