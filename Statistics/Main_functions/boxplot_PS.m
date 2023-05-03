function boxplot_PS
%% BL
load Baseline\Power_spectrum\Pbaseline.mat
control1=[1,2,3,6,10,11,13,14,17,23,25];
% control1=[1,2,3,6,7,10,11,13,14,17,20,22,25];
sincope1= [5,9,12,16,19,21,22,24];%24
% sincope1= [5,8,9,12,16,19,21,23];%24
LFnC= LFn(control1);
HFnC= HFn(control1);
LFnS= LFn(sincope1);
HFnS= HFn(sincope1);
label1=[repelem("BL",length(LFnC)),repelem("BL",length(LFnS))];
label2=[repelem("Control",length(LFnC)),repelem("Syncope",length(LFnS))];


Pw1= [label1',label2',[LFnC,LFnS]',[HFnC,HFnS]'];

%% DB
load Deep_Breathing\Power_spectrum\PowerDB.mat
%control2=[1,2,3,6,7,10,11,13,14,17,19,21,24]; %e: 15 a:21
control2=[1,2,3,6,7,10,11,13,14,17,19,21,24]; %e: 15 a:21
% sincope2= [5,8,9,16,20,22,23];%a:22 23 
sincope2= [5,9,16,20,22,23];%a:22 23

LFnC= LFn(control2);
HFnC= HFn(control2);
LFnS= LFn(sincope2);
HFnS= HFn(sincope2);
label1=[repelem("DB",length(LFnC)),repelem("DB",length(LFnS))];
label2=[repelem("Control",length(LFnC)),repelem("Syncope",length(LFnS))];


Pw2= [label1',label2',[LFnC,LFnS]',[HFnC,HFnS]'];




%% HG
load Handgrip\Power_spectrum\PowerHG.mat
control3=[1,2,3,4,7,8,9,10,15];%a:12
sincope3= [6 11 13 14 16];
%sincope3= [5 6 11 13 14 16];
LFnC= LFn(control3);
HFnC= HFn(control3);
LFnS= LFn(sincope3);
HFnS= HFn(sincope3);
label1=[repelem("HG",length(LFnC)),repelem("HG",length(LFnS))];
label2=[repelem("Control",length(LFnC)),repelem("Syncope",length(LFnS))];


Pw3= [label1',label2',[LFnC,LFnS]',[HFnC,HFnS]'];

%% Tilt

load Resultados_wpco\Power_spectrum\PowerT.mat

subj=dir("variables_hut");
subj= {subj.name};
subj= subj(3:end);
tt= ["TT20","TT45"];
M2=[];
I2=[];
% Tp=nan(2,3,2);
Ix= contains(subj,tt(1));
subjx= subj(Ix);
lf= LFn(Ix);
hf= HFn(Ix);
sincope4= logical(nombrTT(subjx,1));
control4= logical(nombrTT(subjx,2));
LFnC= lf(control4);
HFnC= hf(control4);
LFnS= lf(sincope4);
HFnS= hf(sincope4);
label1=[repelem("TT20",length(LFnC)),repelem("TT20",length(LFnS))];
label2=[repelem("Control",length(LFnC)),repelem("Syncope",length(LFnS))];


Pw4= [label1',label2',[LFnC,LFnS]',[HFnC,HFnS]'];

% Pw4= [LFn(Ix)',HFn(Ix)'];

Ix= contains(subj,tt(2));
subjx= subj(Ix);
lf= LFn(Ix);
hf= HFn(Ix);
sincope5= logical(nombrTT(subjx,1));
control5=logical(nombrTT(subjx,2));
LFnC= lf(control5);
HFnC= hf(control5);
LFnS= lf(sincope5);
HFnS= hf(sincope5);
label1=[repelem("TT45",length(LFnC)),repelem("TT45",length(LFnS))];
label2=[repelem("Control",length(LFnC)),repelem("Syncope",length(LFnS))];


Pw5= [label1',label2',[LFnC,LFnS]',[HFnC,HFnS]'];





