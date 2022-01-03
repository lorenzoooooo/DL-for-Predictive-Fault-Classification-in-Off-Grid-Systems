if name == "var"
    addr=strcat("digil__iotbox-digil",{'\'},{torre},{'\'},{torre});
    addr=char(addr);
    save(addr,'-regexp', '^(?!(fileID)$).');
elseif name == "var_iotbox"
    addr=strcat("iotbox",{'\'},{torre},{'\'},{torre});
    addr=char(addr);
    save(addr,'-regexp', '^(?!(fileID)$).');
end