function [XTr,YTr,XTs,YTs,tr,ts]= etichette(idx_b,idx_g, sequenze)
    YTr={};
    XTr={};
    XTs={};
    YTs={};
%     XVs={};
%     YVs={};
%     vs.bad_idx=[];
%     vs.good_idx=[];
    tr.bad_idx=[];
    tr.good_idx=[];
    ts.bad_idx=[];
    ts.good_idx=[];
    global proporzione quota_vs;
    %passo gli indici delle sequenze che identifico come patologiche e come sane
    i_bad=[idx_b];
    i_good=[idx_g];

    % nel caso in cui siano presenti sequenze negative e positive per una data torre
    if ~isempty(i_bad)                                  % spartisco gli indici delle sequenze patologiche tra train e test
        pari=mod(i_bad(:),2)==0;
        disp=mod(i_bad(:),2)~=0;
        tr.bad_idx=[i_bad(pari)];                       % TrSet prende le sequenze patologiche con indice dispari
        ts.bad_idx=[i_bad(disp)];                       % TsSet prende le sequenze patologiche con indice pari
       % vs.bad_idx=randsample(ts.bad_idx,ceil(size(ts.bad_idx,2)/quota_vs));
        if ~isempty(i_good)                             % spartisco gli indici delle sequenze sane tra train e test
            pari=mod(i_good(:),2)==0;
            disp=mod(i_good(:),2)~=0;
            tr.good_idx=[i_good(pari)];                 % TrSet prende le sequenze sane con indice dispari
            ts.good_idx=[i_good(disp)];                 % TsSet prende le sequenze sane con indice pari
            if size(tr.good_idx,2)>proporzione*size(tr.bad_idx,2) && size(ts.good_idx,2)>proporzione*size(ts.bad_idx,2)
                tr.good_idx=randsample(tr.good_idx,proporzione*size(tr.bad_idx,2));
                ts.good_idx=randsample(ts.good_idx,proporzione*size(ts.bad_idx,2));
            end
           % vs.good_idx=randsample(ts.good_idx,ceil(size(ts.good_idx,2)/quota_vs));
        end
    else
        if ~isempty(i_good)
            pari=mod(i_good(:),2)==0;
            disp=mod(i_good(:),2)~=0;
            tr.good_idx=[i_good(pari)];                 %TrSet prende le sequenze sane con indice dispari
            ts.good_idx=[i_good(disp)];                 %TsSet prende le sequenze sane con indice pari
            tr.good_idx=randsample(tr.good_idx,proporzione);
            ts.good_idx=randsample(ts.good_idx,proporzione);
        end
    end
    
    % creo cell array XTrain e XTest contenenti le sequenze e assegno le
    % etichette con gli array categorici YTrain e YTest
    k=1;
    h=1;
    for j=1:size(sequenze,1)
        sequenze{j,1}=rmfield(sequenze{j,1},"time");
        if ismember(j,tr.bad_idx)
            [~,b]=ismember(j,tr.bad_idx);
            XTr{k,1}=cell2mat(struct2cell(sequenze{tr.bad_idx(b),1}));
            YTr{k,1}='0';
            k=k+1;
        elseif ismember(j,tr.good_idx)
            [~,b]=ismember(j,tr.good_idx);
            XTr{k,1}=cell2mat(struct2cell(sequenze{tr.good_idx(b),1}));
            YTr{k,1}='1';
            k=k+1;
        elseif ismember(j,ts.bad_idx)
            [~,b]=ismember(j,ts.bad_idx);
            XTs{h,1}=cell2mat(struct2cell(sequenze{ts.bad_idx(b),1}));
            YTs{h,1}='0';
            h=h+1;
        elseif ismember(j,ts.good_idx)
            [~,b]=ismember(j,ts.good_idx);
            XTs{h,1}=cell2mat(struct2cell(sequenze{ts.good_idx(b),1}));
            YTs{h,1}='1';
            h=h+1;
        end
    end
    YTr=categorical(YTr);
    YTs=categorical(YTs);


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