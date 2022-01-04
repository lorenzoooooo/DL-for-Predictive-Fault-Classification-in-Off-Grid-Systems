%% ATTENZIONE LE SEQUENZE AL LORO INTERNO SONO PRELEVATE A RITROSO (ES: DAL 6 AL 1 MAGGIO)


%Le sequenze estratte sono ordinate dalla più recente alla meno recente
%per ora non prelevo l'irraiazione perché non compare nei data della t1025
function sequenze = estrazione_set(data,name)
%     [dhour,d0]=mezzanotte(data(1,:));
%     d1=duration();
%     for i=2:size(dhour,2)
%         d1(i-1)= d0(i)-d0(i-1);
%     end
%     err=find(d1(1,:)>'30:00:00');
    lasso=6;    
    span=lasso/3;                                       %span di 2 giorni tra sequenze
    sequenze={};
    a=0;
    i=size(data,2);
    j=1;
    while i>0
        a=find(data(1,:)<(data(1,i)-lasso),1,'last');
        if isempty(a)
            if name=="var_iotbox"
                c=data(:,i:-1:1);                       %iotbox senza stazione meteo
            elseif name=="var"
                c=[data(1,i:-1:1);data(3:end,i:-1:1)];  %digil o iotbox-digil
            end
            sequenze{j,1}=c;
            break;
        end
        b=find(data(1,:)<(data(1,i)-span),1,'last');
        if name=="var_iotbox"
            c=data(:,a:i);                              %iotbox senza stazione meteo
        elseif name=="var"
            c=[data(1,a:i);data(3:end,a:i)];            %digil o iotbox-digil
        end
        sequenze{j,1}=c;
        hold on;
        plot(datetime(sequenze{j,1}(1,:),'ConvertFrom','excel'),sequenze{j,1}(3,:));
        i=i-(i-b);
        j=j+1;                                          %indice delle righe del cell array contente le sequenze
    end
hold off;