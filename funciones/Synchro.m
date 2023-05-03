function [C,thC, fig,fr1]= Synchro(signal1,signal2,sf,name1,name2,name,graph)
%ntail: Corte de colas
%: HF=1 LF=2

%vector mas corto 
tamano= [length(signal1),length(signal2)];
h= min(tamano);
time= 0:0.2:((h-1)*0.2);
%Para mejorar la estimacion del indice utilizando wavelet, se selecciono la
%frecuencia predominante utilizando la suma del modulo de los elemtens de
%cada escala utilizando la funcion 'frecuenciapredom'

% if flag ==1
%HF

%CWT
[coe1,fr1,coi1] = cwt(signal1(1:h,2),sf,FrequencyLimits=[0.01 0.5],VoicesPerOctave=48);%VoicesPerOctave=48
coiless1= decoi(coe1,fr1,coi1);
% [coe1,fr1] = cwt(signal1(1:h,2),sf,FrequencyLimits=[0.001 0.5],TimeBandwidth=60,VoicesPerOctave=48);%WaveletParameters=[3,60]
[coe2,fr2,coi2] = cwt(signal2(1:h,2),sf,FrequencyLimits=[0.01 0.5],VoicesPerOctave=48);
coiless2= decoi(coe2,fr2,coi2);

% WAVELET COHERENCE
cos_phi= ((real(coiless1).*real(coiless2))+(imag(coiless1).*imag(coiless2)))./ ((sqrt((real(coiless1).^2)+(imag(coiless1)).^2) .* sqrt((real(coiless2).^2)+(imag(coiless2).^2))));
sin_phi= ((imag(coiless1).*real(coiless2))-(real(coiless1).*imag(coiless2)))./ ((sqrt((real(coiless1).^2)+(imag(coiless1)).^2) .* sqrt((real(coiless2).^2)+(imag(coiless2).^2))));

% Av_cos= sum(cos_phi,2,"omitnan")./length(cos_phi);
Av_cos= mean(cos_phi,2,"omitnan");
% Av_sin= sum(sin_phi,2,"omitnan")./length(sin_phi);
Av_sin= mean(sin_phi,2,"omitnan");

C= sqrt((Av_cos.^2) + (Av_sin.^2));

[C_m ,C_sd,Th]= surro(signal1(1:h,2),signal2(1:h,2),sf,C,50);

 thC= zeros(length(C),1);
for z= 1:length(C)
    if C(z)<= Th(z)
        thC(z) = NaN;
    else
        thC(z) = C(z);
    end
end

% %SYNCHRONIZATION INDEX
% 
% 
% phi1= angle(coe1);
% phi2= angle(coe2);
% 
% dphi= phi1-phi2;
% 
% A= sum(sin(dphi),2)./length(dphi);
% B= sum(cos(dphi),2)./length(dphi);
% % circular_mean= atan(A./B)
% 
% gamma= (B.^2 + A.^2);


%% figuras
if graph==1
[sst1,f1] = wsst(signal1(1:h,2),sf,VoicesPerOctave=48);
[sst2,f2] = wsst(signal2(1:h,2),sf,VoicesPerOctave=48);
mask1=[(f1<0.4) .*  (f1>=0.04)];
mask2=[(f2<0.4) .*  (f2>=0.04)];

sst1= sst1.*mask1';%changue mask
f1  = f1.*mask1;
sst1= sst1(f1>0,:);
f1  = f1(f1>0) ;

sst2= sst2.*mask2';%changue mask
f2  = f2.*mask2;
sst2= sst2(f2>0,:);
f2  = f2(f2>0) ;


% if stat{1}== 0
%     synchro= nan;
% else
%     synchro= d1;
% end




fig= figure('units','normalized','outerposition',[0 0 1 1],'visible','off');


fig=tiledlayout(3,3);
title(fig,name,'Interpreter','none');

nexttile(1);

pcolor(time,f1,abs(sst1))
shading interp
% set(gca,'FontSize',12)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
hold on
ylim([0.04 0.4])
set(gca,'YTick',(0.04:0.04:0.5))
xlim([0 max(time)])
set(gca,'XTick',(0:50:max(time)))
% yline(f1(max(find(abs([f1-0.4])<=0.01))),'--r','LineWidth',1.5)
yline(f1(max(find(abs([f1-0.15])<=0.01))),'--r','LineWidth',3)
title(name1)
colorbar
% yline(fHF(max(find(abs([fHF-0.1])<=0.001))),'--y','LineWidth',.5)

