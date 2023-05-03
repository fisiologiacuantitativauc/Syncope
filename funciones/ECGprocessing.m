function [RR_s,rrHF,rrLF]= ECGprocessing(time,RRINT,sf,int)
%ECG:señal ECG
time= time-time(1,1);
RR=[time,RRINT];
% time= time-time(1,1);

% if any(RR(:,2)>= 1300)
%     r= find(RR(:,2)>=1300);
%     RR(r,2)= [mean([RR(r-3:r-1,2);RR(r+1:r+3,2)])];
% elseif any(RR(:,2)<= 400)
%      r= find(RR(:,2)<=400);
%     RR(r,2)= [mean([RR(r-3:r-1,2);RR(r+1:r+3,2)])];
% end


RR(:,2)= filloutliers(RR(:,2),'pchip','movmedian',50);
RR_s= [(RR(1,1):1/int:RR(end,1))',[interp1(RR(:,1),RR(:,2),RR(1,1):1/int:RR(end,1),'previous')']];


% plot(time, RRINT,'-o')
% hold on
% plot(RR_s(:,1),RR_s(:,2),'-o')


% RR_s= [(0:1/int:RR(end,1))',(pchip(RR(:,1),RR(:,2),0:1/int:RR(end,1))')];% plot(RR_s(:,1),RR_s(:,2),'-o')%%%%%%%%%%



% RR_filt= [RR_s(:,1),RR_s(:,2)];

%Filtro por bandas
% rrHF= [RR_filt(:,1),filtroHF(RR_filt(:,2),5)];
% rrLF= [RR_filt(:,1),filtroLF(RR_filt(:,2),5)];


return