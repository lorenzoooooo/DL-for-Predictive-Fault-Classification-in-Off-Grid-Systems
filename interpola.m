function coord = interpola(coord)

x=coord.time;
y=coord.value;
c0=find(coord.diag==0);
coord.value=interp1(x(c0),y(c0),x);
c1=find(coord.diag==1);
coord.diag(c1)=0;