nexttile(2)

pcolor(time,f2,abs(sst2))
shading interp
% set(gca,'FontSize',12)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
hold on
ylim([0.04 0.4])
set(gca,'YTick',(0.04:0.04:0.5))
xlim([0 max(time)])
set(gca,'XTick',(0:50:max(time)))
% yline(f1(max(find(abs([f1-0.4])<=0.01))),'--r','LineWidth',1.5)
yline(f2(max(find(abs([f2-0.15])<=0.01))),'--r','LineWidth',3)
title(name2)
colorbar
% yline(fHF(max(find(abs([fHF-0.1])<=0.001))),'--y','LineWidth',.5)

nexttile(4)

[wcoh,wcs,freq] = wcoherence(signal1(1:h,2),signal2(1:h,2),sf,'FrequencyLimits',[0.04 0.4],...
    'VoicesPerOctave',32,'NumScalesToSmooth',10);
pcolor(time,freq,abs(wcoh))
shading interp
title('Wavelet coherence')
% set(gca,'FontSize',12)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
hold on
ylim([0.04 0.4])
set(gca,'YTick',(0.04:0.04:0.5))
xlim([0 max(time)])
set(gca,'XTick',(0:50:max(time)))
colorbar
hold off


nexttile(7)
[wcoh,wcs,freq] = wcoherence(signal1(1:h,2),signal2(1:h,2),sf,'FrequencyLimits',[0.04 0.4],...
    'VoicesPerOctave',32);
% pcolor(time,freq,rad2deg(angle(wcs)))
% shading interp

A=imagesc(time,freq,rad2deg(angle(wcs)));
set(gca,'YDir','normal')
% A.colormap("gray")

title('Relative phase')
set(gca,'FontSize',12)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
hold on
ylim([0.04 0.4])
set(gca,'YTick',(0.04:0.04:0.5))
xlim([0 max(time)])
set(gca,'XTick',(0:50:max(time)))
colorbar
% clim([-180 180])



% plot(fr1,gamma)
% title('Synhronization index')
% xlabel('Frequency (Hz)')
% ylabel('Sync')

nexttile(3)
hold on
plot(fr1,C_m,'-.black'); 
plot(fr1,Th,'--black')
plot(fr1,C,'.-black', 'LineWidth',0.1)
title('Wavelet phase coherence')

xline(0.15)
xline(0.08)
xlim([0.05 0.4])
ylim([0 1])
xlabel('Frequency (Hz)')
ylabel('WPC')
% legend("Mean surrogate","Th","Coherence",'FontSize',0.2)


if name1 == "SBP" | name1 == "DBP"
    a=strcat(name1,' '," mmHg");
elseif name1 == "RR"
    a= "IBI (sec)";
elseif name1 == "MSNA"
    a= "MSNA (mV)";
    global MSNAI_s1
elseif name1 == "RESP"
    a= "Resp";
end

if name2 == "SBP" | name2 == "DBP"
    b=strcat(name2,' '," mmHg");
elseif name2 == "RR"
    b= "IBI (sec)";
elseif name2 == "MSNA"
    b= "MSNA (mV)";
    global MSNAI_s1
elseif name2 == "RESP"
    b= "Resp";
end


if name1 == "MSNA"
nexttile(5,[1 2]);
plot(MSNAI_s1(:,1),MSNAI_s1(:,2))
title(name1)
xlabel('Time (s)')
ylabel(a)
yyaxis right
plot(signal1(:,1),signal1(:,2))
ylabel('Filtered signal')
grid
else
nexttile(5,[1 2]);
plot(signal1(:,1),signal1(:,2))
xlabel('Time (s)')
ylabel(a)
grid
title(name1)
end

if name2 == "MSNA"
nexttile(8,[1 2]);
plot(MSNAI_s1(:,1),MSNAI_s1(:,2))
xlabel('Time (s)')
ylabel(b)
yyaxis right
plot(signal2(:,1),signal2(:,2))
ylabel('Filtered signal')
grid
title(name2)
else
nexttile(8,[1 2]);
plot(signal2(:,1),signal2(:,2))
xlabel('Time (s)')
ylabel(b)
grid
title(name2)
end
else
    fig=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%set(gca,"FontSize",1)

