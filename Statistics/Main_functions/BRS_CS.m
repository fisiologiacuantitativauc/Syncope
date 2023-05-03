%% Baseline statistics
function BRS_CS
%% Power spectrum

%BL
load BRS\Baseline\BRSbaseline.mat
control=[1,2,3,6,10,11,13,14,17,23,25];
sincope= [5,9,12,16,19,21,22,24];

Mc= median(BRS(control),"omitnan")';
Ic= iqr(BRS(control))';

Ms= median(BRS(sincope),"omitnan")';
Is= iqr(BRS(sincope))';

p= ranksum(BRS(control),BRS(sincope));

TpM1=[Mc(1),Ms(1),p];
TpI1=[Ic(1),Is(1)];


%DB
load BRS\DeepBreathing\BRSDB.mat
control=[1,2,3,6,7,10,11,13,14,17,19,21,24];%19
sincope= [5,9,16,20,22,23];

Mc= median(BRS(control),"omitnan")';
Ic= iqr(BRS(control))';

Ms= median(BRS(sincope),"omitnan")';
Is= iqr(BRS(sincope))';

p= ranksum(BRS(control),BRS(sincope));

TpM2=[Mc,Ms,p];
TpI2=[Ic,Is];

%HG
load BRS\Handgrip\BRSHG.mat
control=[1,2,3,4,7,8,9,10,15];
sincope= [6 11 13 14 16];


Mc= median(BRS(control))';
Ic= iqr(BRS(control))';

Ms= median(BRS(sincope))';
Is= iqr(BRS(sincope))';

p= ranksum(BRS(control),BRS(sincope));


TpM3=[Mc,Ms,p];
TpI3=[Ic,Is];

%Tilt

load BRS\HUT2045\BRShut2040.mat

subj=dir("variables_hut");
subj= {subj.name};
subj= subj(3:end);
tt= ["TT20","TT45"];
M=[];
I=[];
% Tp=nan(2,3,2);
for i= 1:length(tt)
Ix= contains(subj,tt(i));
subjx= subj(Ix);
sincope= logical(nombrTT(subjx,1));
control=logical(nombrTT(subjx,2));

% Pw= [LFn(Ix)',HFn(Ix)'];
Pw= [BRS(Ix)'];



Mc= median(Pw(control),"omitnan");
Ic= iqr(Pw(control));

Ms= median(Pw(sincope),"omitnan");
Is= iqr(Pw(sincope),1);

p= ranksum(Pw(control),Pw(sincope));

Pm= [Mc,Ms,p];
Pi= [Ic,Is];


M=[M;Pm];
I=[I;Pi];
end
% M2=[M2;M];
% I2=[I2;I];

% TpM(:,:,i)=[Mc(1),Ms(1),p(1);Mc(2),Ms(2),p(2)];
% TpI(:,:,i)=[Ic(1),Is(1);Ic(2),Is(2)];



% TT70

load BRS\HUT70\BRShut70.mat
subj=dir("Prepro_hut70");
subj= {subj.name};
subj= subj(3:end);    
sincope= logical(nombrTT(subj,1));
control=logical(nombrTT(subj,2));

Pw= BRS;
Mc= median(Pw(:,control),2,"omitnan");
Ic= iqr(Pw(:,control),2);

Ms= median(Pw(:,sincope),2,"omitnan");
Is= iqr(Pw(:,sincope),2);
for n=1:5
p(n)= ranksum(Pw(n,control),Pw(n,sincope));
end

brM= [Mc,Ms,p'];


bri= [Ic,Is];


MatrizmF= [TpM1;TpM2;TpM3;M;brM];%% Tabla final 
MatriziF= [TpI1;TpI2;TpI3;I;bri];%% Tabla final

%% 

%pENDIENTE: rEVISAR BIEN A LOS SUJETOS DE CADA PRUEBA
% Revisar codigo para comprobar que todo este bien.

% Baseline