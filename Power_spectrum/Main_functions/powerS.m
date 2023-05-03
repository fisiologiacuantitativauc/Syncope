function [LFn,HFn]=powerS(data,test)
if test=="BL" 
    n=1200;
elseif test== "DB"
    n= 360;
elseif test=="HG"
    n= 360;
elseif test=="HUT"
    n= 300;
end
if ischar(data)
    load(data)
else
    rr=data;
end
try
rr(:,1)=rr(:,1)-rr(1,1);


% Interpolacion 
RR_s=[(0:0.5:rr(end,1))',pchip(rr(:,1),rr(:,2),0:0.5:rr(end,1))']; %ZOH
if length(RR_s)> n
    RR_s(n+1:end,:)=[];
end




RR_s(:,2)=RR_s(:,2)-mean(RR_s(:,2));
x= RR_s(:,2);

%Frecuencias medias 
sf=2;
%resolutonReqd = 0.01; fs / resolutonReqd;

Nx= length(x);
window= floor(Nx/4.5);
overlap = floor(window/2);
NFFT =max(256,2^nextpow2(window));
%[pxx,f] = pwelch(x,window,overlap,NFFT);
% xlim([0 0.4])

[pxx,f] = periodogram(x,[],NFFT,sf);
%psdest = psd(spectrum.periodogram,RR_s(:,2),'Fs',2,'NFFT',length(RR_s(:,2)));

mask1= [ (f<0.40) .*  (f>=0.15)]; %HF
mask2= [ (f<0.15) .*  (f>=0.04)];
mask3= [ (f<0.04) .*  (f>=0.01)];

HF = trapz(f, pxx.*mask1);
LF = trapz(f, pxx.*mask2);
VLF= trapz(f, pxx.*mask3);


HFn= HF/(HF+LF+VLF)*100;
LFn= LF/(HF+LF+VLF)*100;

R=[HFn,LFn];
catch
    HFn= nan;
    LFn= nan;
    
end
  


end

