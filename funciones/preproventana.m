function preproventana(data)

load(data)
labels=["tempranaA","tempranaB","tardiaA","tardiaB","sincope"];

for i=1:numel(labels)
figure
subplot(3,1,1)
plot(windows.RR_s.(labels(i))(:,1),windows.RR_s.(labels(i))(:,2));
subplot(3,1,2)
plot(windows.SBP_s.(labels(i))(:,1),windows.SBP_s.(labels(i))(:,2))
subplot(3,1,3)
plot(windows.DBP_s.(labels(i))(:,1),windows.DBP_s.(labels(i))(:,2))
pause
I=input('Consider this window?, Y/N [Y]:','s');
if I=="Y"| I=="y"
    
windows.RR_s.(labels(i))(:,2)= filloutliers(windows.RR_s.(labels(i))(:,2),'pchip','movmedian',10);   
% plot(windows.RR_s.(labels(i))(:,1),windows.RR_s.(labels(i))(:,2));
ind1=find(windows.SBP_s.(labels(i))(:,2)>=200);
ind2=find(windows.SBP_s.(labels(i))(:,2)<200);
if ~isempty(ind1)
windows.SBP_s.(labels(i))(ind1(1)-5:ind1(end)+5,2)= median(windows.SBP_s.(labels(i))(ind2,2));
windows.DBP_s.(labels(i))(ind1(1)-5:ind1(end)+5,2)= median(windows.DBP_s.(labels(i))(ind2,2));

end
% figure
% subplot(3,1,1)
% plot(windows.RR_s.(labels(i))(:,1),windows.RR_s.(labels(i))(:,2));
% subplot(3,1,2)
% plot(windows.SBP_s.(labels(i))(:,1),windows.SBP_s.(labels(i))(:,2))
% subplot(3,1,3)
% plot(windows.DBP_s.(labels(i))(:,1),windows.DBP_s.(labels(i))(:,2))
% pause
else 
  close all
  windows.RR_s.(labels(i))=[];
  windows.SBP_s.(labels(i))=[];
  windows.DBP_s.(labels(i))=[];
  windows.respsignal_s.(labels(i))=[];


end

if length(windows.RR_s.tempranaA)>1500
    l=length(windows.RR_s.tempranaA(:,1));
    windows.RR_s.tempranaA=windows.RR_s.tempranaA(l-1500:end,:);
    windows.SBP_s.tempranaA=windows.SBP_s.tempranaA(l-1500:end,:);
    windows.DBP_s.tempranaA=windows.DBP_s.tempranaA(l-1500:end,:);
    windows.respsignal_s.tempranaA=windows.respsignal_s.tempranaA(l-1500:end,:);
end



close all
cd Prepro_hut70
save(strcat("prepro",erase(data,".mat"),"window"),"windows")
cd ..
end