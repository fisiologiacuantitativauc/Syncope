function prepro_hut(subject)
%% Data proccesing
load(subject)

RR_s  = RRprocessing(rr(:,1),rr(:,2),5);
plet_s= PLETprocessing(plet(:,1),plet(:,2),5);
[DBP_s,SBP_s]= SBPprocessing(sys(:,1),sys(:,2),dia(:,1),dia(:,2),5);
respsignal_s= RESPprocessing(resp(:,1),resp(:,2),5);

cd Prepro_hut
save(strcat("prepro",subject),"RR_s","plet_s","DBP_s","SBP_s","respsignal_s")
cd ..

return