function estadistico_HGbh(m)

resultados_mHF= zeros(5,2); %ventanas, variables, control/sincope
resultados_iqrHF=zeros(5,2);
resultados_mLF= zeros(5,2);
resultados_iqrLF=zeros(5,2);
HF= 35:84; %30:84
LF= 85:137;%137 176
% signif_HF = zeros(8,5);

    nombres1= dir("Handgrip\WPCOR");
    nombres1= {nombres1.name};
    nombres1= nombres1(3:end);

    nombres2= dir("Resultados_wpco\baseline\");
    nombres2= {nombres2.name};
    nombres2= nombres2(3:end);

    nombres= [nombres1,nombres2];

    [s_b,s_h,c_b,c_h]= nombr2_S(nombres);
    s_b           =logical(s_b);
    s_h           =logical(s_h);
    c_b           =logical(c_b);
    c_h           =logical(c_h);

    if m== 1
        s_b=c_b;
        s_h=c_h;
    end


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
baseline=[];
hand=[]; %Seleccionar sujetos con sincope y sujetos control

baseline(:,:,1)= S1H(s_b,:);
baseline(:,:,2)= S1L(s_b,:);

hand(:,:,1)= S1H(s_h,:);
hand(:,:,2)= S1L(s_h,:);

% significant
pvalhf=[];
pvallf=[];
for j=1:5
p=median_test(baseline(:,j,1),hand(:,j,1));
pvalhf= [pvalhf,p];

p=median_test(baseline(:,j,2),hand(:,j,2));
pvallf= [pvallf,p];
end
signif_HF(1,:)= pvalhf;
signif_LF(1,:)= pvallf;

% guardar estadisticos en nueva array


titulo= ["SBP-RR","DBP-RR","RESP-RR","SBP-RESP","DBP-RESP"];
grupo=["Syncope", "Control"];
for i= 1:5

% f1=figure('units','normalized','outerposition',[0 0 1 1]);
cg= baseline(:,i,1);
sg= hand(:,i,1);
ve=[cg;sg];

g1 = repmat({'Baseline'},length(cg),1);
g2 = repmat({'Handgrip'},length(sg),1);
g = [g1; g2];

f1=figure(1);
boxplot(ve,g)

p=ranksum(cg,sg);
sigstar({[1,2]},p);

ylim([0 1])
title(strcat(grupo(m),' ',titulo(i),' HF'))
ylabel("WPCO")
set(gca,'FontSize',12)

    
     fig=strcat('Handgrip\Figures\BL_HG',grupo(m),titulo(i),'HF','.png');
     exportgraphics(f1,fig,'Resolution',300)
pause

end

for i= 1:5
% f1=figure('units','normalized','outerposition',[0 0 1 1]);
cg= baseline(:,i,2);
sg= hand(:,i,2);
ve=[cg;sg];

g1 = repmat({'Baseline'},length(cg),1);
g2 = repmat({'Handgrip'},length(sg),1);
g = [g1; g2];

f1=figure(1);
boxplot(ve,g)

p=ranksum(cg,sg);
sigstar({[1,2]},p);

ylim([0 1])
title(strcat(grupo(m),' ',titulo(i),' LF'))
ylabel("WPCO")
set(gca,'FontSize',12)

    
     fig=strcat('Handgrip\Figures\BL_HG',grupo(m),titulo(i),'LF','.png');
     exportgraphics(f1,fig,'Resolution',300)
pause


end
