% input('ricordati di cambiare il numero della torre nella query!');
% query=input('scegli query:\n','s');
% eval(query);
% init;
% compattazione_mtx;
% pulizia;
% salvataggio;
% 
% global tipo;
% if torre =="t1021" || torre =="t16399"
%     tipo="digil";
% elseif torre =="t16239" || torre =="t13008" || torre =="t1059"
%     tipo="iotbox";
% end
% global variabili; 

fclose('all');
fileID = fopen('mat.txt','r');
a=fgetl(fileID);
while ischar(a)
    load(a);
    variabili= ["min cell voltage"; "panel power"; "max cell voltage"];
    sequenze=estrazione_sequenze(data,variabili);                                            % suddivido in sequenze di 6 giorni
    [idx_b,idx_g]=sospetti(sequenze);                                          % identifico le sequenze patologiche
%     grafico(sequenze,torre);
    sequenze=normalizzazione(data,sequenze,variabili);                                                 %sottraggo il valor medio e divido per la varianza ogni riga di ogni sequenze eccetto il time stamp
    [XTr,YTr,XTs,YTs,XVs,YVs,tr,ts,vs]= etichette(idx_b,idx_g,sequenze);   % Suddivido in Tr e Ts per una data torre
    pulizia;
    salvataggio;
    save(addr,"XTr","YTr","XTs","YTs","XVs","YVs",'-append');
    a=fgetl(fileID);
end
fclose(fileID);
dataset1();