%pause


% gamma= ((sum(cos(dphi)).^2)+(sum(sin(dphi)).^2))./h

% %a1=mod(angle(x1),2*pi);  
% a1=unwrap(angle(x1));
% a1=a1(ntail+1:end-ntail);
% %b1=mod(angle(y1),2*pi);
% b1=unwrap(angle(y1));
% b1=b1(ntail+1:end-ntail);
% 
% c1=abs(a1-b1);
% %c1=a1-b1;
% 
% ventana1= ones(1,round(tw))/round(tw);
% d1= sqrt((conv(sin(c1),ventana1,'valid')).^2 + (conv(cos(c1),ventana1,'valid')).^2);%para la señal completa
% % e1HF= mean((d1),'all');
% plot(d1)
% stat= phaseRandomize(signal1(1:h,2),signal2(1:h,2),d1,ntail,tw);
% if stat{1}== 0
%     synchro= nan;
% else
%     synchro= d1;
% end
% 
% 
% % figure
% % plot(0:0.2:(length(d1)-1)*0.2,e1HF)
% % ylim([0,1])
% % xlabel('Time (s)'); %pendiente 
% % title(strcat('Synchronization MSNA RR HF', s,m),'Interpreter', 'none');
% % ylabel('PhSy');
% % suptitle(strcat(sprintf('%s',stat{2}),sprintf('%s',double(round(stat{3},3)))) )
% 
% 
% % if stat{1}== 0
% %     stat=0;
% % end
% 
% if stat{1}== 0
%    stat=0;
%    dirin=nan;
%    else
%     [phi1,phi2,omeg1,omeg2,q1,q2,Qcoef1,Qcoef2,norm1,norm2,dirin] =...
%     co_fbtransf2(a1',b1',3,sf,100);
% end
% 
% else
% %LF
% [coe1,fr1] = cwt(signal1(1:h,2),sf);
% [coe2,fr2] = cwt(signal2(1:h,2),sf);
% 
% y2= mean(coe2,1);%coe2(indice2,:);
% x2=mean(coe1,1);%coe1(indice1,:);
% % a2= mod(angle(x2),2*pi);
% a2= unwrap(angle(x2));
% a2=a2(ntail+1:end-ntail);
% %b2=mod(angle(y2),2*pi);
% b2= unwrap(angle(y2));
% b2=b2(ntail+1:end-ntail);
% 
% c2=abs(a2-b2);
% 
% 
% % y2= coe2(frecuenciapredom(coe2),:);
% % x2=coe1(frecuenciapredom(coe1),:);
% % a2= unwrap(angle((x2));
% % b2=unwrap(angle(y2));
% % c2=a2-b2;
% 
% ventana1= ones(1,round(tw))/round(tw);
% d2= sqrt((conv(sin(c2),ventana1,'valid')).^2 + (conv(cos(c2),ventana1,'valid')).^2);%para la señal completa
% % e2LF= mean((d2),1);
% 
% stat= phaseRandomize(signal1(1:h,2),signal2(1:h,2),d2,ntail,tw);
% 
% if stat{1}== 0
%     synchro= nan;
% else
%     synchro=d2;
% end
% 
% 
% % figure
% % plot(0:0.2:(length(d2)-1)*0.2,e2LF)
% % ylim([0,1])
% % xlabel('Time (s)'); %pendiente 
% % title(strcat('Synchronization MSNA RR LF', s,m),'Interpreter', 'none');
% % ylabel('PhSy');
% % suptitle(strcat(sprintf('%s',stat{2}),sprintf('%s',double(round(stat{3},3)))) )
% 
% % if stat{1}== 0
% %     stat=0;
% % end
% 
% if stat{1}== 0
%    stat=0;
%    dirin=nan;
%    else
%     [phi1,phi2,omeg1,omeg2,q1,q2,Qcoef1,Qcoef2,norm1,norm2,dirin] =...
%     co_fbtransf2(a2',b2',3,sf,100);
% end
% end

return