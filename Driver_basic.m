clc
close all
clear all
addpath(genpath('C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal'));

load test.mat
%% BL
%Data selection and fix points
selectdat_BL(test.baseline,"baseline");

subj=dir("baseline\Lab_data");
subj= {subj.name};
subj= subj(3:end);
medianaBL=[];
for l=1:length(subj)
    subj
    [M]=medianasBL(subj{l});
    medianaBL=[medianaBL;M];
  
end

fil_mediana=['C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal\Baseline\Indices\' 'medianaBL'];
save(fil_mediana,"medianaBL")
load medianaBL.mat

HFn= [];
LFn= [];
BRS=[];
for l=1:length(subj)
    [LF,HF]=powerS(subj{l},"BL");
    HFn(l)=HF;
    LFn(l)=LF;

    [BRSx, BRSx_f,BRSxm]= Baroreflex(subj{l},"BL");
    BRS(l)=BRSxm;
 
end
save(strcat("Baseline\Power_spectrum\","Pbaseline"),"LFn","HFn")
save(strcat("BRS\","Baseline\BRSbaseline"),"BRS")


%% HUT
%seleccion de variables 
selectdat_hut(test.inicioTT20,"TT20");
selectdat_hut(test.inicioTT45,"TT45");
selectdat_hut(test.inicioTT70,"TT70");

selectdat_baseline(test.baseline,"baseline");

%preprocesamiento
subj=dir("variables_hut");
subjects= {subj.name};
subjects= subjects(3:end);
for i=1:numel(subjects)
prepro_hut(subjects{i})
end

subj=dir("Variables_baseline");
subjects= {subj.name};
subjects= subjects(3:end);
for i=1:numel(subjects)
prepro_baseline(subjects{i})
end

%Guardar hut preprocesado ACA
subj=dir("Prepro_hut");
% subj=dir("variables_hut");
subj= {subj.name};
subjects2= subj(3:end);
for i=1:numel(subjects2)
ventanas(subjects2{i})
end

% prepro ventanas
subj=dir("resultados\hut70");
subj= {subj.name};
subj= subj(3:end);
for l=1:length(subj)
    preproventana(subj{l})
end


%synchronization (SEGUIR EN EL ANALISIS DE LAS VENTANAS)

WFCO

%statistics
estadisticos

%%%Power spectrum
subj=dir("variables_hut");
subj= {subj.name};
subj= subj(3:end);
HFn=[];
LFn=[];
BRS=[];
for l=1:length(subj)
    [LF,HF]=powerS(subj{l},"HUT");
    HFn(l)=HF;
    LFn(l)=LF;
    if contains(subj{l},"carlos_valleTT45.mat")
        BRS(l)=nan;
    else
    [BRSx, BRSx_f,BRSxm]= Baroreflex(subj{l},"HUT");
    BRS(l)=BRSxm; 
    end
end
save(strcat("Resultados_wpco\Power_spectrum\","PowerT"),"LFn","HFn")
save(strcat("BRS\","HUT2045\BRShut2040"),"BRS")
%Power ventanas

subj=dir("Prepro_hut70");
subj= {subj.name};
subj= subj(3:end);
LFn=[];
HFn=[];
BRS=[];
labels=["tempranaA","tempranaB","tardiaA","tardiaB","sincope"];
for i=1:length(subj)
    load(subj{i})
    for j=1:5
    [LF,HF]=powerS(windows.RR_s.(labels(j)),"HUT");
    LFn(j,i)=LF;
    HFn(j,i)=HF;
        
    f=min([length(windows.RR_s.(labels(j))),length(windows.SBP_s.(labels(j)))]);
    d= [windows.RR_s.(labels(j))(1:f,:),windows.SBP_s.(labels(j))(1:f,:)];
    [BRSx, BRSx_f,BRSxm]= Baroreflex(d,"HUT");
    BRS(j,i)=BRSxm; 
    end
end
save(strcat("Resultados_wpco\Power_spectrum\","PowerTV"),"LFn","HFn")
save(strcat("BRS\HUT70\","BRShut70"),"BRS")




%% Deep breathing

%Data selection and fix points
selectdat_RP(test.inicioRP1,"RP");

%index
subj=dir("Deep_Breathing\Lab_data");
subj= {subj.name};
subj= subj(3:end);
mean_=[];
median_=[];
for l=1:length(subj)
    indexRP(subj{l})
%     [mean_idx,median_idx]=indexRP(subj{l});
%     mean_=[mean_,mean_idx];
%     median_=[median_,mean_idx];
end
% fil_mean=['C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal\Deep_Breathing\Indices\' 'media'];
% save(fil_mean,"mean_");
%  fil_mediana=['C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal\Deep_Breathing\Indices\' 'mediana'];
%  save(fil_mediana,"median_")
% Grafico
load mediana.mat
plotDB(median_,[1,2,3,6,10,11,13,14,17,21,24],[5,9,16,20,22,23],'RR modulation','Amplitude (Heart beats)')
% plotDB(median_,[1,2,3,6,7,10,11,13,14,17,19,21,24],[5,9,16,20,23],'RR modulation','Amplitude (Heart beats)')
% [1,2,3,6,7,10,11,13,14,17,19,21,24],[5,9,16,20,23]
%median_c=median(median_([1,2,3,6,7,10,11,13,14,17,19,21,24]));
median_c=median(median_([1,2,3,6,10,11,13,14,17,21,24]));
%median_s=median(median_([5,8,9,16,20,23]));
median_s=median(median_([5,9,16,20,22,23]));

%IR_c=iqr(median_([1,2,3,6,7,10,11,13,14,17,19,21,24]));
IR_c=iqr(median_([1,2,3,6,10,11,13,14,17,21,24]));
%IR_s=iqr(median_([5,8,9,16,20,23]));
IR_s=iqr(median_([5,9,16,20,22,23]));


HFn=[];
LFn=[];
BRS=[];
%%% Power spectrum
for l=1:length(subj)
    [LF,HF]=powerS(subj{l},"DB");
    HFn(l)=HF;
    LFn(l)=LF;
    [BRSx, BRSx_f,BRSxm]= Baroreflex(subj{l},"DB");
    BRS(l)=BRSxm; 
   
end
 save(strcat("Deep_Breathing\Power_spectrum\","PowerDB"),"LFn","HFn")
 save(strcat("BRS\DeepBreathing\","BRSDB"),"BRS")

plotDB(LF,[1,2,3,6,7,10,11,13,14,15,17,19,24],[5 8 9 16 20 23],'LFn','%')
plotDB(HF,[1,2,3,6,7,10,11,13,14,15,17,19,24],[5 8 9 16 20 23],'HFn','%')

%%% Sincronization
for l=1:length(subj)
   prepro_DB(subj{l});
end

subj=dir("Deep_Breathing\Preprocesado");
subj= {subj.name};
subj= subj(3:end);
for l=1:length(subj)
   WFCO_DB(subj{l});
end

estadistico_DB;
estadistico_DBbh(2); %BL vs HG 1: sincope 2:baseline
WPCO_curvesDB;




%% Hand grip

selectdat_HG(test.iniciohg,"hg");

subj=dir("Handgrip\Lab_data");
subj= {subj.name};
subj= subj(3:end);
slopes=[];
minmaxs=[];
angles= [];
ts    = [];  
for l=1:length(subj)
    [slope,minmax,angle,t]=indexHG(subj{l});
    slopes=[slopes,slope];
    minmaxs=[minmaxs,minmax];
    angles=[angles,angle];
    ts    =[ts,t];
end
plotDB(angles,[1,2,3,4,7,8,9,10,15],[6 11 13 14 16],'LFn','%') %11 en s
% plotDB(angles,[1,2,3,4,7,8,9,10,15],[5 6 11 13 14 16],'LFn','%') %11 en s


%Curvas BP
curvasBP %contiene graficos error bar, boxplot y tabla resultados 30 sec

HFn=[];
LFn=[];
BRS=[];
%%% Power spectrum
for l=1:length(subj)
    [LF,HF]=powerS(subj{l},"HG");
    HFn(l)=HF;
    LFn(l)=LF;

    [BRSx, BRSx_f,BRSxm]= Baroreflex(subj{l},"HG");
    BRS(l)=BRSxm; 
end
 save(strcat("Handgrip\Power_spectrum\","PowerHG"),"LFn","HFn")
 save(strcat("BRS\Handgrip\","BRSHG"),"BRS")

plotDB(LF,[1,2,3,4,7,8,9,10,15],[6 11 13 14 16],'LFn','%')
plotDB(HF,[1,2,3,4,7,8,9,10,15],[6 11 13 14 16],'HFn','%')

%%% Sincronization
for l=1:length(subj)
   prepro_HG(subj{l});
end

subj=dir("Handgrip\Preprocesado");
subj= {subj.name};
subj= subj(3:end);
for l=1:length(subj)
   WFCO_HG(subj{l});
end

estadistico_HG;% Control vs Syncope
estadistico_HGbh(2); %BL vs HG 1: sincope 2:baseline
WPCO_curvesHG;




%% Valsalva

subj=dir("Valsalva\Lab_data");
subj= {subj.name};
subj= subj(3:end);
iA=nan(50,5);
iT=nan(50,4);
iG=nan(50,2);

for l=1:length(subj)
    l=l+1
    [indexA,indexT,indexG]=indexV(subj{l});
    iA(l,:)=indexA;
    iT(l,:)=indexT;
    iG(l,:)= indexG;
end

save("Valsalva\Indices\Ind_val","iA","iG","iT")

M=[];
I=[];
for w=1:3
[m,i]=parametrosV(w);
M=[M;m];
I=[I;i];
% close all
end

%%

Statistics
frame 


