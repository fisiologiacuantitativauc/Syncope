function wpco_lines

%% HUT
resultados_mHF= zeros(8,5,2); %ventanas, variables, control/sincope
resultados_iqrHF=zeros(8,5,2);
resultados_mLF= zeros(8,5,2);
resultados_iqrLF=zeros(8,5,2);
HF= 15:84; %30:84
%HF= 15:176;
LF= 85:176;%137 176
signif_HF = zeros(8,5);

carpetas= ["baseline","hut20","hut"];%hut es hut45
for l=1:3
    nombres= dir(strcat("Resultados_wpco/",carpetas(l)));
    nombres= {nombres.name};
    nombres= nombres(3:end);

    vector_s= logical(nombrTT(nombres,1));
    vector_n= logical(nombrTT(nombres,2));

S1H=[];
S1L=[];
for i=1:length(nombres)
load(nombres{i})

% HF= 15:84; %30:84
% LF= 85:137;%137 176

sH  = mean(lim(HF,:),1,"omitnan"); %35:84  16:84,
sL  = mean(lim(LF,:),1,"omitnan");%85:128 85:end

S1H      = [S1H; sH];
S1L      = [S1L; sL];

end
control=[];
sincope=[]; %Seleccionar sujetos con sincope y sujetos control

control(:,:,1)= S1H(vector_n,:);
control(:,:,2)= S1L(vector_n,:);

sincope(:,:,1)= S1H(vector_s,:);
sincope(:,:,2)= S1L(vector_s,:);

% significant
pvalhf=[];
pvallf=[];
for j=1:5
p=median_test(control(:,j,1),sincope(:,j,1));
pvalhf= [pvalhf,p];

p=median_test(control(:,j,2),sincope(:,j,2));
pvallf= [pvallf,p];
end
signif_HF(l,:)= pvalhf;
signif_LF(l,:)= pvallf;

% guardar estadisticos en nueva array

V1=median(control,1,"omitnan");  %BL
V2=median(sincope,1,"omitnan");
V3= iqr(control,1);
V4=iqr(sincope,1);


resultados_mHF(l,:,1)=V1(:,:,1); %bl,hut20,hut45
resultados_mHF(l,:,2)=V2(:,:,1);
resultados_iqrHF(l,:,1)= V3(:,:,1);
resultados_iqrHF(l,:,2)= V4(:,:,1);

resultados_mLF(l,:,1)=V1(:,:,2);
resultados_mLF(l,:,2)=V2(:,:,2);
resultados_iqrLF(l,:,1)= V3(:,:,2);
resultados_iqrLF(l,:,2)= V4(:,:,2);


end

%Titl 70

nombres= dir(strcat("Resultados_wpco/hut70"));
nombres= {nombres.name};
nombres= nombres(3:end);
ventanas= ["tempranaA","tempranaB","tardiaA","tardiaB","sincope"];
for l= 1:length(ventanas)
nombres_i= nombres(contains(nombres,ventanas(l)));
    vector_s= logical(nombrTT(nombres_i,1));
    vector_n= logical(nombrTT(nombres_i,2));

S1H=[];
S1L=[];
for i=1:length(nombres_i)
load(nombres_i{i})

% HF= 15:84; %30:84
% LF= 85:176;%137

sH  = mean(lim(HF,:),1,"omitnan"); %35:84  16:84,
sL  = mean(lim(LF,:),1,"omitnan");%85:128 85:end

S1H      = [S1H; sH];
S1L      = [S1L; sL];
end

control=[];
sincope=[];

control(:,:,1)= S1H(vector_n,:);
control(:,:,2)= S1L(vector_n,:);

sincope(:,:,1)= S1H(vector_s,:);
sincope(:,:,2)= S1L(vector_s,:);

% significant
pvalhf=[];
pvallf=[];
for j=1:5
p=median_test(control(:,j,1),sincope(:,j,1));
pvalhf= [pvalhf,p];

p=median_test(control(:,j,2),sincope(:,j,2));
pvallf= [pvallf,p];
end
signif_HF(l+3,:)= pvalhf;
signif_LF(l+3,:)= pvallf;

% guardar estadisticos en nueva array

