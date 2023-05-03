function [T]=datos_cor

%Creacion dataframe de sincronizacion
%%  BL hut20 hut 45
resultados_mHF= zeros(8,5,2); %ventanas, variables, control/sincope
resultados_iqrHF=zeros(8,5,2);
resultados_mLF= zeros(8,5,2);
resultados_iqrLF=zeros(8,5,2);
HF= 15:84; %30:84
%HF= 15:176;
LF= 85:176;%137 176

carpetas= ["baseline","hut20","hut"];%hut es hut45
for l=1:length(carpetas)
    nombres= dir(strcat("Resultados_wpco/",carpetas(l)));
    nombres= {nombres.name};
    nombres= nombres(3:end);

    vector_s= logical(nombrTT(nombres));
    vector_n= (~vector_s);

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

if l==1
label1=[repelem("BL",length(control)),repelem("BL",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw7=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
elseif l==2
label1=[repelem("HUT20",length(control)),repelem("HUT20",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw8=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
else
label1=[repelem("HUT45",length(control)),repelem("HUT45",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw9=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
end
end

%% TT70

nombres= dir(strcat("Resultados_wpco/hut70"));
nombres= {nombres.name};
nombres= nombres(3:end);
ventanas= ["tempranaA","tempranaB","tardiaA","tardiaB","sincope"];
for l= 1:length(ventanas)
nombres_i= nombres(contains(nombres,ventanas(l)));
    vector_s= logical(nombrTT(nombres_i));
    vector_n= ~vector_s;

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

if l==1
label1=[repelem("tempranaA",length(control)),repelem("tempranaA",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw10=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
elseif l==2
label1=[repelem("tempranaB",length(control)),repelem("tempranaB",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw11=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
elseif l==3
label1=[repelem("tardiaA",length(control)),repelem("tardiaA",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw12=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
elseif l==4
label1=[repelem("tardiaB",length(control)),repelem("tardiaB",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw13=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];
else
label1=[repelem("Si",length(control)),repelem("Si",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw14=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];

end
end

%% DB

HF= 35:84; %30:84
LF= 85:176;%137 176
% signif_HF = zeros(8,5);

    nombres= dir("Deep_Breathing\WPCOR");
    nombres= {nombres.name};
    nombres= nombres(3:end);

    vector_s= logical(nombr(nombres));
    vector_n= (~vector_s);
    vector_n([4,18,21])= logical(0);
    vector_s([12,22])= logical(0);


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

label1=[repelem("DB",length(control)),repelem("DB",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw15=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];

%% HG
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

label1=[repelem("HG",length(control)),repelem("HG",length(sincope))];
label2=[repelem("Control",length(control)),repelem("Syncope",length(sincope))];
pw16=[label1',label2',[control(:,:,1);sincope(:,:,1)],[control(:,:,2);sincope(:,:,2)]];

tab= [pw7;pw8;pw9;pw10;pw11;pw12;pw13;pw14;pw15;pw16];
test= tab(:,1);
group= tab(:,2);
LFrrsbp   = str2double(tab(:,3));
LFrrdbp   = str2double(tab(:,4));
LFrrresp  = str2double(tab(:,5));
LFsbpresp = str2double(tab(:,6));
LFdbpresp = str2double(tab(:,7));

HFrrsbp   = str2double(tab(:,8));
HFrrdbp   = str2double(tab(:,9));
HFrrresp  = str2double(tab(:,10));
HFsbpresp = str2double(tab(:,11));
HFdbpresp = str2double(tab(:,12));


T = table(test,group,...
    LFrrsbp,LFrrdbp,LFrrresp,LFsbpresp,LFdbpresp,...
    HFrrsbp,HFrrdbp,HFrrresp,HFsbpresp,HFdbpresp);
file="C:\Users\marti\OneDrive\Documentos\tesis\Codigo_para_estructurar_datos\Nuevo_codigo_principal\datos_correlacion\tidyWPCO";
save(file,"T")

