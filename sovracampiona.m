function coord=sovracampiona(coord)

ds=[datetime(2021,11,27,01,24,06), datetime(2021,11,27,01,24,07)];
ds=convertTo(ds,'excel');
ds=ds(2)-ds(1);
dm=[datetime(2021,11,27,01,15,0), datetime(2021,11,27,01,30,00)];
dm=convertTo(dm,'excel');
dm=dm(2)-dm(1);

x= convertTo(coord.time,'excel');
% [x, index] = unique(x);
y=coord.value;
z=[x(1):ds:x(end)];
a=interp1(x,y,z);
c=[x(1):dm:x(end)];
coord.value=interp1(z,a,c);
c=datetime(c,'ConvertFrom','excel');
coord.time=c;
%     figure;
%     plot(c,b1);
%     title(coord{i,1}.name);