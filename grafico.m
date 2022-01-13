function [] = grafico(sequenze,variabili)
global torre;
for k=1:size(variabili.nb,1)
    figure;
    for i=size(sequenze,1):-1:1
        plot(datetime(sequenze{i,1}.time,'ConvertFrom','excel'),sequenze{i,1}.(variabili.nb(k)));
        hold on;
    end
    hold off;
    title(strcat(torre,' ',variabili.nb(k)));
end
