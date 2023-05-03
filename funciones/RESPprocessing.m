function [respsignal]= RESPprocessing(tiempo,RESP,int)


% respsignal=obj.EDR_comp;
time=tiempo;
respsignal=RESP;
ini= respsignal(3600:7200);
fin= respsignal(end-7200:end-3600);
respsignal(1:3600+1)=ini;
respsignal(end-3600:end)=fin;

% [b,a]      = butter(2,[0.1 0.5]./150);
[b,a]      = butter(2,0.5,"low");
respsignal = filtfilt(b,a,respsignal);
% respsignal = detrend(respsignal);

%Cubic spline
respsignal= [(0:1/int:time(end))',(pchip(time,respsignal,0:1/int:time(end)))'];

return