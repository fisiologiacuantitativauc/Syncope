function curvasBP

%Baseline

load Baseline\Indices\medianaBL.mat
BLc= medianaBL([8,9,16,21,23,24]);
BLs= medianaBL([1,2,3,6,10,11,13,14,22]);


subj=dir("Handgrip\Lab_data");
subj= {subj.name};
subj= subj(3:end);


P=nan(300,16);
for l=1:length(subj)
    sys_s=[];
    load(subj{l})
    if l==6
        sys([1:5],:)=[];
    end
    sys(:,1)=sys(:,1)-sys(1,1);
    interp = spline(sys(:,1),sys(:,2),[0:1:sys(end,1)]);
    sys_s(:,1)=[0:1:sys(end,1)];
    sys_s(:,2)=interp;
    

    P(1:length(sys(:,2)),l)= sys(:,2)-sys(1,2);
 %P(1:length(sys(:,2)),l)=abs(sys(:,2));
%   P(1:length(sys_s(:,2)),l)=sys_s(:,1);
end

sg= P(1:180,[6 11 13 14 16]);%-BLc;
cg= P(1:180,[1,2,3,4,7,8,9,10,15]);%-BLs;%12

med_cg= median(cg,2);
med_sg= median(sg,2);

iqu_cg= prctile(cg,75,2); %iqr(cg,2);
iql_cg= prctile(cg,25,2);
iqu_sg= prctile(sg,75,2);
iql_sg= prctile(sg,25,2);

% e_cg   = errorbar(med_cg,iq_cg);
% hold on
% e_sg   = errorbar(med_sg,iq_sg);

[sig]= tests_I(cg, sg);
mark1=logical(sig);
ya=[med_cg+iq_cg, med_sg+iq_sg];
ya=max(ya,[],2);
t=1:1:180;

f1=figure(10);
tiledlayout(2,6,"TileSpacing","tight")
nexttile([1 6])
% e_cg   = errorbar(med_cg,iq_cg);
plot(t,med_cg,"LineWidth",2);hold on; 
plot(t,iqu_cg,t,iql_cg,"color",	"#0072BD","LineWidth",0.5,"LineStyle","--")
plot(t,med_sg,"LineWidth",2,"color",	"#D95319");hold on; 
plot(t,iqu_sg,t,iql_sg,"color",	"#D95319","LineWidth",0.5,"LineStyle","--")
xticks([0:30:180])
xlim([1 180])
ylim([-10 35])

hold on
% e_sg   = errorbar(med_sg,iq_sg);
% xlim([0 120])
% plot(t(mark1),ya(mark1)+0.01,'*black','LineWidth',0.5);


%title("Handgrip 3 minutes");
ylabel('\Delta SBP (mmHg)')
xlabel('Time (s)')
set(gca,'FontSize',14)
% fig=strcat('Handgrip/Figures/HG_3min.png');
% exportgraphics(f1,fig,'Resolution',300)



%% Boxplot
% clf;
tiempo= [1,30,60,90,120,150,180];
tbox  = [15,45,75,105,135,165];
titulos= ["1-30s","30-60s","60-90s","90-120s","120-150s","150-180s"];
T=[];   
L1=[];
L2=[];
ve=[];
for i= 1:6
    aux=i+1; 
    s= median(sg(tiempo(i):tiempo(aux),:),1);
    c= median(cg(tiempo(i):tiempo(aux),:),1);

    s=reshape(s,1,[]);
    c=reshape(c,1,[]);

    ve=[ve;[c';s']];

%     g1 = repmat({'Control'},length(c),1);
%     g2 = repmat({'Syncope'},length(s),1);
%     g = [g;[g1; g2]];

%     label1=[repelem(titulos(i),length(g1)),repelem(titulos(i),length(g2))];
    label1=[repelem(tbox(i)-4,length(g1)),repelem(tbox(i)+4,length(g2))];
    label2=[repelem("Control",length(g1)),repelem("Syncope",length(g2))];
    L1=[L1,label1];
    L2=[L2,label2];
end

Pw= [L1',L2',ve];

% test= Pw(:,1);
test= str2double(Pw(:,1));
group= Pw(:,2);
dat = str2double([Pw(:,3)]);
T = table(test,group,dat);
% T.test = categorical(T.test,titulos);

nexttile([1 6])

boxchart(T.test,T.dat,'GroupByColor',T.group,"BoxWidth",10)
xlim([1 180])
set(gca,'xtick',[15:30:180]);
xline([30,60,90,120,150],"--")
xticklabels(["1-30s","30-60s","60-90s","90-120s","120-150s","150-180s"])
ylabel('\Delta SBP(mmHg)')
set(gca,'FontSize',14)


% %     f1=figure(i);
% nexttile
%     boxtchart()
%     boxplot(ve,g)
%     p=ranksum(c,s)
%     sigstar({[1,2]},p);
% 
% %     title(titulos(i));
%     ylabel('\Delta BP')
%     xlabel('Time (s)')
%     set(gca,'FontSize',14)
%     fig=strcat('Handgrip/Figures/HG',string(i),'.png');
% %     exportgraphics(f1,fig,'Resolution',300)
%     
%     medc  = median(c,"omitnan");
%     meds  = median(s,"omitnan");
%     medcs = [medc,meds];
%     iqc   = iqr(c);
%     iqs   = iqr(s);
%     iqcs  = [iqc,iqs];

    T=[T;[medcs,iqcs]];
end

   










