function Power_D
%% Power spectrum

%BL
load Baseline\Power_spectrum\Pbaseline.mat
control1=[1,2,3,6,10,11,13,14,17,23,25];
sincope1= [5,9,12,16,19,21,22,24];

Pw1= [LFn',HFn'];
Pr1=LFn./HFn';

% p(1,i)= ranksum(Pw(control,i),Pw(sincope,i));



%DB
load Deep_Breathing\Power_spectrum\PowerDB.mat
control2=[1,2,3,6,7,10,11,13,14,17,19,21,24];
sincope2= [5,9,16,20,22,23];

Pw2= [LFn',HFn'];
Pr2=LFn./HFn';



%HG
load Handgrip\Power_spectrum\PowerHG.mat
control3=[1,2,3,4,7,8,9,10,15];
sincope3= [6 11 13 14 16];

Pw3= [LFn',HFn'];
Pr3=LFn./HFn';




%Tilt

load Resultados_wpco\Power_spectrum\PowerT.mat

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
Pw4= [LFn(Ix)',HFn(Ix)'];
Pr4=LFn(Ix)'./HFn(Ix)';


Ix= contains(subj,tt(2));
subjx= subj(Ix);
sincope5= logical(nombrTT(subjx,1));
control5= logical(nombrTT(subjx,2));
Pw5= [LFn(Ix)',HFn(Ix)'];
Pr5=LFn(Ix)'./HFn(Ix)';


% TT70

load Resultados_wpco\Power_spectrum\PowerTV.mat
subj=dir("Prepro_hut70");
subj= {subj.name};
subj= subj(3:end);    
sincope6= logical(nombrTT(subj,1));
control6= logical(nombrTT(subj,2));
w= ["LFn","HFn"];
Pw6= eval(w{1}); %LF
Pw7= eval(w{2}); %hf
Pr67=Pw6./Pw7;


%% Tets  BL con DB, HG, TT20,TT45
% Control LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(control1,1),Pw2(control2,1),Pw3(control3,1),Pw4(control4,1),Pw5(control5,1));%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'on');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

% Control HF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(control1,2),Pw2(control2,2),Pw3(control3,2),Pw4(control4,2),Pw5(control5,2));%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

%% 
% Sincope LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(sincope1,1),Pw2(sincope2,1),Pw3(sincope3,1),Pw4(sincope4,1),Pw5(sincope5,1));%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

% Sincope HF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(sincope1,2),Pw2(sincope2,2),Pw3(sincope3,2),Pw4(sincope4,2),Pw5(sincope5,2));%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

%% Tets  BL con TT70

% Control LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(control1,1),...
    Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','-20','-15','-10','-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

% Control HF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(control1,2),...
    Pw7(1,control6)',Pw7(2,control6)',Pw7(3,control6)',Pw7(4,control6)',Pw7(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','-20','-15','-10','-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

%% 
% Sincope LF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(sincope1,1),...
    Pw6(1,sincope6)',Pw6(2,sincope6)',Pw6(3,sincope6)',Pw6(4,sincope6)',Pw6(5,sincope6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','t-20','t-15','t-10','t-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

% Sincope HF BL con DB, HG, TT20,TT45
matrix=padcat(Pw1(sincope1,2),...
    Pw7(1,control6)',Pw7(2,control6)',Pw7(3,control6)',Pw7(4,control6)',Pw7(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','t-20','t-15','t-10','t-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );
%% LF/HF BL con test no TT70
matrix=padcat(Pr1(control1,1),Pr2(control2,1),Pr3(control3,1),Pr4(control4,1),Pr5(control5,1));%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'on');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

matrix=padcat(Pr1(sincope1,1),Pr2(sincope2,1),Pr3(sincope3,1),Pr4(sincope4,1),Pr5(sincope5,1));%...
    %Pw6(1,control6)',Pw6(2,control6)',Pw6(3,control6)',Pw6(4,control6)',Pw6(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','DB','HG','TT20','TT45'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

matrix=padcat(Pr1(control1,1),...
    Pr67(1,control6)',Pr67(2,control6)',Pr67(3,control6)',Pr67(4,control6)',Pr67(5,control6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','-20','-15','-10','-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );

matrix=padcat(Pr1(sincope1,1),...
    Pr67(1,sincope6)',Pr67(2,sincope6)',Pr67(3,sincope6)',Pr67(4,sincope6)',Pr67(5,sincope6)');

[pe,tbl,stats]= kruskalwallis(matrix,{'BL','-20','-15','-10','-5','S'},'off');
[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','on' );






