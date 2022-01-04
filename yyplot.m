figure;
a=datetime(data(1,:),'ConvertFrom','excel');
yyaxis left;
% plot(datetime(daily_yield(1,2:end),'ConvertFrom','excel'),daily_yield(2,2:end),'b',datetime(daily_yield(1,2:end),'ConvertFrom','excel'),panel_power,'r');
plot(a,data(8,:),'g',a,data(9,:),'b');
yyaxis right;
plot(a,data(6,:),'r');
% lim=[data(1,1),data(1,end)];
% xlim(lim);

%  plot(datetime(data(1,:),'ConvertFrom','excel'),data(3,:),'r');