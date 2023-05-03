function selectdat_baseline(data,testname)

fields = fieldnames(data);
%% Data selection
for i=1:length(fields)
ecg= data.(fields{i}).ECG_II;                       %var1
plet= data.(fields{i}).Pleth;                       %var2
sys= data.(fields{i}).reSYS;                        %var3
dia= data.(fields{i}).reDIA;                        %var4

[time,RR]= RRextraction(ecg,300);
rr=[time,RR];                                       %var5

[time,respsignal]= RESPextraction(ecg(:,2),300);
resp= [time',respsignal'];                            %var6

cd variables_baseline
save(strcat(fields{i},testname),"ecg","plet","sys","dia","rr","resp")
cd ..
end