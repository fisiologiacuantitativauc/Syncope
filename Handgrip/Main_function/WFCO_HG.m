function WFCO_HG(data)

load(data)

plotea=0;
name=[];

[choeren1,lim1,fig1,fr1]   = Synchro(RR_s,SBP_s,5,'RR','SBP',name,plotea); %HF

[choeren2,lim2,fig2,fr2]   = Synchro(RR_s,DBP_s,5,'RR','DBP',name,plotea);
[choeren3,lim3,fig3,fr3]   = Synchro(RR_s,respsignal_s,5,'RR','RESP',name,plotea);
[choeren4,lim4,fig4,fr4]   = Synchro(SBP_s,respsignal_s,5,'SBP','RESP',name,plotea);
[choeren5,lim5,fig5,fr5]   = Synchro(DBP_s,respsignal_s,5,'DBP','RESP',name,plotea); 

lim            = padcat(lim1,lim2,lim3,lim4,lim5);
frecuencia_w   = padcat(fr1,fr2,fr3,fr4,fr5);
Phase_cohe     = padcat(choeren1,choeren2,choeren3,choeren4,choeren5);

carpeta =strcat("Handgrip\WPCOR\",'C',erase(data,'pro'));

save(carpeta, 'lim','Phase_cohe',"frecuencia_w" )


end