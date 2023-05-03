%% Baseline statistics
function Power_CS_LFHF
%% Power spectrum

%BL
load Baseline\Power_spectrum\Pbaseline.mat
control=[1,2,3,6,10,11,13,14,17,23,25];
sincope= [5,9,12,16,19,21,22,24];

Pw= [LFn'./HFn'];

Mc= median(Pw(control))';
Ic= iqr(Pw(control))';

Ms= median(Pw(sincope))';
Is= iqr(Pw(sincope))';

p= ranksum(Pw(control),Pw(sincope));

p=p';
TpM1=[Mc,Ms,p];
TpI1=[Ic,Is];


%DB
load Deep_Breathing\Power_spectrum\PowerDB.mat
control=[1,2,3,6,7,10,11,13,14,17,19,21,24];
sincope= [5,9,16,20,22,23];

Pw= [LFn./HFn'];

Mc= median(Pw(control))';
Ic= iqr(Pw(control))';

Ms= median(Pw(sincope))';
Is= iqr(Pw(sincope))';

p= ranksum(Pw(control),Pw(sincope));

p=p';
TpM2=[Mc(1),Ms(1),p(1)];
TpI2=[Ic(1),Is(1)];

%HG
load Handgrip\Power_spectrum\PowerHG.mat
control=[1,2,3,4,7,8,9,10,15];
sincope= [6 11 13 14 16];

Pw= [LFn'./HFn'];

Mc= median(Pw(control))';
Ic= iqr(Pw(control))';

Ms= median(Pw(sincope))';
Is= iqr(Pw(sincope))';

p= ranksum(Pw(control),Pw(sincope));

p=p';
TpM3=[Mc(1),Ms(1),p(1);];
TpI3=[Ic(1),Is(1)];

%Tilt

load Resultados_wpco\Power_spectrum\PowerT.mat

subj=dir("variables_hut");
subj= {subj.name};
subj= subj(3:end);
tt= ["TT20","TT45"];
M2=[];
I2=[];
% Tp=nan(2,3,2);
for i= 1:length(tt)
Ix= contains(subj,tt(i));
subjx= subj(Ix);
sincope= logical(nombrTT(subjx,1));
control=logical(nombrTT(subjx,2));

Pw= [LFn(Ix)'./HFn(Ix)'];
M=[];
I=[];


Mc= median(Pw(control),"omitnan");
Ic= iqr(Pw(control));

Ms= median(Pw(sincope),"omitnan");
Is= iqr(Pw(sincope));

p= ranksum(Pw(control),Pw(sincope));

Pm= [Mc,Ms,p];
Pi= [Ic,Is];


M=[M;Pm];
I=[I;Pi];

M2=[M2;M];
I2=[I2;I];

% TpM(:,:,i)=[Mc(1),Ms(1),p(1);Mc(2),Ms(2),p(2)];
% TpI(:,:,i)=[Ic(1),Is(1);Ic(2),Is(2)];

end

% TT70

load Resultados_wpco\Power_spectrum\PowerTV.mat
subj=dir("Prepro_hut70");
subj= {subj.name};
subj= subj(3:end);    
sincope= logical(nombrTT(subj,1));
control=logical(nombrTT(subj,2));

w= ["LFn","HFn"];

 
        Pw= eval(w{1})./eval(w{2});
Mc= median(Pw(:,control),2,"omitnan");
Ic= iqr(Pw(:,control),2);

Ms= median(Pw(:,sincope),2,"omitnan");
Is= iqr(Pw(:,sincope),2);
for n=1:5
p(n)= ranksum(Pw(n,control),Pw(n,sincope));
end

lfm= [Mc,Ms,p'];

lfi= [Ic,Is];

   

MatrizmF= [TpM1;TpM2;TpM3;M2;lfm];%% Tabla final 
MatrizmF= [TpI1;TpI2;TpI3;I2;lfi];%% Tabla final