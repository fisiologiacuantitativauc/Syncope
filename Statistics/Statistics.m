%% Estadisticos 
%% Baseline
medianas_senales
%% Power spectrum
Power_CS   %Table
Power_D    %Table
Power_CS_LFHF
BRS_CS     %Table
BRS_D     %Table

boxplot_PS %Figures
%% Synchro
COH_D%Table
wpco_lines % Figures'

%% señales CV
mediana_senalesCV

%% dataframe
% [Twpco]=datos_cor; %de aca saco los datos de WPCO
% boxplot_PS %reciclado que me guarda los datos PS

load datos_correlacion\tidyWPCO.mat
WCPO= T;

load datos_correlacion\tidyPS.mat
PS= T;

labs=WCPO.Properties.VariableNames(3:end);
labsPS=["BL","DB","HG","HUT20","HUT45","t-20","t-15","t-10","t-5","Syncope"];
labsW =["BL","DB","HG","HUT20","HUT45","tempranaA","tempranaB","tardiaA","tardiaB","Si"];

STATTABLE=[];
v= [1,6,2,7,3,8,4,9,5,10];
for l=1:numel(labsPS)
    STAT=[];
for i=v%
LFcontrol= PS(PS.test==labsPS(l),4); %BL
WPCOLFcontrol= WCPO(WCPO.test==labsW(l),i+2);

V= sprintf('%s',strcat('WPCOLFcontrol.',labs{i}));
a= LFcontrol.HF;
b= eval(V);
if length(a)>length(b)|length(b)>length(a)
   aux=numel(a)-numel(b);
   if aux<0
       a=[a;nan(abs(aux),1)];
   elseif aux>0
       b=[b;nan(abs(aux),1)];
   end

end
[R,P] = corrcoef(a,b,'rows','complete');
stat= [R(2);P(2)];
STAT(:,i)= stat;
% Z= [LFcontrol.LF,eval(v)];
% scatter(Z(:,1),Z(:,2))
% 
% m1=fitlm(Z(:,1),Z(:,2));
% plot(m1)
% xlabel("LFHF")
% ylabel(v)
% pause
end
STATTABLE= [STATTABLE;STAT];
end
