V1=median(control,1,"omitnan");  
V2=median(sincope,1,"omitnan");
V3= iqr(control,1);
V4=iqr(sincope,1);

resultados_mHF(l+3,:,1)=V1(:,:,1);  
resultados_mHF(l+3,:,2)=V2(:,:,1);
resultados_iqrHF(l+3,:,1)= V3(:,:,1);
resultados_iqrHF(l+3,:,2)= V4(:,:,1);

resultados_mLF(l+3,:,1)=V1(:,:,2);
resultados_mLF(l+3,:,2)=V2(:,:,2);
resultados_iqrLF(l+3,:,1)= V3(:,:,2);
resultados_iqrLF(l+3,:,2)= V4(:,:,2);


end



%% DB
HF= 35:84; %30:84
LF= 85:176;%137 176
% signif_HF = zeros(8,5);

    nombres= dir("Deep_Breathing\WPCOR");
    nombres= {nombres.name};
    nombres= nombres(3:end);

    vector_s= logical(nombrTT(nombres,1));
    vector_n= logical(nombrTT(nombres,2));
%     vector_n([4,18,21])= logical(0);
%     vector_s([12,22])= logical(0);


S1H=[];
S1L=[];
for i=1:length(nombres)
   
load(nombres{i})

% HF= 15:84; %30:84
% LF= 85:137;%137 176

try
sH  = mean(lim(HF,:),1,"omitnan"); %35:84  16:84,
sL  = mean(lim(LF,:),1,"omitnan");%85:128 85:end
catch
end

S1H      = [S1H; sH];
S1L      = [S1L; sL];

end
control=[];
sincope=[]; %Seleccionar sujetos con sincope y sujetos control

control(:,:,1)= S1H(vector_n,:);
control(:,:,2)= S1L(vector_n,:);

sincope(:,:,1)= S1H(vector_s,:);
sincope(:,:,2)= S1L(vector_s,:);

% significant
pvalhf=[];
pvallf=[];
for j=1:5
p=median_test(control(:,j,1),sincope(:,j,1));
pvalhf= [pvalhf,p];

p=median_test(control(:,j,2),sincope(:,j,2));
pvallf= [pvallf,p];
end
signif_HF(9,:)= pvalhf;
signif_LF(9,:)= pvallf;

V1=median(control,1,"omitnan");
V2=median(sincope,1,"omitnan");
V3= iqr(control,1);
V4=iqr(sincope,1);

resultados_mHF(9,:,1)=V1(:,:,1);
resultados_mHF(9,:,2)=V2(:,:,1);
resultados_iqrHF(9,:,1)= V3(:,:,1);
resultados_iqrHF(9,:,2)= V4(:,:,1);

resultados_mLF(9,:,1)=V1(:,:,2);
resultados_mLF(9,:,2)=V2(:,:,2);
resultados_iqrLF(9,:,1)= V3(:,:,2);
resultados_iqrLF(9,:,2)= V4(:,:,2);

% guardar estadisticos en nueva array

%% HG

HF= 35:84; %30:84
LF= 85:137;%137 176
% signif_HF = zeros(8,5);

    nombres= dir("Handgrip\WPCOR");
    nombres= {nombres.name};
    nombres= nombres(3:end);

    vector_s= logical(nombrTT(nombres,1));
    vector_n= logical(nombrTT(nombres,2));
%     vector_n([13,12])= logical(0);
%     vector_s([13])= logical(1);


S1H=[];
S1L=[];
for i=1:length(nombres)
   
load(nombres{i})

% HF= 15:84; %30:84
% LF= 85:137;%137 176

try
sH  = mean(lim(HF,:),1,"omitnan"); %35:84  16:84,
sL  = mean(lim(LF,:),1,"omitnan");%85:128 85:end
catch
end

S1H      = [S1H; sH];
S1L      = [S1L; sL];

end
control=[];
sincope=[]; %Seleccionar sujetos con sincope y sujetos control

control(:,:,1)= S1H(vector_n,:);
control(:,:,2)= S1L(vector_n,:);

sincope(:,:,1)= S1H(vector_s,:);
sincope(:,:,2)= S1L(vector_s,:);
pvalhf=[];
pvallf=[];
for j=1:5
p=median_test(control(:,j,1),sincope(:,j,1));
pvalhf= [pvalhf,p];

