duration(datetime(2021,11,27,01,24,06)-datetime(2021,07,02,05,24,28));
a=ans;
a=seconds(a);
b=floor(a/900);
x=find(coord{1,1}.time==datetime(2021,11,27,01,24,06));
y=find(coord{1,1}.time==datetime(2021,07,02,05,24,28));
c=x-y;


x= convertTo(coord{1,1}.time,'excel');
% j=[datetime(2021,11,27,01,24,06), datetime(2021,11,27,01,24,07)];
% i=convertTo(j,'excel');
% i=i(2)-i(1);
y=coord{1,1}.value;
z=[x(1):i:x(end)];
a=interp1(x,y,z);
j=[datetime(2021,11,27,01,15,0), datetime(2021,11,27,01,30,00)];
i=convertTo(j,'excel');
i=i(2)-i(1);
c=[x(1):i:x(end)];
b1=interp1(z,a,c);
c=datetime(c,'ConvertFrom','excel');
