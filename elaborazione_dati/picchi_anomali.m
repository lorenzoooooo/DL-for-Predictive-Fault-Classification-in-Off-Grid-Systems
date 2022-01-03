function [cell_idx, mat_idx] = picchi_anomali (sequenze)
cell_idx=[];
mat_idx=[];
for i=1:size(sequenze,1)
    anomalie=find(sequenze{i,1}(2,:)<=2000);
    if ~isempty(anomalie)
        cell_idx=[cell_idx; i];
        mat_idx=[mat_idx; anomalie];
    end
end
