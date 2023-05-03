function estadistico_HG

resultados_mHF= zeros(5,2); %ventanas, variables, control/sincope
resultados_iqrHF=zeros(5,2);
resultados_mLF= zeros(5,2);
resultados_iqrLF=zeros(5,2);
HF= 35:84; %30:84
LF= 85:137;%137 176
% signif_HF = zeros(8,5);

    nombres= dir("Handgrip\WPCOR");
    nombres= {nombres.name};
    nombres= nombres(3:end);

    vector_s= logical(nombr(nombres));
    vector_n= (~vector_s);
    vector_n([13,12])= logical(0);
    vector_s([13])= logical(1);


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
signif_HF(1,:)= pvalhf;
signif_LF(1,:)= pvallf;

% guardar estadisticos en nueva array


titulo= ["SBP-RR","DBP-RR","RESP-RR","SBP-RESP","DBP-RESP"];
for i= 1:5

% f1=figure('units','normalized','outerposition',[0 0 1 1]);
cg= control(:,i,1);
sg= sincope(:,i,1);
ve=[cg;sg];

g1 = repmat({'Control'},length(cg),1);
g2 = repmat({'Syncope'},length(sg),1);
g = [g1; g2];

f1=figure(1);
boxplot(ve,g)

p=ranksum(cg,sg);
sigstar({[1,2]},p);

ylim([0 1])
title(strcat(titulo(i),' HF'))
ylabel("WPCO")
set(gca,'FontSize',12)

    
%     fig=strcat('Resultados_wpco/Figuras/TTHF',titulo(i),'.png');
%     exportgraphics(f1,fig,'Resolution',300)
pause

end

for i= 1:5
% f1=figure('units','normalized','outerposition',[0 0 1 1]);
cg= control(:,i,2);
sg= sincope(:,i,2);
ve=[cg;sg];

g1 = repmat({'Control'},length(cg),1);
g2 = repmat({'Syncope'},length(sg),1);
g = [g1; g2];

f1=figure(1);
boxplot(ve,g)

p=ranksum(cg,sg);
sigstar({[1,2]},p);

ylim([0 1])
title(strcat(titulo(i),' LF'))
ylabel("WPCO")
set(gca,'FontSize',12)

    
%     fig=strcat('Resultados_wpco/Figuras/TTHF',titulo(i),'.png');
%     exportgraphics(f1,fig,'Resolution',300)
pause


end
