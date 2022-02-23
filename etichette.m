% function [XTr,YTr,XTs,YTs,tr,ts]= etichette(idx_b,idx_g, sequenze)
%     YTr={};
%     XTr={};
%     XTs={};
%     YTs={};
%     tr.bad_idx=[];
%     tr.good_idx=[];
%     ts.bad_idx=[];
%     ts.good_idx=[];
%     global proporzione rapporto;
    %passo gli indici delle sequenze che identifico come patologiche e come sane
%     i_bad=[idx_b];
%     i_good=[idx_g];
    
    %% prova
    function [X,Y]= etichette(idx_b,idx_g, sequenze)
    global proporzione;
    X={};
    Y={};
    if size(idx_g,2)>proporzione*size(idx_b,2)
        idx_g=randsample(idx_g,proporzione*size(idx_b,2));
    end
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
    


%% nel caso in cui siano presenti sequenze negative e positive per una data torre
%     if ~isempty(i_bad)                                  % spartisco gli indici delle sequenze patologiche tra train e test
%         ts.bad_idx=randsample(i_bad,round(rapporto*size(i_bad,2)));
%         temp= find(~ismember(i_bad,ts.bad_idx));
%         tr.bad_idx=i_bad(temp);
%         if ~isempty(i_good)                             % spartisco gli indici delle sequenze sane tra train e test
%             ts.good_idx=randsample(i_good,round(rapporto*size(i_good,2)));
%             temp= find(~ismember(i_good,ts.good_idx));
%             tr.good_idx=i_good(temp);
%             if size(tr.good_idx,2)>proporzione*size(tr.bad_idx,2) && size(ts.good_idx,2)>proporzione*size(ts.bad_idx,2)
%                 tr.good_idx=randsample(tr.good_idx,proporzione*size(tr.bad_idx,2));
%                 ts.good_idx=randsample(ts.good_idx,proporzione*size(ts.bad_idx,2));
%             end
%         end
%     else
%         if ~isempty(i_good)
%             ts.good_idx=randsample(i_good,round(rapporto*size(i_good,2)));
%             temp= find(~ismember(i_good,ts.good_idx));
%             tr.good_idx=i_good(temp);
%             tr.good_idx=randsample(tr.good_idx,proporzione);
%             ts.good_idx=randsample(ts.good_idx,proporzione);
%         end
%     end
%     
%     % creo cell array XTrain e XTest contenenti le sequenze e assegno le
%     % etichette con gli array categorici YTrain e YTest
%     k=1;
%     h=1;
%     for j=1:size(sequenze,1)
%         sequenze{j,1}=rmfield(sequenze{j,1},"time");
%         if ismember(j,tr.bad_idx)
%             [~,b]=ismember(j,tr.bad_idx);
%             XTr{k,1}=cell2mat(struct2cell(sequenze{tr.bad_idx(b),1}));
%             YTr{k,1}='0';
%             k=k+1;
%         elseif ismember(j,tr.good_idx)
%             [~,b]=ismember(j,tr.good_idx);
%             XTr{k,1}=cell2mat(struct2cell(sequenze{tr.good_idx(b),1}));
%             YTr{k,1}='1';
%             k=k+1;
%         elseif ismember(j,ts.bad_idx)
%             [~,b]=ismember(j,ts.bad_idx);
%             XTs{h,1}=cell2mat(struct2cell(sequenze{ts.bad_idx(b),1}));
%             YTs{h,1}='0';
%             h=h+1;
%         elseif ismember(j,ts.good_idx)
%             [~,b]=ismember(j,ts.good_idx);
%             XTs{h,1}=cell2mat(struct2cell(sequenze{ts.good_idx(b),1}));
%             YTs{h,1}='1';
%             h=h+1;
%         end
%     end
%     YTr=categorical(YTr);
%     YTs=categorical(YTs);


%     k=1;
%     for j=1:size(sequenze,1)
%         if ismember(j,vs.bad_idx)
%             [~,b]=ismember(j,vs.bad_idx);
%             XVs{k,1}=cell2mat(struct2cell(sequenze{vs.bad_idx(b),1}));
%             YVs{k,1}='0';
%             k=k+1;
%         elseif ismember(j,vs.good_idx)
%             [~,b]=ismember(j,vs.good_idx);
%             XVs{k,1}=cell2mat(struct2cell(sequenze{vs.good_idx(b),1}));
%             YVs{k,1}='1';
%             k=k+1;
%         end
%     end
%     YVs=categorical(YVs);