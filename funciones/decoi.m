function coiless= decoi(wt,f,coi)

% [wt,f,coi]= cwt(s,10);

M=repelem(f,1, length(coi));

A= M-coi';

ind= ~(A < -0.0001);

s_coi=wt.*ind;
s_coi(find(s_coi==0)) = NaN;
coiless=s_coi;

end

