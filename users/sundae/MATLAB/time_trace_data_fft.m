clear all
close all

n1 = [];
n2 = [];

%import data
filename = 'MokuOscilloscopeData_20180904_201016_HighRes.csv';
A = importdata(filename, ',', 8);
data = A.data;

% select ringdown start and stop point
figure(1)
plot(data(:,2))
grid on

while isempty(n1)
    n1 = input('Please select start point: ');
end
while isempty(n2)
    n2 = input('Please select stop point: ');
end
time = data(n1:n2,1);
amp = data(n1:n2,2);

figure(1)
plot(time, amp, '.-')
grid on
pause
close(1)

%% fft converte to frequency domain
b = fft(amp);

L = length(time);
T = time(L)-time(1);
Fs = L/T;
freq = Fs*(0:(L/2))/L;
p = abs(b(1:L/2+1)/L);

figure()
plot(freq, p, '.-')
% set(gca,'XScale','log');
set(gca,'YScale','log');
% set(gca,'YScale','linear');
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (a.u.)')
axis('tight')
% resonant frequency
f_resonant = freq(p==max(p));

%% fit ring-down
MinPeakDistance = round(Fs/f_resonant/2.5);
[pks,locs] = findpeaks(abs(amp),'MinPeakDistance',MinPeakDistance);
% plot(time(locs), pks, 'o-b')

[xData, yData] = prepareCurveData( time(locs), pks );
% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts);

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
set(gca,'YScale','log');
legend( h, 'amp vs. time', 'ringdown fit', 'Location', 'NorthEast' );
% Label axes
xlabel( 'time (s)')
ylabel( 'amp (a.u.)')
grid on

tao = -1/fitresult.b;
Q = pi*f_resonant*tao;

X = sprintf('freq: %0.3f  Q: %0.2f \n', f_resonant, Q);
disp(filename)
disp(X)





