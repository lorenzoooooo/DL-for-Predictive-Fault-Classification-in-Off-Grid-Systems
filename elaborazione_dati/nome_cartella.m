function folder = nome_cartella (frase)
% strcat(frase);
v=char(frase);
vb={};
folder=char();
a=~isspace(v(1,:));
folder=[folder v(1,a)];
for i= 2:size(v,1)
    a=~isspace(v(i,:));
    vb{i}=['-' v(i,a)];
    folder= [folder vb{i}];
end