function [] = grafico(sequenze)
global torre;
    figure;
    for i=size(sequenze,1):-1:1
        if isempty(sequenze{i,1})
            continue;
        end
        plot(datetime(sequenze{i,1}.time,'ConvertFrom','excel'),sequenze{i,1}.mincellvoltage);
        hold on;
    end
    hold off;
    title(strcat(torre," mincellv"));

    figure;
    for i=size(sequenze,1):-1:1
        if isempty(sequenze{i,1})
            continue;
        end
        plot(datetime(sequenze{i,1}.time,'ConvertFrom','excel'),sequenze{i,1}.panelpower);
        hold on;
    end
    hold off;
    title(strcat(torre," panel power"));

    figure;
    for i=size(sequenze,1):-1:1
        if isempty(sequenze{i,1})
            continue;
        end
        plot(datetime(sequenze{i,1}.time,'ConvertFrom','excel'),sequenze{i,1}.maxcellvoltage);
        hold on;
    end
    hold off;
    title(strcat(torre," maxcellv"));

    figure;
    for i=size(sequenze,1):-1:1
        if isempty(sequenze{i,1})
            continue;
        end
        plot(datetime(sequenze{i,1}.time,'ConvertFrom','excel'),sequenze{i,1}.consumercurrent);
        hold on;
    end
    hold off;
    title(strcat(torre," consumer current"));