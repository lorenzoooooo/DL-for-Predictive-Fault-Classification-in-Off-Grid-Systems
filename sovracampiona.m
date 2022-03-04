function coord=sovracampiona(coord,final_freq)

ds=1/86400; % 1 secondo
% [x, index] = unique(x);
x=coord.time;
y=coord.value;
z=[x(1):ds:x(end)];
a=interp1(x,y,z);
c=[x(1):final_freq:x(end)];
coord.value=interp1(z,a,c);
c=datetime(c,'ConvertFrom','excel');
coord.time=c;