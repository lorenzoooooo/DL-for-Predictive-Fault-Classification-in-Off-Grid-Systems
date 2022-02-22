function [idx_b, idx_g,a] = sospetti (sequenze)
global int_predizione;
global soglia_bad_mincellv;
%% Etichetto le sequenze patologiche e sane. Patologiche sono quelle che precedono i 15 giorni prima dell'evento patologico
idx_b=zeros(1,0);
idx_g=zeros(1,0);

% if isfield(sequenze{1,1},'panelpower')
%     pp.bad.seq=cell(size(sequenze,1),1);
%     pp.good.seq=cell(size(sequenze,1),1);
%     pp.seq_mean=pp_dy(sequenze);
%     pp.global_mean=mean(pp.seq_mean);
%     pp.bad.soglia = pp.global_mean-pp.global_mean*0.4;                
%     pp.bad.idx=find(pp.seq_mean<pp.bad.soglia);              
%     pp.good.idx=find(pp.seq_mean > pp.good.soglia);  % da rifare
% end

if isfield(sequenze{1,1},'mincellvoltage')
    mincellv.bad.soglia=soglia_bad_mincellv;                                         % soglia critica patologica                                        % soglia critica sana
    mincellv.bad.idx=zeros(1,0);
    mincellv.good.idx=zeros(1,0);
    for i=1:size(sequenze,1)
        z=find(sequenze{i,1}.mincellvoltage<=mincellv.bad.soglia,1);
        if ~isempty(z)
            mincellv.bad.idx=[mincellv.bad.idx i];
        else
            mincellv.good.idx=[mincellv.good.idx i];
        end
    end
    a{1}=mincellv.bad.idx;
    a{2}=mincellv.good.idx;
    if ~isempty(mincellv.bad.idx)
        i=mincellv.bad.idx(1);
        j=find(mincellv.bad.idx==i);
        counter=1;
        while i<mincellv.bad.idx(end)
            e=mincellv.bad.idx(j+1);
            if e~=mincellv.bad.idx(j)+counter
                i=mincellv.bad.idx(j+1);
                counter=1;
                j=find(mincellv.bad.idx==i);
            else
                mincellv.bad.idx(j+1)=[];
                counter=counter+1;
            end
        end
    end
%     if ~isempty(mincellv.good.idx)
%         i=mincellv.good.idx(1);
%         j=find(mincellv.good.idx==i);
%         counter=1;
%         while i<mincellv.good.idx(end)
%             e=mincellv.good.idx(j+1);
%             if e~=mincellv.good.idx(j)+counter
%                 i=mincellv.good.idx(j+1);
%                 counter=1;
%                 j=find(mincellv.good.idx==i);
%             else
%                 mincellv.good.idx(j+1)=[];
%                 counter=counter+1;
%             end
%         end
%     end
end


%% se prendo le sequenze dalla prima fino all'ultima di bad.mincellv
%  int_pred=int_predizione;
% counter=1;
% for i=1:size(sequenze,1)
%     if ismember(i,mincellv.bad.idx) 
%         if i > int_pred(2)
%             x=sequenze{i}.time(1)-int_pred(1);
%             y=sequenze{mincellv.bad.idx(counter)-int_pred(1)}.time(1);
%             v=sequenze{i}.time(1)-int_pred(2);
%             w=sequenze{mincellv.bad.idx(counter)-int_pred(2)}.time(1);
%             if x==y && v==w
%                 idx_b=[idx_b [(mincellv.bad.idx(counter)-int_pred(2)):(mincellv.bad.idx(counter)-int_pred(1))]];
%             end
%         end
%         counter=counter+1;
%     end
% end
% idx_b=unique(idx_b);
% idx_b=idx_b(idx_b>0);

counter=1;
for i=1:size(sequenze,1)
    if ismember(i,mincellv.bad.idx)
        j=int_predizione(1);
        k=int_predizione(1);
        if i<=int_predizione(2) & i>=int_predizione(1)
            while k<i
                x=sequenze{i}.time(1)-k;
                y=sequenze{mincellv.bad.idx(counter)-j}.time(1);
                if x==y
                    idx_b=[idx_b mincellv.bad.idx(counter)-j];
                    j=j+1;
                    k=k+1;
                elseif (j+x-y)<i
                    idx_b=[idx_b mincellv.bad.idx(counter)-j];
                    j=j+1;
                    k=k+x-y;
                else
                    break;
                end
            end
        elseif i>int_predizione(2)
            while k<int_predizione(2)
                x=sequenze{i}.time(1)-k;
                y=sequenze{mincellv.bad.idx(counter)-j}.time(1);
                if x==y
                    idx_b=[idx_b mincellv.bad.idx(counter)-j];
                    j=j+1;
                    k=k+1;
                elseif (j+x-y)<int_predizione(2)
                    idx_b=[idx_b mincellv.bad.idx(counter)-j];
                    j=j+1;
                    k=k+x-y;
                else
                    break;
                end
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
        if i<=int_predizione(2) & i>=int_predizione(1)
            j=int_predizione(1);
            k=int_predizione(1);
            while k<i
                x=sequenze{i}.time(1)-k;
                y=sequenze{mincellv.good.idx(counter)-j}.time(1);
                if x==y
                    idx_g=[idx_g mincellv.good.idx(counter)-j];
                    j=j+1;
                    k=k+1;
                elseif (j+x-y)<i
                    idx_g=[idx_g mincellv.good.idx(counter)-j];
                    j=j+1;
                    k=k+x-y;
                else
                    break;
                end
            end
        elseif i>int_predizione(2)
            j=int_predizione(1);
            k=int_predizione(1);
            while k<int_predizione(2)
                x=sequenze{i}.time(1)-k;
                y=sequenze{mincellv.good.idx(counter)-j}.time(1);
                if x==y
                    idx_g=[idx_g mincellv.good.idx(counter)-j];
                    j=j+1;
                    k=k+1;
                elseif (j+x-y)<int_predizione(2)
                    idx_g=[idx_g mincellv.good.idx(counter)-j];
                    j=j+1;
                    k=k+x-y;
                else
                    break;
                end
            end
        end
        counter=counter+1;
    end
end
idx_g=unique(idx_g);
idx_g=idx_g(idx_g>0);

% counter=1;
% for i=1:size(sequenze,1)
%     if ismember(i,mincellv.good.idx)
%         if i > int_pred(2)
%             x=sequenze{i}.time(1)-int_pred(1);
%             y=sequenze{mincellv.good.idx(counter)-int_pred(1)}.time(1);
%             v=sequenze{i}.time(1)-int_pred(2);
%             w=sequenze{mincellv.good.idx(counter)-int_pred(2)}.time(1);
%             if x==y && v==w
%                 idx_g=[idx_g [(mincellv.good.idx(counter)-int_pred(2)):(mincellv.good.idx(counter)-int_pred(1))]];
%             end
%         end
%         counter=counter+1;
%     end
% end
% idx_g=unique(idx_g);
% idx_g=idx_g(idx_g>0);