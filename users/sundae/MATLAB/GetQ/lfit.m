% % Lorzentain fit fomula
function [y]=lfit(v,x)
%% fixed values
global c
global b
global b1
global b2
global a
global a1
global a2
% noise floor
% peak amp
%% Values to be fitted
Q = v(1); % Q
Q1 = v(2); % Q of second peak
Q2 = v(3); %Q of the third peak

y = sqrt((a./sqrt(4.*(1-x./b).^2.*Q.^2+1)).^2+(a1./sqrt(4.*(1-x./b1).^2.*Q1.^2+1)).^2+(a2./sqrt(4.*(1-x./b2).^2.*Q2.^2+1)).^2+c^2);

