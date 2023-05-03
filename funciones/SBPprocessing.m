function [DBP_s,SBP_s]= SBPprocessing(tiemposbp,sbp,tiempodbp,dbp,int)


% [SPraw DPdata] = period_test(time,signal); %length 101
timesbp= tiemposbp;
timesbp= timesbp-timesbp(1);
timedbp= tiempodbp;
timedbp=timedbp-timedbp(1);
SPraw=sbp;
DPdata=dbp;

%resampleo
DPdata= filloutliers(DPdata,'pchip','movmedian',60);
DBP= [(0:1/int:timedbp(end))',(pchip(timedbp,DPdata,0:1/int:timedbp(end)))'];
% plot(DBP(:,1),DBP(:,2))
% if any(DBP(:,2)>200)
%    ind= find(DBP(:,2)>200);
% end

% DBP(ind(1)-1:ind(end),2)= DBP(ind(end):ind(end)+length(ind),2);
% DBP(ind(1)-1:ind(end),2)= mean(DBP(ind(end)+1:length(DBP),2));


% DBP= DBP(DBP(:,1)>= round(t2(1),2),:);
SPraw= filloutliers(SPraw,'pchip','movmedian',60);
SBP= [(0:1/int:timesbp(end))',(pchip(timesbp,SPraw,0:1/int:timesbp(end)))'];

SBP_s= [SBP(:,1),SBP(:,2)];
DBP_s= [DBP(:,1),DBP(:,2)];

return


