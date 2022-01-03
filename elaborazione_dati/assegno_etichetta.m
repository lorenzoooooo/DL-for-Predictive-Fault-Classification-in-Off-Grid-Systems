function seq = assegno_etichetta (idx,sequenze)
seq=cell(size(sequenze,1),1);
if ~isempty(idx)
        for i=1:size(idx,2)
            if isempty(idx(1,i))
                continue;
            end
            seq{idx(1,i),1}=sequenze{idx(1,i),1};
        end
    end
