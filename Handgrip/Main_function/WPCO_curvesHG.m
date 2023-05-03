function WPCO_curvesHG

%Baseline vs HG
subj=dir("Resultados_wpco\baseline");
subj= {subj.name};
subj= subj(3:end);

LIM=nan(300,25,5); %datos, sujeto, variable
for n=1:5
for l=1:length(subj)
   load(subj{l})
   LIM(1:length(lim(:,1)),l,n)=lim(:,n); 
end
end

for j=1:5
Resultados.control.BL.median(:,j)= median(LIM(:,[1,2,3,6,10,11,13,14,22],j),2,'omitnan');
Resultados.sincope.BL.median(:,j)= median(LIM(:,[ 8 9 16 21 23 24],j),2,'omitnan');
Resultados.control.BL.iq(:,j)    = iqr(LIM(:,[1,2,3,6,10,11,13,14,22],j),2);
Resultados.sincope.BL.iq(:,j)    = iqr(LIM(:,[ 8 9 16 21 23 24],j),2);
end

subj=dir("Handgrip\WPCOR");
subj= {subj.name};
subj= subj(3:end);
for n=1:5
for l=1:length(subj)
   load(subj{l})
   LIM(1:length(lim),l,n)=lim(:,n); 
end
end
for j=1:5
Resultados.control.HG.median(:,j)= median(LIM(:,[1,2,3,6,10,11,13,14,22],j),2,'omitnan');
Resultados.sincope.HG.median(:,j)= median(LIM(:,[ 8 9 16 21 23 24],j),2,'omitnan');
Resultados.control.HG.iq(:,j)= iqr(LIM(:,[1,2,3,6,10,11,13,14,22],j),2);
Resultados.sincope.HG.iq(:,j)= iqr(LIM(:,[ 8 9 16 21 23 24],j),2);
end
fr=frecuencia_w(:,1);
length(fr)


titles=["SBP-RR","DBP-RR","RR-RESP","SBP-RESP","DBP-RESP"];
for i=1:5
figure
mediana1= Resultados.control.HG.median(1:length(fr),i);
up1     = Resultados.control.HG.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)
hold on
mediana1= Resultados.sincope.HG.median(1:length(fr),i);
up1     = Resultados.sincope.HG.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)

title([titles(i)])
ylabel("COH")
xlabel("Frequency (Hz)")
set(gca,'FontSize',10)
xlim([0.04 0.4])
legend("Control","Syncope","Significant")

end

titles=["SBP-RR","DBP-RR","RR-RESP","SBP-RESP","DBP-RESP"];
for i=1:5
figure
mediana1= Resultados.control.BL.median(1:length(fr),i);
up1     = Resultados.control.BL.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)
hold on
mediana1= Resultados.sincope.BL.median(1:length(fr),i);
up1     = Resultados.sincope.BL.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)

title([titles(i)])
ylabel("COH")
xlabel("Frequency (Hz)")
set(gca,'FontSize',10)
xlim([0.04 0.4])
legend("Control","Syncope","Significant")

end

titles=["SBP-RR","DBP-RR","RR-RESP","SBP-RESP","DBP-RESP"];
for i=1:5
figure
mediana1= Resultados.control.BL.median(1:length(fr),i);
up1     = Resultados.control.BL.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)
hold on
mediana1= Resultados.control.HG.median(1:length(fr),i);
up1     = Resultados.control.HG.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)

title([titles(i)])
ylabel("COH")
xlabel("Frequency (Hz)")
set(gca,'FontSize',10)
xlim([0.04 0.4])
legend("BL","HG","Significant")

end


titles=["SBP-RR","DBP-RR","RR-RESP","SBP-RESP","DBP-RESP"];
for i=1:5
figure
mediana1= Resultados.sincope.BL.median(1:length(fr),i);
up1     = Resultados.sincope.BL.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)
hold on
mediana1= Resultados.sincope.HG.median(1:length(fr),i);
up1     = Resultados.sincope.HG.iq(1:length(fr),i);

errorbar(fr,mediana1,up1)

title([titles(i)])
ylabel("COH")
xlabel("Frequency (Hz)")
set(gca,'FontSize',10)
xlim([0.04 0.4])
legend("BL","HG","Significant")

end

return
