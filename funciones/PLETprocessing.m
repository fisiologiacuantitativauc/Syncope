function [plet_s]= PLETprocessing(time,plet,int)
%ECG:señal ECG
time= time-time(1,1);
pleti=[time,plet];

pleti(:,2)= filloutliers(pleti(:,2),'pchip','movmedian',50);
plet_s= [(pleti(1,1):1/int:pleti(end,1))',[pchip(pleti(:,1),pleti(:,2),pleti(1,1):1/int:pleti(end,1))']];

return