%%  TT70

load Resultados_wpco\Power_spectrum\PowerTV.mat
subj=dir("Prepro_hut70");
subj= {subj.name};
subj= subj(3:end);    
sincope6= logical(nombrTT(subj,1));
control6=logical(nombrTT(subj,2));
w= ["LFn","HFn"];
lf= eval(w{1}); %LF
hf= eval(w{2}); %hf

LFnC= lf(:,control6)';
HFnC= hf(:,control6)';
LFnS= lf(:,sincope6)';
HFnS= hf(:,sincope6)';
et=["TT70_{t-20}","TT70_{t-15}","TT70_{t-10}","TT70_{t-5}","TT70_{Syncope}"];
Pw6=[];
for k=1:length(et)
label1=[repelem(et(k),length(LFnC)),repelem(et(k),length(LFnS))];
label2=[repelem("Control",length(LFnC)),repelem("Syncope",length(LFnS))];

Pw= [label1',label2',[[LFnC(:,k),HFnC(:,k)];[LFnS(:,k),HFnS(:,k)]]];
Pw6= [Pw6;Pw];
end

% tab=[Pw1;Pw2;Pw3;Pw4;Pw5;Pw6];
tab=[Pw1;Pw4;Pw5;Pw6];
test= tab(:,1);
group= tab(:,2);
LF   = str2double(tab(:,3));
HF   = str2double(tab(:,4));
HFLF = LF./HF; 

T = table(test,group,LF,HF,HFLF);
file="C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal\datos_correlacion\tidyPS";
% save(file,"T")

% Order=["BL","DB","HG","HUT20","HUT45","t-20","t-15","t-10","t-5","Syncope"];
Order=["BL","TT20","TT45","TT70_{t-20}","TT70_{t-15}","TT70_{t-10}","TT70_{t-5}","TT70_{Syncope}"];
T.test = categorical(T.test,Order);

tiledlayout(2,1)

nexttile
boxchart(T.test,T.LF,'GroupByColor',T.group)
for j=1:length(Order)
    C=table2array(T(T.test==Order(j) & T.group=="Control",3));
    S=table2array(T(T.test==Order(j) & T.group=="Syncope",3));   
    Cm(j)=median(C,"omitnan");
    Sm(j)=median(S,"omitnan");
end
hold on
    plot([1:1:8]-0.25,Cm,"--.","Color","#0072BD",'HandleVisibility','off')
    plot([1:1:8]+0.25,Sm,"--.","Color",	"#D95319",'HandleVisibility','off')
legend("Control","Syncpe"," ", " ")
ylabel("LFn (%)")
ylim([0 110])
set(gca,'FontSize',18)
xticklabels({"BL","TT20","TT45","TT70_{t-20}","TT70_{t-15}","TT70_{t-10}","TT70_{t-5}","TT70_{Syncope}"})


nexttile
boxchart(T.test,T.HF,'GroupByColor',T.group)
for j=1:length(Order)
    C=table2array(T(T.test==Order(j) & T.group=="Control",4));
    S=table2array(T(T.test==Order(j) & T.group=="Syncope",4));   
    Cm(j)=median(C,"omitnan");
    Sm(j)=median(S,"omitnan");
end
legend("Control","Syncpe")
hold on
    plot([1:1:8]-0.25,Cm,"--.","Color","#0072BD",'HandleVisibility','off')
    plot([1:1:8]+0.25,Sm,"--.","Color",	"#D95319",'HandleVisibility','off')

ylabel("HFn(%)")
ylim([0 110])
set(gca,'FontSize',18)
%xticklabels({"BL","HUT20","HUT45","TT70_{t-20}","TT70_{t-15}","TT70_{t-10}","TT70_{t-5}","TT70_{Syncope}"})

figure
boxchart(T.test,T.HFLF,'GroupByColor',T.group)
legend
ylabel("LF/HF")
ylim([0 30])
set(gca,'FontSize',12)







