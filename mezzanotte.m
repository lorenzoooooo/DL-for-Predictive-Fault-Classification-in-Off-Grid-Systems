function [dhour, d0] = mezzanotte(tempo)
    d=tempo;
    % Trovo i campioni che scandiscono la fine della giornata
    dhour=find(hour(d)==18 | hour(d)==19 | hour(d)==20 | hour(d)==21 | hour(d)==22 | ...
        hour(d)==23 | hour(d)==00 | hour(d)==01 | hour(d)==02 | hour(d)==03);
    % voglio solo il primo campione alla fine di ogni giorno
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
    d0=tempo(dhour);