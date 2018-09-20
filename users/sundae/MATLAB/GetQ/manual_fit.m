% H = v(1); % Q
% H1 = v(2); % Q of second peak
% ap = v(3); % amplitude of the second peak
% A = v(4); % amplitude of the first peak

b = b; % peak frequency of the first peak
b1 = b1; % peak frequency of the second peak
c = c;

qf1 = vEndx(1);
qf2 = 5e5; %vEndx(2);
af2 = 4e-6; %vEndx(3); 
af1 = vEndx(4);

vFit = [qf1, qf2, af2, af1]; 

yFit=lfit1(vFit,X(:,i));
figure(1)
plot(X(:,i),yFit,'-r','LineWidth',1.5);

figure(2)
hold on
plot(yFit,'.r','LineWidth',1.5);