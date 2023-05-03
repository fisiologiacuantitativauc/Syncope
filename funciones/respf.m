function rf= respf(data)

[b,a]      = butter(2,0.5,"low");
respsignal = filtfilt(b,a,data(:,2));
time       = data(:,1);  
int=2;
%Cubic spline
% respsignal= [(0:1/int:time(end))',(pchip(time,respsignal,0:1/int:time(end)))'];

signal=respsignal;


[pks,locs]=findpeaks(signal,"MinPeakDistance",700);
if length(pks)<10
    [pks,locs]=findpeaks(signal,"MinPeakDistance",10);
     
    td1= (locs(locs<= 300));
resp1m= numel(td1)-1;

td2= (locs(locs> 300 & locs<= 600));
resp2m= numel(td2)-1;

td3= (locs(locs> 600 & locs<= 900));
resp3m= numel(td3)-1;

 rf = mean([resp1m,resp2m,resp3m]);

% findpeaks(signal,"MinPeakDistance",700)
else
td1= (locs(locs<= 18000));
resp1m= numel(td1)-1;

td2= (locs(locs> 18000 & locs<= 36000));
resp2m= numel(td2)-1;

td3= (locs(locs> 36000 & locs<= 54000));
resp3m= numel(td3)-1;
rf = mean([resp1m,resp2m,resp3m]);
end



return