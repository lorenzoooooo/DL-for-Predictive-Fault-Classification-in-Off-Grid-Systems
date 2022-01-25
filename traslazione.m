function coord = traslazione (coord, max_timeout, std_freq)

interval=diff(coord.time);
x=find(interval>max_timeout);
diag_0=find(coord.diag(x)==0);
diag_0=x(diag_0);
occ_diag_0{1,1}=floor(seconds(interval(diag_0))/std_freq);
occ_diag_0{1,2}=mod(seconds(interval(diag_0)),std_freq);
p=coord;
for i=1:size(diag_0,2)
    if occ_diag_0{1,2}(i)==0
        coord = inserisci(coord,diag_0(i),std_freq,occ_diag_0{1,1}(i)-1);
        diag_0(i+1:end)=diag_0(i+1:end)+occ_diag_0{1,1}(i)-1;
    else
        coord = inserisci(coord,diag_0(i),std_freq,occ_diag_0{1,1}(i));
        diag_0(i+1:end)=diag_0(i+1:end)+occ_diag_0{1,1}(i);
    end
end