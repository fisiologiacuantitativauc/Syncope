function [C_m ,C_sd,Th]= surro(x,xr,sf,coehr,c)
% Returns a phase-randomized version of the input data X. If X is an array,
% each row is treated as an independant time series, and columns represent
% sample points. 

rng(1)
warning('off','all')

parfor n= 1:100
%  rng('shuffle')

[N,L]=size(x');
Y=fft(x',[],2); % Get spectrum
% Add random phase shifts (negative for conjugates), preserve DC offset
rnd_theta= -pi + (2*pi).*rand(N,floor(L/2)-1); 
Y(:,2:L/2)=Y(:,2:L/2).*exp(1i*rnd_theta);
Y(:,L/2+2:L)=Y(:,L/2+2:L).*exp(-1i*flip(rnd_theta,2));
% return phase-randomized data
randX=ifft(Y,[],2);
randX=randX';

%CWT
[coe1,fr1,coi1] = cwt(randX,sf,FrequencyLimits=[0.01 0.5],VoicesPerOctave=48);%VoicesPerOctave=48
coiless1= decoi(coe1,fr1,coi1); %Evaluar si poner amor o no
[coe2,fr2,coi2] = cwt(xr,sf,FrequencyLimits=[0.01 0.5],VoicesPerOctave=48);
coiless2= decoi(coe2,fr2,coi2);

cos_phi= ((real(coiless1).*real(coiless2))+(imag(coiless1).*imag(coiless2)))./ ((sqrt((real(coiless1).^2)+(imag(coiless1)).^2) .* sqrt((real(coiless2).^2)+(imag(coiless2).^2))));
sin_phi= ((imag(coiless1).*real(coiless2))-(real(coiless1).*imag(coiless2)))./ ((sqrt((real(coiless1).^2)+(imag(coiless1)).^2) .* sqrt((real(coiless2).^2)+(imag(coiless2).^2))));
% cos_phi= ((real(coe1).*real(coe2))+(imag(coe1).*imag(coe2)))./ ((sqrt((real(coe1).^2)+(imag(coe1)).^2) .* sqrt((real(coe2).^2)+(imag(coe2).^2))));
% sin_phi= ((imag(coe1).*real(coe2))-(real(coe1).*imag(coe2)))./ ((sqrt((real(coe1).^2)+(imag(coe1)).^2) .* sqrt((real(coe2).^2)+(imag(coe2).^2))));

Av_cos= mean(cos_phi,2,"omitnan");
% Av_cos= sum(cos_phi,2,"omitnan")./length(cos_phi);
Av_sin= mean(sin_phi,2,"omitnan");
% Av_sin= sum(sin_phi,2,"omitnan")./length(sin_phi);


C= sqrt((Av_cos.^2) + (Av_sin.^2));

C_s(:,n)=C;

end

C_m  = mean(C_s,2);
C_sd = std(C_s,[],2);

Th= C_m + C_sd*2;



% pwelch(randX)
% hold on
% pwelch(x)


% % hist(SI_s,10)
% x= SI_s';
% pd = fitdist(x,'Normal');
% x_values = 0:0.001:1;
% y = pdf(pd,x_values);
% % plot(x_values,y)
% 
% PDF=[x_values',y'];
% 
% pV= trapz(PDF(x_values>=mean(SI),2))/trapz(PDF(:,2));
% 
% if pV<=0.05
%     sprintf('Significativo p')
%     pValue={1,'Significativo p',pV};
% else
%     sprintf('No significativo p')
%      pValue={0,'No significativo p',pV};
% end

return