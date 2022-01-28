function coord = interpola(coord)

x=coord.time;
[x, index] = unique(x);     % trovo e cancello i casi in cui si verificano due colonne con lo stesso istante
y=coord.value(index);
coord.diag=coord.diag(index);
c0=find(coord.diag==0);
% c1=find(coord.diag==1);
coord.value=interp1(x(c0),y(c0),x);
coord.time=x;

% gli ultimi valori se sono 0 lui li mette a NaN e quindi vanno forzati a 0
n=isnan(coord.value);
n=find(n==1);
coord.value(n)=y(n);