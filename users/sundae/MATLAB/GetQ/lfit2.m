%% lfit2
function [w]=lfit2(v,x)
%% fixed values
global c
global b
global a
% noise floor
% peak amp
%% Values to be fitted
Q = v(1); % Q
 % Q of second peak
 %Q of the third peak

w = sqrt((a./sqrt(4.*(1-x./b).^2.*Q.^2+1)).^2+c^2);
