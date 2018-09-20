Ftemp = dir('*.txt');
% for i =  46:1:55
i = 3;   
filename = Ftemp(i).name;
% filename = 'Trace2-2018-09-07-15-48-24.txt';

delimiterIn = '\t';
headerlinesIn = 1;
A = importdata(filename, delimiterIn, headerlinesIn);
data = A.data;
 
x = data(:,1);
y = data(:,2);

average = 1;
if average == 1
    x = mean(reshape(x(1:1600),[8 200]),1);
    y = mean(reshape(y(1:1600),[8 200]),1);
end

figure(2)
hold on
plot(x, y, '-')
grid on
set(gca,'XScale','log');
set(gca,'YScale','log');
title(filename)
xlabel('Frequency (Hz)')
ylabel('Magnitude (a.u.)')
axis('tight') 
% end