function [idx_b, idx_g,a] = sospetti (sequenze)
global int_predizione;
global soglia_bad_mincellv soglia_good_mincellv soglia_bad_maxcellv soglia_good_maxcellv;
%% Etichetto le sequenze patologiche e sane. Patologiche sono quelle che precedono i 15 giorni prima dell'evento patologico
idx_b=[];
idx_g=[];
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

% if isfield(sequenze{1,1},'panelpower')
%     pp.bad.seq=cell(size(sequenze,1),1);
%     pp.good.seq=cell(size(sequenze,1),1);
%     pp.seq_mean=pp_dy(sequenze);
%     pp.global_mean=mean(pp.seq_mean);
%     pp.bad.soglia = pp.global_mean-pp.global_mean*0.4;                
%     pp.bad.idx=find(pp.seq_mean<pp.bad.soglia);  
%     if ~isempty(pp.bad.idx)
%         for i=1:size(pp.bad.idx,1)
%             if isempty(pp.bad.idx(i))
%                 continue;
%             end
%             pp.bad.seq{pp.bad.idx(i),1}=sequenze{pp.bad.idx(i),1};
%         end
%     end
% 
%     pp.good.soglia = pp.global_mean;                
%     pp.good.idx=find(pp.seq_mean > pp.good.soglia);  
%     if ~isempty(pp.good.idx)
%         for i=1:size(pp.good.idx,1)
%             if isempty(pp.good.idx(i))
%                 continue;
%             end
%             pp.good.seq{pp.good.idx(i),1}=sequenze{pp.good.idx(i),1};
%         end
%     end
% %     idx_b=[idx_b pp.bad.idx];
% %     idx_g=[idx_g pp.good.idx];
% end

if isfield(sequenze{1,1},'mincellvoltage')
    mincellv.bad.soglia=soglia_bad_mincellv;                                         % soglia critica patologica
    mincellv.good.soglia=soglia_good_mincellv;                                        % soglia critica sana
    mincellv.bad.idx=zeros(1,0);
    for i=1:size(sequenze,1)
        if isempty(sequenze{i,1})
            continue;
        end
        mincellv.mean(i)=mean(sequenze{i,1}.mincellvoltage);
        z=find(sequenze{i,1}.mincellvoltage<=mincellv.bad.soglia,1);
        if ~isempty(z)
            mincellv.bad.idx=[mincellv.bad.idx i];
        end
    end
%     mincellv.bad.idx=find(mincellv.mean < mincellv.bad.soglia); 
    mincellv.bad.seq=assegno_etichetta(mincellv.bad.idx,sequenze);
    mincellv.good.idx=find(mincellv.mean > mincellv.good.soglia);
    mincellv.good.seq=assegno_etichetta(mincellv.good.idx,sequenze);
    idx_b=[idx_b mincellv.bad.idx];
    idx_g=[idx_g mincellv.good.idx];
    a{1}=idx_b;
    a{2}=idx_g;
end

% if isfield(sequenze{1,1},'maxcellvoltage')
%     maxcellv.bad.soglia=soglia_bad_maxcellv;                                         % soglia critica patologica
%     maxcellv.good.soglia=soglia_good_maxcellv;                                        % soglia critica sana
%     for i=1:size(sequenze,1)
%         if isempty(sequenze{i,1})
%             continue;
%         end
%         maxcellv.mean(i)=mean(sequenze{i,1}.maxcellvoltage);
%     end
%     maxcellv.bad.idx=find(maxcellv.mean < maxcellv.bad.soglia);  
%     maxcellv.bad.seq=assegno_etichetta(maxcellv.bad.idx,sequenze);
%     maxcellv.good.idx=find(maxcellv.mean > maxcellv.good.soglia);
%     maxcellv.good.seq=assegno_etichetta(maxcellv.good.idx,sequenze);
% %     idx_b=[idx_b maxcellv.bad.idx];
% %     idx_g=[idx_g maxcellv.good.idx];
% end

%% se prendo le sequenze dalla prima fino all'ultima di bad.mincellv
int_pred=int_predizione;
counter=1;
for i=1:size(sequenze,1)
    if ismember(i,mincellv.bad.idx) 
        if i > int_pred
            x=sequenze{i}.time(1)-int_pred;
            y=sequenze{idx_b(counter)-int_pred}.time(1);
            if x==y
                idx_b=[idx_b idx_b(counter)-int_pred];
            else
                continue;
            end
        end
        counter=counter+1;
    end
end
idx_b=unique(idx_b);
idx_b=idx_b(idx_b>0);

counter=1;
for i=1:size(sequenze,1)
    if ismember(i,mincellv.good.idx)
        if i > int_pred
            x=sequenze{i}.time(1)-int_pred;
            y=sequenze{idx_g(counter)-int_pred}.time(1);
            if x==y
                idx_g=[idx_g idx_g(counter)-int_pred];
            else
                continue;
            end
        end
        counter=counter+1;
    end
end
idx_g=unique(idx_g);
idx_g=idx_g(idx_g>0);