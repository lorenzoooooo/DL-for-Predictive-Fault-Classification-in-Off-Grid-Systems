function coord = inserisci(coord,no_diag,std_freq,i,j)

coord{j,1}.time=[coord{j,1}.time(1:no_diag(i)-1) coord{j,1}.time(no_diag(i))-seconds(std_freq) coord{j,1}.time(no_diag(i):end)];
coord{j,1}.value=[coord{j,1}.value(1:no_diag(i)-1) coord{j,1}.value(no_diag(i)-1) coord{j,1}.value(no_diag(i):end)];
coord{j,1}.diag=[coord{j,1}.diag(1:no_diag(i)-1) coord{j,1}.diag(no_diag(i)-1) coord{j,1}.diag(no_diag(i):end)];