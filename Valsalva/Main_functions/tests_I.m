function [significancia_abs]= tests_I(BL, CPT)
 %
rng('default')
A=BL;
B=CPT;


v1    =[];    
v2    =[];


% for l= 1:size(A,2)
    for i=1:size(A,1)
%         for n= 1:size(A,3)
    
    v1= A(i,:);
    v2= B(i,:);

        %end
% 
%  variable=v;
%  variable= variable(any(variable,1));


% if isempty(v1) | isempty(v2) 
%     significancia_abs= [NaN NaN NaN];
% 
% else
% matrix=padcat(reshape(v1,1,[])',reshape(v2,1,[])');
%  matrix(any(isnan(matrix), 2), :) = [];
 
try
% pe= ranksum(matrix(:,1),matrix(:,2));
pe= ranksum(v1,v2);
catch
    pe=nan;
end
% figure
%[c,m,h,nms] = multcompare(stats,'CType','dunn-sidak','Display','off' );

if pe<0.05
    p=1;
else
    p=0;
end

significancia_abs(i)= p;
end
   
% end
% c(:,6)
%         significancia_abs=[significancia_abs;significancia];

        return