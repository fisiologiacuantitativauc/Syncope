function [y]=medianasBL(data)
data
load(data)

sp= sys(:,2);
t= sys(:,1)-sys(1,1);
S = filloutliers(sp,"pchip","movmedian",45);

dp= dia(:,2);
t= dia(:,1)-dia(1,1);
D = filloutliers(dp,"pchip","movmedian",45);

mp= sp./3 + (2*dp)./3;

hr= (1./rr(:,2))*60*1000;

rf= respf(resp);

y= [median(S),median(D),median(mp),median(hr),rf];



return