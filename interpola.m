function coord = interpola(coord)

x=coord.time;
[x, index] = unique(x);     % trovo e cancello i casi in cui si verificano due colonne con lo stesso istante
y=coord.value(index);
coord.diag=coord.diag(index);
c0=find(coord.diag==0);
coord.value=interp1(x(c0),y(c0),x,'linear','extrap');
coord.time=x;