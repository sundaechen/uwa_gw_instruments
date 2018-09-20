


global c
global a
global b

% for i = 55:55 % size(trans,1)
%     Ys = sqrt(trans(i,:)'-min(trans(i,:)));
    Y = 10.^(data(:,2)./20);
    X = data(:,1);
%   X = [1:size(trans,2)];

    figure(1)
    clf reset
    plot(Y,'.-k','MarkerSize',5)
    grid on
    hold on
    axis tight
    
%% average data
navg = 10;
for nd = (navg+1):(size(Y,1)-navg-1)
    Ytemp(nd) = mean(Y(nd-navg:nd+navg));
end
plot(Ytemp,'r','LineWidth',1.5)

%% defind noise floor
 Baseline = 1; % input('Baseline as average or minimium point? Average=1 / Min= 0 :');

    while (size(Baseline) == 0)
        disp('You must type 1 for Average or 0 for Min!');
        Baseline = input('Baseline as average or minimium point? Average=1 / Min= 0 :');
    end
    
    while (Baseline == 1 || Baseline == 0)
            if Baseline == 1
                fprintf('\n Find the range for the average \n');
%                 figure(2)
%                 plot(Ys(:))
%                 grid on
                 
                f3 = input('Please type in the lower limit:');
                f4 = input('Please type in the upper limit:');
                
                while size(f3,1)==0 || size(f4,1)==0
                    f3 = input('Please type in the lower limit:');
                    f4 = input('Please type in the upper limit:');
                end                 
       
                c = mean(Ytemp(f3:f4));
            
            elseif  Baseline == 0
       
                c = (min(Ytemp));
                
            else
                disp('Error!!');
            end
            Baseline = 0.1;
    end % nolse floor
%% cut data to fit and find initial fitting parametre 

Ys = Ytemp-mean(Ytemp);

f1 = input('Please set the start point to fit: ');
f2 = input('Please set the end point to fit: ');
    
ftemp = find(Ys(f1:f2) == max(Ys(f1:f2)),1)+f1-1; %find secone peak amplitude
fmax = X(ftemp); %find second peak frequency
    
h1 = find(Ys(f1:ftemp) < max(Ys(f1:f2))/sqrt(2), 1, 'last' )+f1-1;
fh1 = X(h1); %find left half maximum frequency
    
h2 = min(find(Ys(ftemp:f2) < max(Ys(f1:f2))/sqrt(2)))+ftemp-1;
fh2 = X(h2);%find right half maximum frequency

q = fmax/(fh2-fh1); %esstimate Q

    %% lorentzian fit
    %%loading data 
    x = X(f1:f2);
    yOrig = Ys(f1:f2);

%% define start point
   
a = max(Ys(f1:f2)); % peak
Qtemp = q; % Q
b = fmax; % peak frequency
vStart2=Qtemp;
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 

%% using nlinfit
vEnd2=nlinfit(x,yOrig,@lfit2,vStart2);
yEnd2=lfit2(vEnd2,x);
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
% fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
figure(1)
clf reset

plot(X(ftemp-200:ftemp+200),Ys(ftemp-200:ftemp+200),'.-k','MarkerSize',12)
grid on
hold on
% axis tight
axis([X(ftemp-200) X(ftemp+200) 0.9*min(Ys(ftemp-200:ftemp+200)) 1.1*max(Ys(ftemp-300:ftemp+300))])
plot(x,yEnd2,'-r','LineWidth',1.5);
legend('Orig','End');
% set(gca,'Color',[0.7,0.7,0.7]);
% set(gcf,'Color',[1,1,1]);
%% display frequency and Q
% Q2 = [ffit,qtemp];
% fprintf('filename: %s, Q = %g, f0 = %g\n',Ctemp(i).name, vEnd2(1), b); 

fprintf('End:    c = %e  a = %e  Q = %e  x0 = %f\n',c,a,vEnd2(1),b);
result = [i,c,a,vEnd2(1),b];
results = [results; result];

%% display frequency and bandwidth
% % Q2 = [ffit,qtemp];
% gamma = b/vEnd2(1);
% % fprintf('filename: %s, Q = %g, f0 = %g\n',Ctemp(i).name, vEnd2(1), b); 
% 
% fprintf('End:    c = %e  a = %e  gamma = %e  x0 = %f\n',c,a,gamma,b);
% result = [i,c,a,gamma,b];
% results = [results; result];
% 
% %     Ql = [Ql,qtemp];
% %     Freq = [Freq,fmax];
% % pause
% 
% % end
