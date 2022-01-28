function coord = allineo(coord)

for i=1:size(coord,1)
    coord{i,1}.time.Second=0;
    start(i)=coord{i,1}.time(1);
    finish(i)=coord{i,1}.time(end);
end
start=max(start);
finish=min(finish);
for i=1:size(coord,1)
    x = find(coord{i,1}.time==start,1);
    if x>1
        coord{i,1}.time(1:x-1)=[];
        coord{i,1}.value(1:x-1)=[];
    end
    y = find(coord{i,1}.time==finish);
    if y<size(coord{i,1}.time,2)
        coord{i,1}.time(y+1:end)=[];
        coord{i,1}.value(y+1:end)=[];
    end
end
