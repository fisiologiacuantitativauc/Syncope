function prepro_HG(subject)
%% Data proccesing
load(subject)

RR_s  = RRprocessing(rr(:,1),rr(:,2),5);
plet_s= PLETprocessing(plet(:,1),plet(:,2),5);
[DBP_s,SBP_s]= SBPprocessing(sys(:,1),sys(:,2),dia(:,1),dia(:,2),5);
respsignal_s= RESPprocessing(resp(:,1),resp(:,2),5);

try
RR_s =RR_s(1:901,:);
DBP_s=DBP_s(1:901,:);
SBP_s=SBP_s(1:901,:);
respsignal_s=respsignal_s(1:901,:);
catch
    RR_s =RR_s(1:300,:);
DBP_s=DBP_s(1:300,:);
SBP_s=SBP_s(1:300,:);
respsignal_s=respsignal_s(1:300,:);
end


% cd Prepro_hut
doc= strcat('Handgrip\Preprocesado\','pro',subject);
save(doc,"RR_s","plet_s","DBP_s","SBP_s","respsignal_s")
% cd ..

return