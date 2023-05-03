%% Baseline statistics
function Power_CS
%% Power spectrum

%BL
load Baseline\Power_spectrum\Pbaseline.mat
% control=[1,2,3,6,7,10,11,13,14,17,20,22,25];
control=[1,2,3,6,10,11,13,14,17,23,25];
% sincope= [5,8,9,12,16,19,21,23,24];
sincope= [5,9,12,16,19,21,22,24];

Pw= [LFn',HFn'];
for i=1:2
Mc(1,i)= median(Pw(control,i),1)';
Ic(1,i)= iqr(Pw(control,i),1)';

Ms(1,i)= median(Pw(sincope,i),1)';
Is(1,i)= iqr(Pw(sincope,i),1)';

p(1,i)= ranksum(Pw(control,i),Pw(sincope,i));
end
p=p';
TpM1=[Mc(1),Ms(1),p(1);Mc(2),Ms(2),p(2)];
TpI1=[Ic(1),Is(1);Ic(2),Is(2)];


%DB
load Deep_Breathing\Power_spectrum\PowerDB.mat
% control=[1,2,3,6,7,10,11,13,14,15,17,19,24];
control=[1,2,3,6,7,10,11,13,14,17,19,21,24];
% sincope= [5,8,9,16,20,23];
sincope= [5,9,16,20,22,23];

Pw= [LFn',HFn'];
for i=1:2
Mc(1,i)= median(Pw(control,i),1)';
Ic(1,i)= iqr(Pw(control,i),1)';

Ms(1,i)= median(Pw(sincope,i),1)';
Is(1,i)= iqr(Pw(sincope,i),1)';

p(1,i)= ranksum(Pw(control,i),Pw(sincope,i));
end
p=p';
TpM2=[Mc(1),Ms(1),p(1);Mc(2),Ms(2),p(2)];
TpI2=[Ic(1),Is(1);Ic(2),Is(2)];

%HG
load Handgrip\Power_spectrum\PowerHG.mat
% control=[1,2,3,4,7,8,9,10,15];
control=[1,2,3,4,7,8,9,10,15];
% sincope= [5 6 11 13 14 16];
sincope= [6 11 13 14 16];

Pw= [LFn',HFn'];
for i=1:2
Mc(1,i)= median(Pw(control,i),1)';
Ic(1,i)= iqr(Pw(control,i),1)';

Ms(1,i)= median(Pw(sincope,i),1)';
Is(1,i)= iqr(Pw(sincope,i),1)';

p(1,i)= ranksum(Pw(control,i),Pw(sincope,i));
end
p=p';
TpM3=[Mc(1),Ms(1),p(1);Mc(2),Ms(2),p(2)];
TpI3=[Ic(1),Is(1);Ic(2),Is(2)];

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

Pw= [LFn(Ix)',HFn(Ix)'];
M=[];
I=[];

for c=1:2
Mc= median(Pw(control,c),1,"omitnan");
Ic= iqr(Pw(control,c),1);

Ms= median(Pw(sincope,c),1,"omitnan");
Is= iqr(Pw(sincope,c),1);

p= ranksum(Pw(control,c),Pw(sincope,c));

Pm= [Mc,Ms,p];
Pi= [Ic,Is];


M=[M;Pm];
I=[I;Pi];
end
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

    for j=1:2
        Pw= eval(w{j});
Mc= median(Pw(:,control),2,"omitnan");
Ic= iqr(Pw(:,control),2);

Ms= median(Pw(:,sincope),2,"omitnan");
Is= iqr(Pw(:,sincope),2);
for n=1:5
p(n)= ranksum(Pw(n,control),Pw(n,sincope));
end
if j==1
lfm= [Mc,Ms,p'];
else
   hfm= [Mc,Ms,p']; 
end

if j==1
lfi= [Ic,Is];
else
   hfi= [Ic,Is]; 
end
    end
Vf=[];
Bf=[];
for l=1:length(hfm)
    V=[lfm(l,:);hfm(l,:)];
    Vf=[Vf;V];

    B=[lfi(l,:);hfi(l,:)];
    Bf=[Bf;B];

end

MatrizmF= [TpM1;TpM2;TpM3;M2;Vf];%% Tabla final 
MatrizmF= [TpI1;TpI2;TpI3;I2;Bf];%% Tabla final

%% 

%pENDIENTE: rEVISAR BIEN A LOS SUJETOS DE CADA PRUEBA
% Revisar codigo para comprobar que todo este bien.

% Baseline