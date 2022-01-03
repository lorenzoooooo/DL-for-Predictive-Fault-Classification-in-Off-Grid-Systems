folder=char();
v=char(variabili);
vb={};
a=~isspace(v(1,:));
folder=[folder v(1,a)];
for i= 2:size(v,1)
    a=~isspace(v(i,:));
    vb{i}=['-' v(i,a)];
    folder= [folder vb{i}];
end
% folder = strcat('risutati\',folder);
mkdir(strcat('risultati\',folder));

% %a=find(YTrain=="0");
% figure;
% for i=1:size(i_bad,2)
%     hold on;
%     plot(sequenze{i_bad(i),1}(11,:));
% %     if mean(XTrain{i,1}(3,:))>80
% %         i
% %     end
% end
% hold off;


% for i=size(sequenze,1):-1:1
%     if isempty(sequenze{i,1})
%         continue;
%     end
%     plot(datetime(sequenze{i,1}(1,:),'ConvertFrom','excel'),sequenze{i,1}(3,:));
%     hold on;
% end
% hold off;


%plot(datetime(seq_def{i,1}(1,:),'ConvertFrom','excel'),data(4,:));

% for i=1:size(data,1)-1
%     notanumb{i,1}=isnan(data(i+1,:));
%     notanumb{i,1}=find(notanumb{i,1});
% end

% for i=1:size(sequenze,1)
%     for k=1:size(data,1)-1
%         j=k+1;
%         notanumb{i,k}=isnan(sequenze{i,1}(j,:));
%         notanumb{i,k}=find(notanumb{i,k});
%     end
% end

