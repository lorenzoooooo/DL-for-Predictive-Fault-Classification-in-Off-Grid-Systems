y=[97.65, 97.79, 98.46 
    91.33, 90.47, 91.52
    85.33, 84.89, 85.11];
x={'predizione a 1 giorno','predizione a 3 giorni','predizione a 7 giorni'};
x=categorical(x);
bar(x,y);
grid on;
% title("Confronto falsi negativi nel caso di predizione ad 1, 3 e 7 giorni dall'evento al variare della lunghezza delle sequenze");
title("Confronto delle accuratezze di predizione per le 3 reti neurali");
% title("Confronto delle accuratezza di predizione ad 1, 3 e 7 giorni dall'evento al variare della lunghezza delle sequenze");
ylabel('%');
legend("rete standard","prima rete alternativa","seconda rete alternativa", 'Location','northeast','fontsize',11);
% legend("sequenze lunghe 3 giorni","sequenze lunghe 1 giorno", 'Location','northeast','fontsize',11);

% figure;
% for i=1:size(sequenze,1)
%     if ismember(i,c{1,2})
%         plot(datetime(sequenze{i}.time,'convertfrom','excel'),sequenze{i}.mincellvoltage,'g');
%     elseif ismember(i,c{1,1})
%         plot(datetime(sequenze{i}.time,'convertfrom','excel'),sequenze{i}.mincellvoltage,'r');
%     end
%     hold on;
% end

% figure;
% for i=1:size(sequenze,1)
%     if ismember(i,c{1})
% %         j=1;
%         area(datetime(sequenze{i}.time,'ConvertFrom','excel'),repmat(j,1,size(sequenze{i}.time,2)),'FaceColor','r','facealpha',0.6);
%         hold on;
%     end
%     if ismember(i,c{2})
% %         j=2;
%         area(datetime(sequenze{i}.time,'ConvertFrom','excel'),repmat(j,1,size(sequenze{i}.time,2)),'FaceColor','g','facealpha',0.6);
%         hold on;
%     end
% %     if ismember(i,idx_b)
% %         j=3;
% %         area(datetime(sequenze{i}.time,'ConvertFrom','excel'),repmat(j,1,size(sequenze{i}.time,2)),'FaceColor',[0.9290 0.6940 0.1250],'facealpha',0.3);
% %         hold on;
% %     end
% %     if ismember(i,idx_g)
% %         j=4;
% %         area(datetime(sequenze{i}.time,'ConvertFrom','excel'),repmat(j,1,size(sequenze{i}.time,2)),'FaceColor','#00FFFF','facealpha',0.3);
% %         hold on;
% %     end
%     j=j+1;
%     if j==3
%         j=1;
%     end
% end
% title(torre);

% figure;
% j=1;
% for i=1:size(sequenze,1)
%     if ismember(i,c{2})
%         x=1;
%         area(datetime(sequenze{i}.time,'ConvertFrom','excel'),repmat(j,1,size(sequenze{i}.time,2)),'FaceColor','g','facealpha',0.3);
%         histogram(i,'Facecolor','g');
%     else
%         histogram(i,'Facecolor','r');
%         x=1;
%         area(datetime(sequenze{i}.time,'ConvertFrom','excel'),repmat(j,1,size(sequenze{i}.time,2)),'FaceColor','r','facealpha',0.3);
%     end
%     plot(datetime(sequenze{i}.time,'ConvertFrom','excel'),[0,repmat(x*j,1,size(sequenze{i}.time,2)-2),0],'k');
%     hold on;
%     plot(datetime(sequenze{i}.time,'ConvertFrom','excel'),zeros(1,size(sequenze{i}.time,2)),'k--');
%     hold on;
% %     histogram(i+0.5,'Facecolor','white','EdgeColor','white');
% %     hold on;
%     j=j+1;
%     if j==3
%         j=1;
%     end
% end



% for k=1:size(variabili.nb,1)
%     figure;
%     plot(nuova_struct.time,nuova_struct.(variabili.nb(k)));
%     title(strcat(torre,' ',variabili.nb(k)));
%     hold on;
%     for i=size(sequenze,1):-1:1
%         plot(datetime(sequenze{i,1}.time,'ConvertFrom','excel'),sequenze{i,1}.(variabili.nb(k)),'r');
%         hold on;
%     end
%     hold off;
% end

% 
% a=find(YTrain=='0');
% b=find(YTrain=='1');
% 
% figure;
% subplot(2,1,1);
% for i=1:size(a,1) plot(XTrain{a(i),1}(1,:)); hold on; end
% hold off; title('minimum cell voltage patologico');
% subplot(2,1,2); 
% for i=1:size(b,1) plot(XTrain{b(i),1}(1,:)); hold on; end
% hold off; title('minimum cell voltage sano');
% 
% figure;
% subplot(2,1,1);
% for i=1:size(a,1) plot(XTrain{a(i),1}(2,:)); hold on; end
% hold off; title('panelpower patologico');
% subplot(2,1,2); 
% for i=1:size(b,1) plot(XTrain{b(i),1}(2,:)); hold on; end
% hold off; title('panelpower sano');
% 
% figure;
% subplot(2,1,1);
% for i=1:size(a,1) plot(XTrain{a(i),1}(3,:)); hold on; end
% hold off; title('soc patologico');
% subplot(2,1,2); 
% for i=1:size(b,1) plot(XTrain{b(i),1}(3,:)); hold on; end
% hold off; title('soc sano');

% a=find(YTrain=='0');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(1,:)); hold on; end
% title('minimum cell voltage patologico');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(2,:)); hold on; end
% title('panelpower patologico');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(3,:)); hold on; end
% title('soc patologico');
% figure; hold off; for i=1:size(a,1) plot(XTrain{a(i),1}(5,:)); hold on; end
% title('tot battery current patologico');
% b=find(YTrain=='1');
% figure; hold off; for i=1:size(b,1) plot(XTrain{b(i),1}(1,:)); hold on; end
% title('minimum cell voltage sano');
% figure; hold off; for i=1:size(b,1) plot(XTrain{b(i),1}(2,:)); hold on; end
% title('panelpower sano');
% figure; hold off; for i=1:size(b,1) plot(XTrain{b(i),1}(3,:)); hold on; end
% title('soc sano');
% figure; hold off; for i=1:size(b,1) plot(XTrain{b(i),1}(5,:)); hold on; end
% title('tot battery current sano');
% 
% 
% a=find(YTest=='0');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(1,:)); hold on; end
% title('mincellv bad');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(2,:)); hold on; end
% title('panelpower bad');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(3,:)); hold on; end
% title('soc bad');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(5,:)); hold on; end
% title('tot battery current patologico');
% a=find(YTest=='1');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(1,:)); hold on; end
% title('mincellv good');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(2,:)); hold on; end
% title('panelpower good');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(3,:)); hold on; end
% title('soc good');
% figure; hold off; for i=1:size(a,1) plot(XTest{a(i),1}(5,:)); hold on; end
% title('tot battery current sano');
