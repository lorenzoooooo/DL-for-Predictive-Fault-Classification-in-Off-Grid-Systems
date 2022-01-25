function a = inserisci(a,x,std_freq,max)

u=seconds([max*std_freq:-std_freq:std_freq]);
v=repmat(a.value(x),1,size(u,2));
z=repmat(a.diag(x),1,size(u,2));
a.time=[a.time(1:x) (a.time(x+1)-u) a.time(x+1:end)];
a.value=[a.value(1:x) v a.value(x+1:end)];
a.diag=[a.diag(1:x) z a.diag(x+1:end)];