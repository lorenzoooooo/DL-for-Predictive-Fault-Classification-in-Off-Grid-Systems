function coord=sovracampiona(coord,std_freq)

ds=[datetime(2021,11,27,01,24,06), datetime(2021,11,27,01,24,07)];
ds=convertTo(ds,'excel');
ds=ds(2)-ds(1);

% [x, index] = unique(x);
x=coord.time;
y=coord.value;
z=[x(1):ds:x(end)];
a=interp1(x,y,z);
c=[x(1):std_freq:x(end)];
coord.value=interp1(z,a,c);
c=datetime(c,'ConvertFrom','excel');
coord.time=c;