p=median_test(control(:,j,2),sincope(:,j,2));
pvallf= [pvallf,p];
end
signif_HF(10,:)= pvalhf;
signif_LF(10,:)= pvallf;

V1=median(control,1,"omitnan");
V2=median(sincope,1,"omitnan");
V3= iqr(control,1);
V4=iqr(sincope,1);

resultados_mHF(10,:,1)=V1(:,:,1);
resultados_mHF(10,:,2)=V2(:,:,1);
resultados_iqrHF(10,:,1)= V3(:,:,1);
resultados_iqrHF(10,:,2)= V4(:,:,1);

resultados_mLF(10,:,1)=V1(:,:,2);
resultados_mLF(10,:,2)=V2(:,:,2);
resultados_iqrLF(10,:,1)= V3(:,:,2);
resultados_iqrLF(10,:,2)= V4(:,:,2);
%arreglar Pvalues
signif_LF= [signif_LF(1,:);signif_LF(9:10,:);signif_LF(2:8,:)];
signif_HF= [signif_HF(1,:);signif_HF(9:10,:);signif_HF(2:8,:)];

TLF=[];
TLFi=[];
for z=1:5
C=[resultados_mLF(:,z,1),resultados_mLF(:,z,2)];
TLF=[TLF,C];

S=[resultados_iqrLF(:,z,1),resultados_iqrLF(:,z,2)];
TLFi=[TLFi,S];
end

THF=[];
THFi=[];
for z=1:5
C=[resultados_mHF(:,z,1),resultados_mHF(:,z,2)];
THF=[THF,C];

S=[resultados_iqrHF(:,z,1),resultados_iqrHF(:,z,2)];
THFi=[THFi,S];
end



%%
v=[1,9,10,2:8]; %orden de las pruebas
titulo= ["SBP-RR","DBP-RR","RESP-RR","SBP-RESP","DBP-RESP"];
for i= 1:5

f1=figure('units','normalized','outerposition',[0 0 1 1]);
errorbar(resultados_mHF(v,i,1),resultados_iqrHF(v,i,1),'o-','LineWidth',2)
hold on
errorbar(resultados_mHF(v,i,2),resultados_iqrHF(v,i,2),'o-','LineWidth',2)
xlim([0 11])
ylim([0 1])
legend("C","S","Location","south",'AutoUpdate','off')
title(strcat(titulo(i),' HF'))
ylabel("WPCO")
set(gca,'XTickLabel',[" ","BL","DB","HG","TT20","TT45","TT70_5","TT70_{10}","TT70_{15}","TT70_{20}","Syncope"," "]);
set(gca,'FontSize',12)

for c=1:length(signif_HF)
if signif_HF(c,i)<=0.05
sigstar({[c,c]},signif_HF(c,i));
end
end
    
    fig=strcat('Resultados_wpco/Figuras/HF',titulo(i),'.png');
    exportgraphics(f1,fig,'Resolution',300)


end
%%
for i= 1:5
f1=figure('units','normalized','outerposition',[0 0 1 1]);
errorbar(resultados_mLF(v,i,1),resultados_iqrLF(v,i,1),'o-','LineWidth',4)
hold on
errorbar(resultados_mLF(v,i,2),resultados_iqrLF(v,i,2),'o-','LineWidth',4)
xlim([0 11])
ylim([0.3 1])
legend("Control","Syncope","Location","south",'AutoUpdate','off')
% title(strcat(titulo(i)," LF"))
ylabel("WPCO")
set(gca,'XTickLabel',[" ","BL","DB","HG","TT20","TT45","TT70_{t-5}","TT70_{t-10}","TT70_{t-15}","TT70_{t-20}","TT70_{Sync}"," "]);
set(gca,'FontSize',14)


for c=1:length(signif_HF)
if signif_LF(c,i)<=0.05
sigstar({[c,c]},signif_LF(c,i));
end
end
    fig=strcat('Resultados_wpco/Figuras/LF',titulo(i),'.png');
    exportgraphics(f1,fig,'Resolution',300)


end
wpco_lines_plot


