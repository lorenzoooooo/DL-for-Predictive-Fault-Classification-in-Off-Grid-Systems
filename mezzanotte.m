function [dhour, d0] = mezzanotte(tempo)
%     d=datetime(tempo,'ConvertFrom','excel');
    d=tempo;
    %% campiono trale 20 e le 03 del mattino per scandire le giornate
    dhour=find(hour(d)==20 | hour(d)==21 | hour(d)==22 | hour(d)==23 | hour(d)==00 | hour(d)==01 | hour(d)==02 | hour(d)==03) ;
    t1=dhour(end);

    
    %% voglio solo il primo campione alla mezzanotte di ogni giorno
    i=dhour(1,1);
    j=find(dhour(1,:)==i);
    counter=1;
    while i<dhour(1,end)
        e=dhour(1,j+1);
        if e~=dhour(1,j)+counter
            i=dhour(1,j+1);
            counter=1;
            j=find(dhour(1,:)==i);
        else
            dhour(:,j+1)=[];
            counter=counter+1;
        end
    end
    
    %% una volta che si è spenta la torre, gli unici istanti di funzionamento sono durante il giorno e quindi
    % per prelevarli devo concatenare a dhour campioni presi tra le 6 e e 14
% 
%     a=[];
%     b=[];
%     size_month=[];
%     i=t1:size(tempo,2);
%     a=find(hour(d(i))==6 | hour(d(i))==7 |hour(d(i))==8|hour(d(i))==9 |hour(d(i))==10|hour(d(i))==11|hour(d(i))==12|hour(d(i))==13|hour(d(i))==14);
%     a=a+t1-1;
%     dday=day(datetime(tempo(1,a),'ConvertFrom','excel'));
%     dmonth=month(datetime(tempo(1,a),'ConvertFrom','excel'));
% 
%     %% Trovo l'indice in cui avviene il cambio di mese e il numero di giorni nel mese
%     counter=1;
%     size_month(counter,1)= 1;
%     size_month(counter,2)="NaN";
%     counter=counter+1;
%     for i=2:size(dmonth,2)          
%         if dmonth(i)~=dmonth(i-1)
%             size_month(counter,1)= i; 
%             size_month(counter,2)=lung_mesi(dmonth(i-1));
%             counter=counter+1;
%         end
%     end
%     size_month(counter,1)=size(dmonth,2);
%     size_month(counter,2)=lung_mesi(dmonth(end));
%     
%     %% trovo l'indice dell'ultima istanza di ogni giorno per ogni mese
%     c=[];
%     for i=1:size(size_month,1)-1                        %per ogni intervallo che rappresenta un mese
%         if dday(size_month(i,1))==1                     %se il mese è campionato dal primo
%             for j=1:size_month(i+1,2)                   %per ogni giorno del mese
%                 counter=find(dday(size_month(i,1):size_month(i+1,1))==j,1,'last');
%                 if isempty(counter)
%                     b(i,j)=0;
%                 else
%                     b(i,j)=counter;
%                     b(i,j)=b(i,j)+size_month(i,1);
%                     c=[c b(i,j)];
%                 end
%             end
%         else                                            %se il mese NON è campionato dal primo
%             for j=dday(i):size_month(i+1,2)             %per ogni giorno del mese
%                 counter=find(dday(size_month(i,1):size_month(i+1,1))==j,1,'last');
%                 if isempty(counter)
%                     b(i,j)=0;
%                 else
%                     b(i,j)=counter;
%                     b(i,j)=b(i,j)+size_month(i,1);
%                     c=[c b(i,j)];
%                 end
%             end
%         end
%     end
%     c(1,end)=size_month(end,1);
%     a=a(c);
%     dhour=[dhour a];
    %% trovo quando dhour conteggia diversi giorni come uno solo
%     d0=datetime(tempo(dhour),'ConvertFrom','excel');
d0=tempo(dhour);