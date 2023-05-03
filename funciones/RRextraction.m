function [time,RR]= RRextraction(ECG,sf)

% plot(ECG)
% pause
dt=1/sf;
% tiempo= (0:dt:(length(ECG)-1)*dt)';
tiempo= ECG(:,1);
% signal= filtroECG(ECG,sf); %1000
signal= ECG(:,2);
% [a,b]=butter(3,[2 100]/(sf/2));
[a,b]=butter(3,[0.1 50]/(sf/2));
signalf= filtfilt(a,b,double(signal));
%tiempo= tiempo-tiempo(1);

RR= RR_extract(signalf,tiempo);
RR(:,2)= RR(:,2)*1000;
time=RR(:,1);
RR=RR(:,2);






return