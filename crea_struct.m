function mystruct = crea_struct(seq,variabili)
mystruct.time=seq(1,:);
for i=1:size(variabili,1)
    mystruct.(variabili{i,1})=seq(i+1,:);
end