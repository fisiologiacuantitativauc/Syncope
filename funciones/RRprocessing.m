function [RR_s]= RRprocessing(time,RRINT,int)
%ECG:señal ECG
time= time-time(1,1);
RR=[time,RRINT];

RR(:,2)= filloutliers(RR(:,2),'pchip','movmedian',50);
RR_s= [(RR(1,1):1/int:RR(end,1))',[interp1(RR(:,1),RR(:,2),RR(1,1):1/int:RR(end,1),'previous')']];

return