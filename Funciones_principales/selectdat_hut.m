function selectdat_hut(data,testname)

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

sv = data.(fields{i}).SV;                        %var7
co = data.(fields{i}).CO;                        %var8
tpr= data.(fields{i}).TPR;                        %var8

if contains(testname,"TT")
    cd variables_hut
elseif contains(testname,"RP")
    cd Deep_Breathing\Lab_data\
end

save(strcat(fields{i},testname),"ecg","plet","sys","dia","rr","resp","sv","co","tpr")
cd C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal
end









