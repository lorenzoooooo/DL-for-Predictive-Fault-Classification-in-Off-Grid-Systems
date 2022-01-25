function coord = interpola(coord)

x=coord.time;
y=coord.value;
c0=find(coord.diag==0);
c1=find(coord.diag==1);
coord.value=interp1(x(c0),y(c0),x);
coord.diag(c1)=0;