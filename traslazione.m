function coord = traslazione (coord, max_timeout, std_freq)

interval=diff(coord.time);
x=find(interval>max_timeout);
for i=1:size(x,2)
    coord = inserisci(coord,x(i),std_freq);
    x(i+1:end)=x(i+1:end)+1;
end

% temp=[coord.time(1):std_freq:coord.time(end)];
% temp=[temp coord.time(end)];
% interp1(coord.time,coord.value);