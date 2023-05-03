function [Tm,Ti]=parametrosV(m)

load Ind_val.mat
subj=dir("Valsalva\Lab_data");
subj= {subj.name};
subj= subj(3:end);
Tm=[];
Ti=[];
if m==1

%% Parametro de amplitud
%VM1
VM1_ind= contains(subj,'VM1');
namesVM1= subj(VM1_ind);
VM1= iA(VM1_ind,:);

%VM2
VM2_ind= contains(subj,'VM2');
namesVM2= subj(VM2_ind);
VM2= iA(VM2_ind,:);

%VM3
VM3_ind= contains(subj,'VM3');
namesVM3= subj(VM3_ind);
VM3= iA(VM3_ind,:);
titulos=["A","B","C","D","E"];

for marker=1:5

VM_all= nan(25,3);
for j=1:25
ind1= find(contains(namesVM1,strcat('W',string(j),'VM')),1);
if ~isempty(ind1)
VM_all(j,1)= VM1(ind1,marker);
end

ind2= find(contains(namesVM2,strcat('W',string(j),'VM')),1);
if ~isempty(ind2)
VM_all(j,2)= VM2(ind2,marker);
end

ind3= find(contains(namesVM3,strcat('W',string(j),'VM')),1);
if ~isempty(ind3)
VM_all(j,3)= VM3(ind3,marker);
end

end 

%Boxplot 
[cg1,sg1]=agrupar(VM_all,marker);



ve=[cg1';sg1'];

g1 = repmat({'Control'},length(cg1),1);
g2 = repmat({'Syncope'},length(sg1),1);
g = [g1; g2];

f1=figure('Renderer', 'painters', 'Position', [10 10 300 250]);
boxplot(ve,g)
title(titulos(marker))
set(gca,"FontSize",20)

p=ranksum(cg1,sg1);
if p<0.05
sigstar({[1,2]},p);
else 
end

    title(titulos(marker));
    ylabel('$\Delta$ SBP',"Interpreter","latex")
%     set(gca,'FontSize',15)
    fig=strcat('Valsalva\Figuras/V',titulos(marker),'.png');
    exportgraphics(f1,fig,'Resolution',600)

 meanc= median(cg1,"omitnan");
 means= median(sg1,"omitnan");
 iqc  = iqr(cg1);
 iqs  = iqr(sg1);

 Tm=[Tm;[meanc,means,p]];
 Ti=[Ti;[iqc,iqs]];

end


%% Parametro de tiempo
elseif m==2 
% 
%VM1
VM1_ind= contains(subj,'VM1');
namesVM1= subj(VM1_ind);
VM1= iT(VM1_ind,:);

%VM2
VM2_ind= contains(subj,'VM2');
namesVM2= subj(VM2_ind);
VM2= iT(VM2_ind,:);

%VM3
VM3_ind= contains(subj,'VM3');
namesVM3= subj(VM3_ind);
VM3= iT(VM3_ind,:);
titulos=["t1","t2","t3","PRT"];

for marker=1:4

VM_all= nan(25,3);
for j=1:25
ind1= find(contains(namesVM1,strcat('W',string(j),'VM')),1);
if ~isempty(ind1)
VM_all(j,1)= VM1(ind1,marker);
end

ind2= find(contains(namesVM2,strcat('W',string(j),'VM')),1);
if ~isempty(ind2)
VM_all(j,2)= VM2(ind2,marker);
end

ind3= find(contains(namesVM3,strcat('W',string(j),'VM')),1);
if ~isempty(ind3)
VM_all(j,3)= VM3(ind3,marker);
end

end 

%Boxplot 
[cg1,sg1]=agrupar(VM_all,marker);


ve=[cg1';sg1'];

g1 = repmat({'Control'},length(cg1),1);
g2 = repmat({'Syncope'},length(sg1),1);
g = [g1; g2];

f1=figure('Renderer', 'painters', 'Position', [10 10 300 250]);
boxplot(ve,g)
title(titulos(marker))
set(gca,"FontSize",20)

p=ranksum(cg1,sg1);
if p<0.05
sigstar({[1,2]},p);
else 
end

    title(titulos(marker));
    ylabel('$\Delta$ t',"Interpreter","latex")
%     set(gca,'FontSize',12)
    fig=strcat('Valsalva\Figuras/V',titulos(marker),'.png');
    exportgraphics(f1,fig,'Resolution',600)

 meanc= median(cg1,"omitnan");
 means= median(sg1,"omitnan");
 iqc  = iqr(cg1);
 iqs  = iqr(sg1);

 Tm=[Tm;[meanc,means,p]];
 Ti=[Ti;[iqc,iqs]];

end

%% Parametro de angulo 
elseif m==3
    
% 
%VM1
VM1_ind= contains(subj,'VM1');
namesVM1= subj(VM1_ind);
VM1= iG(VM1_ind,:);

%VM2
VM2_ind= contains(subj,'VM2');
namesVM2= subj(VM2_ind);
VM2= iG(VM2_ind,:);

%VM3
VM3_ind= contains(subj,'VM3');
namesVM3= subj(VM3_ind);
VM3= iG(VM3_ind,:);
titulos=["Alpha","Beta"];

for marker=1:2

VM_all= nan(25,3);
for j=1:25
ind1= find(contains(namesVM1,strcat('W',string(j),'VM')),1);
if ~isempty(ind1)
VM_all(j,1)= VM1(ind1,marker);
end

ind2= find(contains(namesVM2,strcat('W',string(j),'VM')),1);
if ~isempty(ind2)
VM_all(j,2)= VM2(ind2,marker);
end

ind3= find(contains(namesVM3,strcat('W',string(j),'VM')),1);
if ~isempty(ind3)
VM_all(j,3)= VM3(ind3,marker);
end

end 

%Boxplot 
[cg1,sg1]=agrupar(VM_all,marker);
if ~isempty(find(sg1==0))
sg1([find(sg1==0)])=nan;
end
if ~isempty(find(cg1==0))
cg1([find(cg1==0)])=nan;
end


ve=[cg1';sg1'];

g1 = repmat({'Control'},length(cg1),1);
g2 = repmat({'Syncope'},length(sg1),1);
g = [g1; g2];

f1=figure('Renderer', 'painters', 'Position', [10 10 300 250]);
boxplot(ve,g)
title(titulos(marker))
set(gca,"FontSize",20)


p=ranksum(cg1,sg1);
if p<0.05
sigstar({[1,2]},p);
else
end

    title(titulos(marker));
    ylabel('BRS')
%     set(gca,'FontSize',12)
    fig=strcat('Valsalva\Figuras/V',titulos(marker),'.png');
    exportgraphics(f1,fig,'Resolution',600)

 meanc= median(cg1,"omitnan");
 means= median(sg1,"omitnan");
 iqc  = iqr(cg1);
 iqs  = iqr(sg1);

 Tm=[Tm;[meanc,means,p]];
 Ti=[Ti;[iqc,iqs]];

end
end
