%% one
% % find second peak Q %
% % This file is used by getqall.m to find Q for 2 peaks in one *.txt%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear qxls
clear Ys

% i = input('Please type in the file number:');

% figure(2)
% clf reset
% plot(Y(:,i))
% grid on

n = 0;
Ys = Y(:,i);
for m = 1+n:size(Ys,1)-n
    ytemp = mean(Y(m-n:m+n,i));
    Ys(m) = ytemp;
end

figure(1)
clf reset
semilogy(X(:,i),Ys,'.-k','MarkerSize',5)
grid on
hold on
axis tight
global c
global a
global b
% ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
% h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2)))
% h2 = min(find(Y(ftemp:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp-1)


ftemp = find(Ys(f1:f2) == max(Ys(f1:f2)))+f1-1; %find secone peak amplitude
fmax = X(ftemp,i); %find second peak frequency
    
h1 = find(Ys(f1:ftemp) < max(Ys(f1:f2))/sqrt(2), 1, 'last' )+f1-1;
fh1 = X(h1,i); %find left half maximum frequency
    
h2 = min(find(Ys(ftemp:f2) < max(Ys(f1:f2))/sqrt(2)))+ftemp-1;
fh2 = X(h2,i);%find right half maximum frequency

q = fmax/(fh2-fh1); %esstimate Q
% qmax = fmax/2/min([fmax-fh1,fh2-fmax]);    
% qmin = fmax/2/max([fmax-fh1,fh2-fmax]);
% qxls = [fmax, q; 0,qmax; 0, qmin];
% 

    %% lorentzian fit
    %%loading data 
    x = X(f1:f2,i);
    yOrig = Ys(f1:f2);

%% define start point
 Baseline = input('Baseline as average or minimium point? Average=1 / Min= 0 :');

    while (size(Baseline) == 0)
        disp('You must type 1 for Average or 0 for Min!');
        Baseline = input('Baseline as average or minimium point? Average=1 / Min= 0 :');
    end
    
    while (Baseline == 1 || Baseline == 0)
            if Baseline == 1
                fprintf('\n Find the range for the average \n');
                figure(2)
                plot(Y(:,i))
                grid on
                 
                f3 = input('Please type in the lower limit:');
                f4 = input('Please type in the upper limit:');
                
                while size(f3,1)==0 || size(f4,1)==0
                    f3 = input('Please type in the lower limit:');
                    f4 = input('Please type in the upper limit:');
                end                 
       
                c = mean(Ys(f3:f4));
            
            elseif  Baseline == 0
       
                c = (min(Ys));
                
            else
                disp('Error!!');
            end
            Baseline = 0.1;
    end % nolse floor
a = max(Ys(f1:f2)); % peak
Qtemp = q; % Q
b = fmax; % peak frequency
vStart2=Qtemp;
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 

%% using nlinfit
vEnd2=nlinfit(x,yOrig,@lfit2,vStart2);
yEnd2=lfit2(vEnd2,X(:,i));
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
% fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
figure(1)
plot(X(:,i),yEnd2,'-r','LineWidth',1.5);
legend('Orig','End');
axis tight
% set(gca,'Color',[0.7,0.7,0.7]);
% set(gcf,'Color',[1,1,1]);
%% display frequency and Q
% Q2 = [ffit,qtemp];
fprintf('filename: %s, Q = %g, f0 = %g\n',Ctemp(i).name, vEnd2(1), b); 

fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',c,a,vEnd2(1),b);

%     Ql = [Ql,qtemp];
%     Freq = [Freq,fmax];
