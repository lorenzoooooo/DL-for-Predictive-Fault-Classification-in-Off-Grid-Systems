function a = inserisci(a,x,std_freq)

a.time=[a.time(1:x) (a.time(x+1)-std_freq) a.time(x+1:end)];
a.value=[a.value(1:x) a.value(x) a.value(x+1:end)];
a.diag=[a.diag(1:x) a.diag(x) a.diag(x+1:end)];