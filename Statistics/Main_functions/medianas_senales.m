function medianas_senales
load Baseline\Indices\medianaBL.mat

control=[1,2,3,6,7,10,11,13,14,15,17,19,20,22,25];
sincope= [5,8,9,12,16,21,23,24];

Mc= median(medianaBL(control,:),1)';
Ic= iqr(medianaBL(control,:),1)';

Ms= median(medianaBL(sincope,:),1)';
Is= iqr(medianaBL(sincope,:),1)';

p=[];
for i=1:4
    p(i)= ranksum(medianaBL(control,i),medianaBL(sincope,i));

end
p=p';