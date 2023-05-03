function [BRSx BRSx_f,BRSxm]= Baroreflex(d,test)
 
try
if ischar(d)
    load(d)
else
    rr=d(:,1:2);
    sys=d(:,3:4);
end

    
rr(:,1)= rr(:,1)-rr(1,1);
sys(:,1)= sys(:,1)-sys(1,1);
if test=="BL"
    if  rr(end,1)>=600
    t=600;
    elseif rr(end,1)>=300
        t=300;
    else
         t=rr(end,1);
    end
elseif test=="HG"
    t= 180;
elseif test == "DB"
    if rr(end,1)>100
        t=180;
    else
        t=60;
    end
elseif contains(test,"HUT")
    if rr(end,1)>=300
    t=300;
    else 
        t=rr(end,1);
    end
end




rr= [[0:1:rr(end,1)]',pchip(rr(:,1),rr(:,2),[0:1:rr(end,1)])'];
rr= rr(1:t,:);

sbp= [[0:1:sys(end,1)]',pchip(sys(:,1),sys(:,2),[0:1:sys(end,1)])'];
sbp= sbp(1:t-1,:);


rr_interpolado= rr;
presion_interpolado= sbp;
% figure()
% plot(xq',rr_interpolado,'-o')
% hold on
% plot(xq',presion_interpolado(:,1),'-o')


v = presion_interpolado(:,2); %sample vector
wl = 15; %window length
idx = [1:15:(length(v)-15)]'; %start indexes
v_PA = v(bsxfun(@plus,idx,0:wl-1))';  %extracted index

v2 = rr_interpolado(:,2); %sample vector
wl = 15; %window length
idx = [1:15:(length(v)-15)]'; %start indexes
v_rr = v2(bsxfun(@plus,idx,0:wl-1))';  %extracted index

sizevector= size(v_PA);
BestR=[];
for i= 1:sizevector(2)
    for p= 0:5
x= v_PA(:,i);
y= v_rr((find(v_PA(:,i),1,'first'):find(v_PA(:,i),1,'last'))+p)';
[c,lags] = xcorr(x,y,'coeff'); 
inx= find(lags==0);
r= c(inx);
R(p+1,:)= [r, p];

%seleccionar el mejor ajuste con el lag
idx2= find(R(:,1)== max(R(:,1)));
BestR(i,:)= [i, R(idx2,:)]; %ventana-R-delay

    end
end

%Ajuste de la regresion
BRX=[];
for d=1:(length(BestR))
mdl = fitlm(v_PA(:,d),[v_rr((find(v_PA(:,d),1,'first'):find(v_PA(:,d),1,'last'))+BestR(d,3))]');
BRX(d,:)=  [table2array(mdl.Coefficients(2,[1,4])),sqrt(mdl.Rsquared.Ordinary)];
end
BRX_t= [(1:1:(length(BestR)))', BRX,BestR(:,3)];

BRSx_p= BRX_t((BRX_t(:,3)<0.05)&(BRX_t(:,4)>0.3)&(BRX_t(:,2)<50)&(BRX_t(:,2)>=0),:);

BRSx_f= BRSx_p((BRSx_p(:,2)>0),:);
BRSx= BRX_t; %index,pendiente,pvalue,rsquare
BRSxm= median(BRSx_f(:,2));

catch
    BRSxm=nan;
    BRSx=nan;
    BRSx_f=nan;
    
end


end
