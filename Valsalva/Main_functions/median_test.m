function [significancia_abs]= median_test(control,sincope)

A=control;
B=sincope;


% 
%  variable=v;
%  variable= variable(any(variable,1));


if isempty(A) | isempty(B) 
    significancia_abs= [1];

else
 matrix=padcat(reshape(A,1,[])',reshape(B,1,[])');
%  matrix(any(isnan(matrix), 2), :) = [];
 

p=ranksum(matrix(:,1),matrix(:,2));
% figure


% if pe<0.05
%     p=1;
% else
%     p=0;
% end

significancia_abs= p;


end

% c(:,6)
%         significancia_abs=[significancia_abs;significancia];

        return