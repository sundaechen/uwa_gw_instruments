function [p]=lfit1coupled(v,x)
%% fixed values
global c
global b
global b1
% noise floor
% peak amp
%% Values to be fitted
H = v(1); % Q
H1 = v(2); % Q of second peak
ap = v(3); % amplitude of the second peak
A = v(4); % amplitude of the first peak
p = sqrt((A./sqrt(4.*(1-x./b).^2.*H.^2+1)).^2+c^2+(ap./sqrt(4.*(1-x./b1).^2.*H1.^2+1)).^2);
