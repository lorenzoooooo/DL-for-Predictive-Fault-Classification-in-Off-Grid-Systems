function [idx_b, idx_g] = sospetti (sequenze)
global name;
%% Etichetto le sequenze patologiche e sane. Patologiche sono quelle che precedono i 15 giorni prima dell'evento patologico


%     mean_dy=[];
%     dy_idx=[];
%     for i=1:size(sequenze,1)
%         if isempty(sequenze{i,1})
%             continue;
%         end
%         mean_dy(i)=mean(sequenze{i,1}(4,:));
%     end
%     media=mean(mean_dy);
%     soglia = media-media*0.4;                %soglia critica (<60% dy) al di dotto del quale la sequenze di dy è patologica
%     dy_idx=find(mean_dy<soglia);  
%     if ~isempty(dy_idx)
%         for i=1:size(dy_idx,2)
%             if isempty(dy_idx(1,i))
%                 continue;
%             end
%             bad.dy{dy_idx(1,i),1}=sequenze{dy_idx(1,i),1};
%         end
%     end

    pp.bad.seq=cell(size(sequenze,1),1);
    pp.good.seq=cell(size(sequenze,1),1);
    pp.seq=pp_dy(sequenze);
    pp.mean=mean(pp.seq(:,2));
    pp.bad.soglia = pp.mean-pp.mean*0.4;                %soglia critica (<60% dy) al di dotto del quale la sequenze di dy è patologica
    pp.bad.idx=find(pp.seq(:,2)<pp.bad.soglia);  
    if ~isempty(pp.bad.idx)
        for i=1:size(pp.bad.idx,1)
            if isempty(pp.bad.idx(i))
                continue;
            end
            pp.bad.seq{pp.bad.idx(i),1}=sequenze{pp.bad.idx(i),1};
        end
    end

    pp.good.soglia = pp.mean;                %soglia critica (<60% dy) al di dotto del quale la sequenze di dy è patologica
    pp.good.idx=find(pp.seq(:,2) > pp.good.soglia);  
    if ~isempty(pp.good.idx)
        for i=1:size(pp.good.idx,1)
            if isempty(pp.good.idx(i))
                continue;
            end
            pp.good.seq{pp.good.idx(i),1}=sequenze{pp.good.idx(i),1};
        end
    end

    mincellv.bad.soglia=3200;                                         % soglia critica patologica
    mincellv.good.soglia=3350;                                        % soglia critica sana
    for i=1:size(sequenze,1)
        if isempty(sequenze{i,1})
            continue;
        end
        mincellv.mean(i)=mean(sequenze{i,1}(2,:));
    end
    mincellv.bad.idx=find(mincellv.mean < mincellv.bad.soglia);  
    mincellv.bad.seq=assegno_etichetta(mincellv.bad.idx,sequenze);
    mincellv.good.idx=find(mincellv.mean > mincellv.good.soglia);
    mincellv.good.seq=assegno_etichetta(mincellv.good.idx,sequenze);

    maxcellv.bad.soglia=3200;                                         % soglia critica patologica
    maxcellv.good.soglia=3350;                                        % soglia critica sana
    for i=1:size(sequenze,1)
        if isempty(sequenze{i,1})
            continue;
        end
        maxcellv.mean(i)=mean(sequenze{i,1}(4,:));
    end
    maxcellv.bad.idx=find(maxcellv.mean < maxcellv.bad.soglia);  
    maxcellv.bad.seq=assegno_etichetta(maxcellv.bad.idx,sequenze);
    maxcellv.good.idx=find(maxcellv.mean > maxcellv.good.soglia);
    maxcellv.good.seq=assegno_etichetta(maxcellv.good.idx,sequenze);


%% se prendo le sequenze dalla prima fino all'ultima di bad.mincellv

idx_b=[];
i=1;
int_pred=26;
int_pred=duration(int_pred,0,0);    %%facciamo conto che predico a 15 giorni
for i=1:size(mincellv.bad.seq,1)
    if (~isempty(mincellv.bad.seq{i,1}) && i<size(mincellv.bad.seq,1)) || (~isempty(maxcellv.bad.seq{i,1}) && i<size(maxcellv.bad.seq,1))  || (~isempty(pp.bad.seq{i,1}) && i<size(pp.bad.seq,1))
        idx_b=[idx_b i];
        d1=datetime(sequenze{i,1}(1,1),'ConvertFrom','excel');
        d0=datetime(sequenze{i+1,1}(1,1),'ConvertFrom','excel');
        d=d1-d0;
        counter=1;
        while (d <= int_pred) && ((i+1+counter) <= size(mincellv.bad.seq,1))
            idx_b=[idx_b i+counter];
            d0=datetime(sequenze{i+1+counter,1}(1,1),'ConvertFrom','excel');
            d=d1-d0;
            counter=counter+1;
        end
        idx_b=[idx_b i+counter];
    end
end
idx_b=unique(idx_b);

idx_g=[];
for i=1:size(mincellv.good.seq,1)
    if (~isempty(mincellv.good.seq{i,1}) && i<size(mincellv.good.seq,1)) || (~isempty(maxcellv.good.seq{i,1}) && i<size(maxcellv.good.seq,1)) ||  (~isempty(pp.good.seq{i,1}) && i<size(pp.good.seq,1))
        idx_g=[idx_g i];
        d1=datetime(sequenze{i,1}(1,1),'ConvertFrom','excel');
        d0=datetime(sequenze{i+1,1}(1,1),'ConvertFrom','excel');
        d=d1-d0;
        counter=1;
        while (d <= int_pred) && ((i+1+counter) <= size(mincellv.good.seq,1))
            idx_g=[idx_g i+counter];
            d0=datetime(sequenze{i+1+counter,1}(1,1),'ConvertFrom','excel');
            d=d1-d0;
            counter=counter+1;
        end
        idx_g=[idx_g i+counter];
    end
end
idx_g=unique(idx_g);