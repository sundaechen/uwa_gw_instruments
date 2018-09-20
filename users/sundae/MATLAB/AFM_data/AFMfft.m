% function AFMfft(data,lengthperpoint)
close all
clear all

filenames = dir('GaAs*.txt');

h = figure();
hold on
set(gca,'XScale','log');
set(gca,'YScale','log');

depths_mean = zeros(size(filenames,1),1);
depths_mode = zeros(size(filenames,1),1);
Sa = zeros(size(filenames,1),1); % arithmetical mean deviation
Sq = zeros(size(filenames,1),1); % root mean squared


for i = 1:size(filenames,1)
    %% load data
    filename =filenames(i);
    A = importdata(filename.name);
    data = A.data;
    
    A.PointsPerLine = get_par(A.textdata,'PointsPerLine');
    A.LinesPerImage = get_par(A.textdata,'LinesPerImage');
    A.ScanWidth = get_par(A.textdata,'ScanWidth');
    A.ScanHeight= get_par(A.textdata,'ScanHeight');
    
    if A.PointsPerLine/A.ScanWidth~= A.LinesPerImage/A.ScanHeight
        error('The pixel size are not square!')
    end
    %% find trench edge and cut the data
    [FX,FY] = gradient(data,20);
    fx = conv(mean(FX,1), ones(21,1)/21, 'same');
    fy = conv(mean(FY,2), ones(21,1)/21, 'same');
    
    [pkx,locx,wx,px] = findpeaks(abs(fx),'MinPeakDistance',0.5*length(fx), 'SortStr','descend');
    [pky,locy,wy,py] = findpeaks(abs(fy),'MinPeakDistance',0.5*length(fy), 'SortStr','descend');
    
    for j = 1:length(locx)
        x(j) = locx(j) - ceil(wx(j))*fx(locx(j))/abs(fx(locx(j)));
    end
    x = sort(x);
    
    for j = 1:length(locy)
        y(j) = locy(j) - ceil(wy(j))*fy(locy(j))/abs(fy(locy(j)));
    end
    y = sort(y);
    
    if abs(pkx(2))<0.3*abs(pkx(1))
        x(2) = length(fx);
    end
    
    if abs(pky(2))<0.3*abs(pky(1))
        y(2) = length(fy);
    end
    
    %     figure()
    %     hold on
    %     plot(fx);
    %     plot(locx,0,'d');
    %     plot(x,0,'ro')
    %     grid on
    %
    %     figure()
    %     hold on
    %     plot(fy);
    %     plot(locy,0,'d');
    %     plot(y,0,'ro')
    %     grid on
    
    data = data(y(1):y(2),x(1):x(2));
    
    %     depth = mean(mean(data));
    %     sigma = std2(data); %standard deviation
    
    
    %% get trench depth with average
    depths_mean(i) = mean(mean(data));
    
    %% get trench depth with mode (most frequent value in a sample)
    [counts, edges, bins] = histcounts(data, 1000); %, 'BinLimits', [depth-2*sigma ,depth+2*sigma]);
    centers = edges(1:length(edges)-1)+0.5*(edges(2)-edges(1));
    m = mode(bins(:));
    depth_mode = centers(m);
    depths_mode(i) = depth_mode;
    
    %     plot(centers, counts, '.-')
    %     grid on
    
    %% relevel the data with depth_mode
    data = data - depth_mode;
    
    %% Roughness  SA and SQ
    Sa(i) = mean(abs(data(:))); % arithmetical mean deviation
    Sq(i) = sqrt(mean(data(:).^2)); % root mean squared
    
    %% apply Hann windowfunction
    N = size(data,1);
    n =[1:N]';
    Hannwindow = 0.5*(1-cos(2 *pi*n/(N-1)))/sqrt(0.375);
    Hannwindows = repmat(Hannwindow,1,size(data,2));
    dataw= (data-1*mean(mean(data))).*Hannwindows;
    %% 1D fast Fourier transform   
%         T = 20;                         % length per point
%         L = length(dataw(:,100));               % Length of Signal
%         NFFT = 2^nextpow2(L);           % Next power of 2 from length of data
%         Y = fft(dataw(:,100),NFFT,1)/L;
%     
%         f = 1/T/2*linspace(0,1,NFFT/2+1);
%         figure()
%         plot(1./f,2*abs(Y(1:NFFT/2+1)))
%         grid on
%         axis tight
%         set(gca,'XScale','log');
%         set(gca,'YScale','log');
    
    %% 1d FFT, then rms
    
    T = 1000*A.ScanWidth/A.PointsPerLine;    % length per point
    L = size(dataw,1);
    NFFT = 2^nextpow2(L);           % Next power of 2 from length of data
    Y = fft(dataw, NFFT,1)/L;
    
    f = 1/T/2*linspace(0,1,NFFT/2+1);
    %     figure()
    Yrms = sqrt(mean((2.*abs(Y(1:NFFT/2+1,:))).^2,2));
    %     h = plot(1./f, Yrms);
    h = plot(1./f, 2*f'.*Yrms);
    grid on
end
%% fix y lim for the plot and add legends
hold off
axis tight
title('GaAs 0.1us 0.79nA 0 degree')
xlabel('Bump diameter (nm)')
% ---------------------------------
ylabel('Roughness / bump radius')
xlim([20 10240])
ylim([0.0001 0.02])
legend(num2str(abs(round(depths_mode))), 'Location', 'best')
print -f1 GaAs_0.1us_0.79nA_0degree_R_over_r.jpg -djpeg -r300

% -------------------------------------------
% ylabel('Roughness (nm)')
% ylim([0.01 10])
% legend(num2str(depths),'Location', 'best')
% print -f1 GaAs_1us_0.79nA_0degree.jpg -djpeg -r300

figure()
plot(abs(depths_mode), Sa, '.-', 'MarkerSize', 15)
hold on
plot(abs(depths_mode), Sq, '.-', 'MarkerSize', 15)
title('Roughness')
xlabel('Depth (nm)')
ylabel('Roughness')
legend('Sa', 'Sq', 'Location', 'best')
grid on
print -f2 roughness.jpg -djpeg -r300

%% save roughness
% heading
% roughness_heading = ['depth_mean', 'depth_mode', 'Sa', 'Sq'];
fid = fopen('roughness.txt', 'wt');
fprintf(fid, '%s %s %s %s \n', 'depth_mean', 'depth_mode', 'Sa', 'Sq');
fclose(fid);

% save data
roughness =  [abs(depths_mean), abs(depths_mode), Sa, Sq];
save('roughness.txt', 'roughness', '-ascii', '-append')
