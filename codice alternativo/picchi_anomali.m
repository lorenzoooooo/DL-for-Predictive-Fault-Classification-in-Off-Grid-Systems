function sequenze = picchi_anomali (sequenze,variabili)
for i=1:size(sequenze,1)
    for j=1:size(sequenze{i,1}.mincellvoltage,2)
        if sequenze{i,1}.mincellvoltage(j)<=2000
            for k=1:size(variabili.nb,1)
                sequenze{i,1}.(variabili.nb(k))(j)=sequenze{i,1}.(variabili.nb(k))(j-1);    % trovo i campioni e gli assegno l'ultimo valore valido campionato
            end
        end
    end
end
