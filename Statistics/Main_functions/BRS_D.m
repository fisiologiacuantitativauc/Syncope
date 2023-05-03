function BRS_D
%% Power spectrum

%BL
load BRS\Baseline\BRSbaseline.mat
control1=[1,2,3,6,10,11,13,14,17,23,25];
sincope1= [5,9,12,16,19,21,22,24];

Pw1= BRS;
% p(1,i)= ranksum(Pw(control,i),Pw(sincope,i));



%DB
load BRS\DeepBreathing\BRSDB.mat
control2=[1,2,3,6,7,10,11,13,14,17,19,21,24];
sincope2= [5,9,16,20,22,23];

Pw2= BRS;

%HG
load BRS\Handgrip\BRSHG.mat
control3=[1,2,3,4,7,8,9,10,15];
sincope3= [6 11 13 14 16];

Pw3= BRS;

%Tilt

load BRS\HUT2045\BRShut2040.mat

subj=dir("variables_hut");
subj= {subj.name};
subj= subj(3:end);
tt= ["TT20","TT45"];
M2=[];
I2=[];
% Tp=nan(2,3,2);
Ix= contains(subj,tt(1));
subjx= subj(Ix);
sincope4= logical(nombrTT(subjx,1));
control4=logical(nombrTT(subjx,2));
Pw4= BRS(Ix);



Ix= contains(subj,tt(2));
subjx= subj(Ix);
sincope5= logical(nombrTT(subjx,1));
control5= logical(nombrTT(subjx,2));
Pw5= BRS(Ix);



% TT70

load BRS\HUT70\BRShut70.mat
subj=dir("Prepro_hut70");
subj= {subj.name};
subj= subj(3:end);    
sincope6= logical(nombrTT(subj,1));
control6= logical(nombrTT(subj,2));

Pw6= BRS; %LF
% Pw7= eval(w{2}); %hf
% Pr67=Pw6./Pw7;


%% Tets  BL con DB, HG, TT20,TT45
% Control LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(control1)',Pw2(control2)',Pw3(control3)',Pw4(control4)',Pw5(control5)');%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'on');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

%% 
% Sincope LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(sincope1)',Pw2(sincope2)',Pw3(sincope3)',Pw4(sincope4)',Pw5(sincope5)');%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );


%% Tets  BL con TT70

% Control LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(control1)',...
    Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','-20','-15','-10','-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );


%% 
% Sincope LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(sincope1)',...
    Pw6(1,sincope6)',Pw6(2,sincope6)',Pw6(3,sincope6)',Pw6(4,sincope6)',Pw6(5,sincope6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','t-20','t-15','t-10','t-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );



