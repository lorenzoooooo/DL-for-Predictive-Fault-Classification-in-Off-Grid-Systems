function panel_power= pp_dy (data)

% global name;
% t=1; %num riga timestamp in data
% if name=="var"
%     dy=5; %num riga daily yield in data
%     pp=12; %num riga panel power in data
% elseif name=="var_iotbox"
%     dy=4;
%     pp=11;
% else
%     "bo";
% end
%     t=1;
%     dy=4;
%     pp=11;

%% trovo il daily yield per ogni sequenza di 1 giorno  -- NON FUNZIONA PERCHE LE SEQUENZE SONO SOVRAPPOSTE
% 
% daily_yield=[];
% j=1;
% for i=1:3:size(sequenze,1)
%     [dhour,d0]=mezzanotte(sequenze{i,1}(1,:));
%     z=dhour(1,1);
%     h=1;
%     [~,a]=max(sequenze{i,1}(dy,1:z));
%     daily_yield(1,1)=sequenze{i,1}(t,a);
%     daily_yield(2,1)=sequenze{i,1}(dy,a);
%     j=j+1;
%     h=h+1;
%     k=z;
%     z=dhour(1,h);
%     while z<dhour(1,end)
%     %     a=find(data(5,i:-1:k)~=0,1);
%        [~,a]=max(sequenze{i,1}(dy,k:z));
%        a=k+a;
%        daily_yield(1,j)=sequenze{i,1}(t,a);
%        daily_yield(2,j)=sequenze{i,1}(dy,a);
%        j=j+1;
%        k=z;
%        h=h+1;
%        z=dhour(1,h);
%     end
%     [~,a]=max(sequenze{i,1}(dy,k:z));
%     a=k+a;
%     daily_yield(1,j)=sequenze{i,1}(t,a);
%     daily_yield(2,j)=sequenze{i,1}(dy,a);
% %     plot(datetime(sequenze{i,1}(1,:),'ConvertFrom','excel'),sequenze{i,1}(dy,:));
% end
% daily_yield(2,:)=daily_yield(2,:).*10; % ingegnerizzo il valore
%% trovo il daily yield partendo da data grezzo

% [dhour,d0]=mezzanotte(data(1,:));
% d1=duration();
% for i=2:size(dhour,2)
%     d1(i-1)= d0(i)-d0(i-1);
% end
% err=find(d1(1,:)>'30:00:00');
% daily_yield=[];
% i=dhour(1,1);
% j=1;
% [~,a]=max(data(dy,1:i));
% % a=find(data(5,i:-1:1)~=0,1);
% daily_yield(1,1)=data(t,a);
% daily_yield(2,1)=data(dy,a);
% j=j+1;
% k=i;
% i=dhour(1,j);
% while i<dhour(1,end)
% %     a=find(data(5,i:-1:k)~=0,1);
%    [~,a]=max(data(dy,k:i));
%    a=k+a;
%    daily_yield(1,j)=data(t,a);
%    daily_yield(2,j)=data(dy,a);
%    j=j+1;
%    k=i;
%    i=dhour(1,j);
% end
% [~,a]=max(data(dy,k:i));
% a=k+a;
% daily_yield(1,j)=data(t,a);
% daily_yield(2,j)=data(dy,a);
% % for i=1:size(err,2)
% % %     daily_yield(:,[err(i) err(i)+1])=[];  CHE FAMO CON GLI INTERVALLI SENZA SEGNALI???
% % end
% daily_yield(2,:)=daily_yield(2,:).*10;

%% integro su ogni giorno per ottenere il panel power
panel_power=[];
% global tipo;
for i=1:size(data,1)
    if isempty(data{i,1})
        continue;
    end
    panel_power(i) = trapz(data{i,1}.time,data{i,1}.panelpower).*24;
end
%% 
% for i=1:size(dhour,2)-1
%     xmin=dhour(1,i);
%     xmax=dhour(1,i+1);  
%     x=[xmin:xmax];
%     time_stamp=data(t,x);
%     y=data(pp,x);
%     panel_power(i) = trapz(time_stamp,y).*24;
%     if d1(i)>'30:00:00'
%         d1(i)=d1(i)/24;
%         q=floor(d1(i));
%         panel_power(i)=panel_power(i)/hours(q);
%     end
% end


%% plotto i risultati
% figure; 
% plot(datetime(panel_power(:,1),'ConvertFrom','excel'),panel_power(:,2),'r');
% title("panel power");

% plot(datetime(daily_yield(1,2:end),'ConvertFrom','excel'), daily_yield(2,2:end),'b');
% title("daily yield");
% figure; 
% plot(datetime(daily_yield(1,2:end),'ConvertFrom','excel'),panel_power(1,:),'r');
% title("panel power");


