addr=strcat(tipo,{'\'},{torre},{'\'},{torre});
addr=char(addr);
save(addr,'-regexp', '^(?!(fileID)$).');