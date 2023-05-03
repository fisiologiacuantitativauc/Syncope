function [indexA,indexT,indexG]=indexV(data)

load(data)

ind_s= abs(Tdata-val_start);
[xx,s]= min(ind_s);
ind_e= abs(Tdata-val_end);
[xx,e]=min(ind_e);
% sbp= [Tdata,SPdata];

figure
plot(SPdata);
hold on
xline(s)
xline(e)

%%
disp('Baseline')
[x,y] = ginput;
bl= mean(SPdata(x(1):x(2)));
%%
clf
plot(SPdata);
hold on
xline(s)
xline(e)
yline(bl)
disp('points')

[x,y] = ginput;
x=round(x);

ts1=[(x(1)-5):(x(1)+5)];
ts2= [(x(2)-5):(x(2)+5)];
ts3= [(x(3)-5):(x(3)+5)];
ts4= [(x(4)-5):(x(4)+5)];
ts5= [(x(5)-5):(x(5)+5)];
ts6= [(x(6)-5):(x(6)+5)];

[y(1),i1]= max(SPdata(ts1));
[y(2),i2]= min(SPdata(ts2));
[y(3),i3]= max(SPdata(ts3));
[y(4),i4]= min(SPdata(ts4));
[yf(5),i5]= min(abs([SPdata(ts5)]-bl));
aux=SPdata(ts5);
y(5)= aux(i5);
[y(6),i6]= max(SPdata(ts6));

x(1)= ts1(i1);
x(2)= ts2(i2);
x(3)= ts3(i3);
x(4)= ts4(i4);
x(5)= ts5(i5);
x(6)= ts6(i6);


A= bl-y(2)
C= y(3)-y(2);
B= y(3)-y(4);
D= y(5)-y(4);
E= y(6)-bl;

indexA= [A,B,C,D,E];

t1= Tdata(x(2))-Tdata(x(1));
t2= Tdata(x(3))-Tdata(x(2));
t3= Tdata(x(4))-Tdata(x(3));
prt=1718.6-Tdata(x(4)); %Ibarra
%prt=3078.6-Tdata(x(4)); %l=31
%prt=Tdata(x(5))-Tdata(x(4));

indexT=[t1,t2,t3,prt];

alfa= t2*C/sqrt(t2^2+C^2);
beta= prt*D/sqrt(prt^2+D^2);
indexG= [alfa,beta];

clf
plot(Tdata,SPdata);
hold on
plot(Tdata(x(1)),y(1),'ro');
plot(Tdata(x(2)),y(2),'ro');
plot(Tdata(x(3)),y(3),'r*');
plot(Tdata(x(4)),y(4),'ro');
plot(Tdata(x(5)),y(5),'ro');
plot(Tdata(x(6)),y(6),'ro');
pause


return