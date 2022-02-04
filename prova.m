% for i=1:size(variabili.nb,1)
%     figure;
%     for j=1:size(sequenze,1)
%         plot(datetime(sequenze{j,1}.time,'convertfrom','excel'),sequenze{j,1}.(variabili.nb(i)));
%         hold on;
%     end
%     title(variabili.nb(i));
%     hold off;
% end

% 
% a=find(YTrain=='0');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(1,:)); hold on; end
% title('mincellv bad');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(2,:)); hold on; end
% title('panelpower bad');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(3,:)); hold on; end
% title('irradiation bad');
% a=find(YTrain=='1');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(1,:)); hold on; end
% title('mincellv good');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(2,:)); hold on; end
% title('panelpower good');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(3,:)); hold on; end
% title('irradiation good');


a=find(YTest=='0');
figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(1,:)); hold on; end
title('mincellv bad');
figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(2,:)); hold on; end
title('panelpower bad');
figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(3,:)); hold on; end
title('irradiation bad');
a=find(YTest=='1');
figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(1,:)); hold on; end
title('mincellv good');
figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(2,:)); hold on; end
title('panelpower good');
figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(3,:)); hold on; end
title('irradiation good');
