function sequenze = estraggo(data,dhour,i,righe);

%     if name=="var_iotbox"
%         sequenze=[data(1,dhour(i)+1:dhour(i+1)); data(righe,dhour(i)+1:dhour(i+1))];
%     elseif name=="var"
        sequenze=[data(1,dhour(i)+1:dhour(i+1)); data(righe,dhour(i)+1:dhour(i+1))];
%     end