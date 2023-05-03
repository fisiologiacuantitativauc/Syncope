function [cg1,sg1]= agrupar(VM_all,num)
if num==1 %A
%Boxplot 
sg1=[];
sg1(1)= nan;%VM_all(8,3);%8 
sg1(2)= VM_all(9,2); %9
sg1(3)= VM_all(16,2);%16
sg1(4)= VM_all(19,2);%19
sg1(5)= VM_all(21,2);%21
sg1(6)= VM_all(23,1);%23
sg1(7)= VM_all(24,3);%24* sacar
%sg1(8)= nan;%VM_all(12,1);;%VM_all(24,3);%24
sg1(8)= VM_all(12,1);%VM_all(24,3);%24 solo para angulos


cg1=[];
cg1(1)= VM_all(1,2);%5-12
cg1(2)= nan;%VM_all(2,2); %sujeto con respuesta que no baja del BL
cg1(3)= VM_all(6,1);
cg1(4)= nan;%VM_all(7,1);%sujeto con respuesta que no baja del BL
cg1(5)= VM_all(10,2);%sujeto que no baja del baseline
cg1(6)= VM_all(11,1);
cg1(7)= VM_all(13,3);
cg1(8)= VM_all(14,3);
cg1(9)= nan;%%VM_all(13,1);%respuesta anomala
cg1(10)= VM_all(17,3);
cg1(11)= VM_all(20,2);
cg1(12)= VM_all(4,3);

elseif num==2 %B
%B
sg1=[];
sg1(1)= nan;%VM_all(8,3);%8 
sg1(2)= VM_all(9,2); %9 reponer
sg1(3)= VM_all(16,2);%16
sg1(4)= VM_all(19,2);%19
sg1(5)= VM_all(21,2);%21
sg1(6)= VM_all(23,1);%23
sg1(7)= VM_all(24,3);%24 reponer
sg1(8)= VM_all(12,1);%VM_all(24,3);%24


cg1=[];
cg1(1)= VM_all(1,2);%5-12
cg1(2)= VM_all(2,2); %sujeto con respuesta que no baja del BL
cg1(3)= VM_all(6,1);
cg1(4)= VM_all(7,1);
cg1(5)= VM_all(10,2);%sujeto que no baja del baseline
cg1(6)= VM_all(11,1);
cg1(7)= VM_all(13,1);%3
cg1(8)= VM_all(14,3);
cg1(9)= nan;%VM_all(13,2);
cg1(10)= VM_all(17,3);
cg1(11)= VM_all(20,2);
cg1(12)= VM_all(4,3);

elseif num==3 %C

sg1=[];
sg1(1)= nan;%VM_all(8,3);%8 
sg1(2)= VM_all(9,2); %9
sg1(3)= VM_all(16,2);%16
sg1(4)= VM_all(19,2);%19
sg1(5)= VM_all(21,2);%21
sg1(6)= VM_all(23,1);%23
sg1(7)= VM_all(24,3);%24
sg1(8)= VM_all(12,1);%VM_all(24,3);%24


cg1=[];
cg1(1)= VM_all(1,2);%5-12
cg1(2)= nan;%VM_all(2,2); %sujeto con respuesta que no baja del BL
cg1(3)= VM_all(6,1);
cg1(4)= VM_all(7,1);
cg1(5)= VM_all(10,2);%sujeto que no baja del baseline
cg1(6)= VM_all(11,1);
cg1(7)= VM_all(13,3);
cg1(8)= VM_all(14,3);
cg1(9)= nan;%VM_all(13,1);
cg1(10)= VM_all(17,3);
cg1(11)= VM_all(20,2);
cg1(12)= VM_all(4,3);

elseif num==4 %D

%Boxplot 
sg1=[];
sg1(1)= nan;%VM_all(8,3);%8 
sg1(2)= VM_all(9,2); %9
sg1(3)= VM_all(16,2);%16
sg1(4)= VM_all(19,2);%19
sg1(5)= VM_all(21,2);%21
sg1(6)= VM_all(23,1);%23
sg1(7)= VM_all(24,3);%24
%sg1(8)= nan;%VM_all(12,1);;%VM_all(24,3);%24
sg1(8)= VM_all(12,1);%VM_all(24,3);%24 solo para angulos


cg1=[];
cg1(1)= VM_all(1,2);%5-12
cg1(2)= nan;%VM_all(2,2); %sujeto con respuesta que no baja del BL
cg1(3)= VM_all(6,1);
cg1(4)= nan;%VM_all(7,1);%sujeto con respuesta que no baja del BL
cg1(5)= VM_all(10,2);%sujeto que no baja del baseline
cg1(6)= VM_all(11,1);
cg1(7)= VM_all(13,3);
cg1(8)= VM_all(14,3);
cg1(9)= nan;%%VM_all(13,1);%respuesta anomala
cg1(10)= VM_all(17,3);
cg1(11)= VM_all(20,2);
cg1(12)= VM_all(4,3);

elseif num==5 %E
%B
%Boxplot 
sg1=[];
sg1(1)= nan;%VM_all(8,3);%8 
sg1(2)= VM_all(9,2); %9
sg1(3)= VM_all(16,2);%16
sg1(4)= VM_all(19,2);%19
sg1(5)= VM_all(21,2);%21
sg1(6)= VM_all(23,1);%23
sg1(7)= VM_all(24,3);%24
%sg1(8)= nan;%VM_all(12,1);;%VM_all(24,3);%24
sg1(8)= VM_all(12,1);%VM_all(24,3);%24 solo para angulos


cg1=[];
cg1(1)= VM_all(1,2);%5-12
cg1(2)= nan;%VM_all(2,2); %sujeto con respuesta que no baja del BL
cg1(3)= VM_all(6,1);
cg1(4)= nan;%VM_all(7,1);%sujeto con respuesta que no baja del BL
cg1(5)= VM_all(10,2);%sujeto que no baja del baseline
cg1(6)= VM_all(11,1);
cg1(7)= VM_all(13,3);
cg1(8)= VM_all(14,3);
cg1(9)= nan;%%VM_all(13,1);%respuesta anomala
cg1(10)= VM_all(17,3);
cg1(11)= VM_all(20,2);
cg1(12)= VM_all(4,3);

end


end
