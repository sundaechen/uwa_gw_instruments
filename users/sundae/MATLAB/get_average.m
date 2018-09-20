
x = data(:,1);
ytemp = data(:,2);
figure(1)
clf reset
plot(x,ytemp,'.-')
hold on
grid on
axis tight

y = ytemp;
navg = 10;
for n = (navg+1):(size(ytemp,1)-navg-1)
    y(n) = mean(ytemp(n-navg:n+navg));
end
plot(x,y,'r','LineWidth',1.5)
