function [time,respsignal]= RESPextraction(RESP,sf)

dt=1/sf;
smoothECG = medfilt1(RESP,round(.2/dt)); 
smoothECG2 = medfilt1(smoothECG,round(.6/dt)); 
BaselineCorrectedECG = RESP - smoothECG2; 

ecgspan= BaselineCorrectedECG-min(BaselineCorrectedECG)./(max(BaselineCorrectedECG)-min(BaselineCorrectedECG));
ecgspan(ecgspan>1)=0;
ecgspan(ecgspan<-1)=0;
% signal= abs(double(RESP)+0.3);
% 
% signal= signal-min(signal);
% signal(signal>1.5)=0;



[a,b]=butter(3,[0.1 50]/(sf/2));
signalf= filtfilt(a,b,ecgspan);
time= 0:dt:(length(signalf)-1)*dt;
% time= time-time(1);


obj= BioSigKit(signalf,sf,0);%1000
respsignal=obj.EDR_comp;



return