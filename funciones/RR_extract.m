function RR= RR_extrac(ECG,tiempo) 

dt=mean(diff(tiempo));
smoothECG = medfilt1(ECG,round(.2/dt)); 

    %Plot 200 ms filter on top of ECG
  
%     plot(tiempo,smoothECG)

%Filter out T waves with a window of 600 ms 
smoothECG2 = medfilt1(smoothECG,round(.6/dt)); 

    %Plot 600 ms filter on top of ECG
 
%     plot(tiempo,smoothECG2,'c','linewidth',2)    

    BaselineCorrectedECG = ECG - smoothECG2; 

    %Plot baseline-correctd ECG 
%     plot(tiempo,BaselineCorrectedECG,'k','linewidth',1)

SVGwindow = round(.15/dt); 
if mod(SVGwindow,2) == 0
    SVGwindow = SVGwindow + 1;
end 
%Check to ensure order is less than window size 
if SVGwindow > 5
    SVGorder = 5; 
else
    SVGorder = 3; 
end 
smoothECG3 = sgolayfilt(double(BaselineCorrectedECG),SVGorder,SVGwindow); 

    %Plot SVG filter on top of baseline-corrected ECG 
   
%     plot(tiempo,smoothECG3,'r','linewidth',2)

% Accentuate peaks to easily find them 

%Can now extract Q and R peaks 
accentuatedpeaks = BaselineCorrectedECG - smoothECG3; 

    %Plot of baseline-corrected ECG with accentuated peaks 
 
%     clf
%     plot(tiempo,accentuatedpeaks,'k','linewidth',1)
%     xlabel('Time (sec)')
%     ylabel('Filtered ECG (mV)')
%     set(gca,'FontSize',16)

% [~,z] = findpeaks(accentuatedpeaks,'MinPeakDistance',round(.2/dt)); 
% zz = mean(accentuatedpeaks(z)); 
% [peaks,iR] = findpeaks(accentuatedpeaks,'MinPeakHeight',zz,'MinPeakDistance',round(.2/dt)); 
% V=[iR,peaks];



%%
wt = modwt(accentuatedpeaks,5);
wtrec = zeros(size(wt));
wtrec(4:5,:) = wt(4:5,:);
y = imodwt(wtrec,'sym4');
y = abs(y).^2;

% findpeaks(y,tiempo,'MinPeakHeight',0.0005,'MinPeakDistance',0.3)
% pause
[qrspeaks,locs] = findpeaks(y,tiempo,'MinPeakHeight',0.0005,'MinPeakDistance',0.3);

plot(tiempo,ECG)
hold on
plot(locs,qrspeaks,'o')
pause
% plot(locs(1:(length(locs)),1),qrspeaks,'o')

I=input('Do you want to fix any points?, Y/N [Y]:','s');
if I== "Y" | I== "y"
%      M=[locs,qrspeaks'];
    while I == 'Y'| I == 'y'
      disp('Zoom in the segment that you want to fix and press enter')
      pause
      [x,y] = ginput;
%       blood= [t,bp];
if length(x)>1
      idx = find(locs>=(x(1)-0.3) & locs<=(x(1)+0.3),1);
      locs(idx)= x(2);
else
      idx = find(locs>=(x(1)-0.3) & locs<=(x(1)+0.3),1);
      locs(idx)= [];
      qrspeaks(idx)=[];
end

      plot(locs,qrspeaks,'o');

      I=input('Do you want to fix any other points?, Y/N [Y]:','s');
    end
else
end



    
RR= [locs(1:(length(locs)-1),1) ,diff(locs)]; 





close all
    



end
