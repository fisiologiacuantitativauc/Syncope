function wpco_lines_plot

%% HUT
resultados_mHF= zeros(8,5,2); %ventanas, variables, control/sincope
resultados_iqrHF_l=zeros(8,5,2);
resultados_iqrHF_u=zeros(8,5,2);
resultados_mLF= zeros(8,5,2);
resultados_iqrLF_l=zeros(8,5,2);
resultados_iqrLF_u=zeros(8,5,2);
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
V3_l= prctile(control,25);
V3_u= prctile(control,75);

V4_l=prctile(sincope,25);
V4_u=prctile(sincope,75);


resultados_mHF(l,:,1)=V1(:,:,1); %bl,hut20,hut45
resultados_mHF(l,:,2)=V2(:,:,1);

resultados_iqrHF_l(l,:,1)=V3_l(:,:,1);
resultados_iqrHF_u(l,:,1)=V3_u(:,:,1);
resultados_iqrHF_l(l,:,2)=V4_l(:,:,1);
resultados_iqrHF_u(l,:,2)=V4_u(:,:,1);

resultados_mLF(l,:,1)=V1(:,:,2);
resultados_mLF(l,:,2)=V2(:,:,2);

resultados_iqrLF_l(l,:,1)= V3_l(:,:,2);
resultados_iqrLF_u(l,:,1)= V3_u(:,:,2);
resultados_iqrLF_l(l,:,2)= V4_l(:,:,2);
resultados_iqrLF_u(l,:,2)= V4_u(:,:,2);


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
V3_l= prctile(control,25);
V3_u= prctile(control,75);

V4_l=prctile(sincope,25);
V4_u=prctile(sincope,75);

resultados_mHF(l+3,:,1)=V1(:,:,1);  
resultados_mHF(l+3,:,2)=V2(:,:,1);

resultados_iqrHF_l(l+3,:,1)= V3_l(:,:,1);
resultados_iqrHF_u(l+3,:,1)= V3_u(:,:,1);
resultados_iqrHF_l(l+3,:,2)= V4_l(:,:,1);
resultados_iqrHF_u(l+3,:,2)= V4_u(:,:,1);

resultados_mLF(l+3,:,1)=V1(:,:,2);
resultados_mLF(l+3,:,2)=V2(:,:,2);

resultados_iqrLF_l(l+3,:,1)= V3_l(:,:,2);
resultados_iqrLF_u(l+3,:,1)= V3_u(:,:,2);
resultados_iqrLF_l(l+3,:,2)= V4_l(:,:,2);
resultados_iqrLF_u(l+3,:,2)= V4_u(:,:,2);


end
% guardar estadisticos en nueva array

%%
%v=[1,9,10,2:8]; %orden de las pruebas
% v=[1:1:8]; %orden de las pruebas
v=[1,[4:1:8]];
titulo= ["SBP-RR","DBP-RR","RESP-RR","SBP-RESP","DBP-RESP"];
for i= 5

f1=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1)
errorbar([1:1:6],resultados_mHF(v,i,1),resultados_mHF(v,i,1)-resultados_iqrHF_l(v,i,1),resultados_iqrHF_u(v,i,1)-resultados_mHF(v,i,1),'o-','LineWidth',4)
hold on
errorbar([1:1:6],resultados_mHF(v,i,2),resultados_iqrHF_u(v,i,2)-resultados_iqrHF_l(v,i,2),resultados_iqrHF_u(v,i,2)-resultados_mHF(v,i,2),'o-','LineWidth',4)
xlim([0 7])
ylim([0 1])

title(strcat(titulo(i),' HF'))
ylabel("WPCO")
set(gca,'XTickLabel',[" ","BL","TT70_{t-20}","TT70_{t-10}","TT70_{t-15}","TT70_{t-5}","TT70_{Syncope}"," "]);
set(gca,'FontSize',14)
xtickangle(90)

for c=1:length(signif_HF)
if signif_HF(c,i)<=0.05
sigstar({[c,c]},signif_HF(c,i));
end
end
    
    fig=strcat('Resultados_wpco/Figuras/HF',titulo(i),'.png');
    exportgraphics(f1,fig,'Resolution',300)


end
%%

for i= 1
% f1=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,2)
errorbar([1:1:6],resultados_mLF(v,i,1),resultados_mLF(v,i,1)-resultados_iqrLF_l(v,i,1),resultados_iqrLF_u(v,i,1)-resultados_mLF(v,i,1),'o-','LineWidth',4)
hold on
errorbar([1:1:6],resultados_mLF(v,i,2),resultados_mLF(v,i,2)-resultados_iqrLF_l(v,i,2),resultados_iqrLF_u(v,i,2)-resultados_mLF(v,i,2),'o-','LineWidth',4)
xlim([0 7])
ylim([0.3 1])
legend("Control","Syncope","Location","south",'AutoUpdate','off')
% title(strcat(titulo(i)," LF"))
title(strcat(titulo(i),' LF'))
ylabel("WPCO")
set(gca,'XTickLabel',[" ","BL","TT70_{t-20}","TT70_{t-10}","TT70_{t-15}","TT70_{t-5}","TT70_{Syncope}"," "]);
set(gca,'FontSize',14)
xtickangle(90)


for c=1:length(signif_HF)
if signif_LF(c,i)<=0.05
sigstar({[c,c]},signif_LF(c,i));
end
end
%     fig=strcat('Resultados_wpco/Figuras/LF',titulo(i),'.png');
%     exportgraphics(f1,fig,'Resolution',300)


end



