function ventanas(data)
load(data)

figure()
plot(SBP_s(:,1),SBP_s(:,2))
disp("enter")
pause


I=input('Tilt test +?, Y/N [Y]:','s');
if I== "Y"
    [t, p]=ginput;
    t     = floor(t);

if (SBP_s(end,1)-t)<300
ventanas= [(t-900),(t-600),(t-300),t,data(end,1)-t]; %En el ultimo termino se crea la ventana de sincope
else
ventanas= [(t-900),(t-600),(t-300),t,t+300];    
end 

var= ["SBP_s","DBP_s","RR_s","respsignal_s"];
for l= 1:4

    windows.(var(l)).tempranaA       = eval(strcat(var(l),"(1:find(abs(DBP_s(:,1)-ventanas(1))<0.0001),:)"));
    windows.(var(l)).tempranaB       = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(1))<0.0001):find(abs(DBP_s(:,1)-ventanas(2))<0.0001),:)"));
    windows.(var(l)).tardiaA         = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(2))<0.0001):find(abs(DBP_s(:,1)-ventanas(3))<0.0001),:)"));
    windows.(var(l)).tardiaB         = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(3))<0.0001):find(abs(DBP_s(:,1)-ventanas(4))<0.0001),:)"));
    windows.(var(l)).sincope         = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(4))<0.0001):find(abs(DBP_s(:,1)-ventanas(5))<0.0001),:)"));
end
else
    
    if RR_s(end,1)>=1800;
        t=1800;
    else
        t=RR_s(end,1);
    end
    
    ventanas= [(t-1200),(t-900),(t-600),(t-300),t];
    var= ["SBP_s","DBP_s","RR_s","respsignal_s"];
for l= 1:4

    windows.(var(l)).tempranaA       = eval(strcat(var(l),"(1:find(abs(DBP_s(:,1)-ventanas(1))<0.0001),:)"));
    windows.(var(l)).tempranaB       = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(1))<0.0001):find(abs(DBP_s(:,1)-ventanas(2))<0.0001),:)"));
    windows.(var(l)).tardiaA         = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(2))<0.0001):find(abs(DBP_s(:,1)-ventanas(3))<0.0001),:)"));
    windows.(var(l)).tardiaB         = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(3))<0.0001):find(abs(DBP_s(:,1)-ventanas(4))<0.0001),:)"));
    windows.(var(l)).sincope         = eval(strcat(var(l),"(find(abs(DBP_s(:,1)-ventanas(4))<0.0001):end,:)"));

%     windows.(var(l)).tempranaA       = eval(strcat(var(l),"(1:find(SBP_s(:,1)==ventanas(1)),:)"));
%     windows.(var(l)).tempranaB       = eval(strcat(var(l),"(find(DBP_s(:,1)==ventanas(1)):find(DBP_s(:,1)==ventanas(2)),:)"));
%     windows.(var(l)).tardiaA         = eval(strcat(var(l),"(find(DBP_s(:,1)==ventanas(2)):find(DBP_s(:,1)==ventanas(3)),:)"));
%     windows.(var(l)).tardiaB         = eval(strcat(var(l),"(find(DBP_s(:,1)==ventanas(3)):find(DBP_s(:,1)==ventanas(4)),:)"));
%     windows.(var(l)).sincope         = eval(strcat(var(l),"(find(DBP_s(:,1)==ventanas(4)):end,:)"));
end

end
etapas= ["TempranaA";"TempranaB";"TardiaA";"TardiaB";"Inicio sincope"]; %Se usa junto con "ventanas"

    
    figure ()
    plot(SBP_s(:,1),SBP_s(:,2))
    for z=1: length(ventanas)
        xline(ventanas(z),'-',etapas(z));
        xlabel('Time (s)');
        ylabel('SBP (mmHg)');
        title(data)
    end
    pause
% pendiente guardar estructuras en resultados hut70
cd resultados\hut70\
nombre= erase(data,"TT70.mat");
nombre=erase(nombre,"prepro");
save(nombre,"windows")
cd ..
cd ..


return

