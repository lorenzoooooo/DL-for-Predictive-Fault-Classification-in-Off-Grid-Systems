function sequenze = estraggo(data,dhour,i,righe);
sequenze=[data(1,dhour(i)+1:dhour(i+1)); data(righe,dhour(i)+1:dhour(i+1))];
