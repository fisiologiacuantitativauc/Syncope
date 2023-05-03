function [slope,minmax,angle,t]=indexHG(data)

load(data)
data
%hr= [rr(:,1)-rr(1,1),1./(rr(:,2))*60*1000];
hr= sys;
hr(:,1)=hr(:,1)-hr(1,1);
if data=="valentinacaneohg.mat" |data=="loyolahg.mat"|data=="fernandahg.mat"
    hr=hr(10:end,:);
end

figure
plot(hr(:,1),hr(:,2));
data

%minmax
if length(hr)>60
    l=180;
else
    l=60;
end
tol=0.1;
t= abs(hr(:,1)-l);
[M,en] = min(t);
% en= find(t<tol);
% minmax= max(hr(1:en,2))-min(hr(1:20,2));
 minmax= max(hr(1:en,2))-hr(1,2);

%slope
figure
p = polyfit(hr(1:en,1),hr(1:en,2),1); 
f = polyval(p,hr(1:en)); 
plot(hr(1:en,1),hr(1:en,2),'-o',hr(1:en,1),f,'-') 
legend('data','linear fit') 
slope=p(1);
% mdl = fitlm(hr(1:en,1),hr(1:en,2))

%angle
[m n]=max(hr(1:en,2));
a= hr(n,1);
b=max(hr(1:en,2))-hr(1,2);
angle= a*b/sqrt(a^2+b^2);

t=a;
pause
close all

return