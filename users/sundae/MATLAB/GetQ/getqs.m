   
% for i = 51:84 %1<= i <= size(Ctemp)
% 
% display(i)
% figure(1)
% plot(X(:,i),Y(:,i))
% 
% ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
% fmax = X(ftemp,i); %find peak frequency
%     
% h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2))); 
% fh1 = X(h1,i); %find left half maximum frequency
%     
% h2 = min(find(Y(ftemp:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp-1);
% fh2 = X(h2,i);%find right half maximum frequency
%     
% q = fmax/(fh2-fh1); %estimate Q
% 
%     %% lorentzian fit
%     %%loading data 
%     x = X(:,i);
%     yOrig = Y(:,i);
% 
% %% define start point
% c = min(Y(:,i)); % nolse floor
% a = max(Y(:,i)); % peak
% Q = q; % Q
% b = fmax; % peak frequency
% vStart=[c,a,Q,b];
% fprintf('Start:  c = %e  a = %e  Q = %f  b = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
% yStart=lfit(vStart,x);
% % plot(x,yStart,'-k','LineWidth',2);
% 
% %% using nlinfit
% vEnd=nlinfit(x,yOrig,@lfit,vStart);
% yEnd=lfit(vEnd,x);
% fprintf('End:  c=%f  a=%f  Q=%f  x0=%f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
% % plot(x,yEnd,'-r','LineWidth',2);
% % legend('Orig','Start','End');
% % set(gca,'Color',[0.7,0.7,0.7]);
% % set(gcf,'Color',[1,1,1]);
% %% save frequency and Q
% qtemp = vEnd(3);
% ffit = vEnd(4);
% 
%     Qlxls = [ffit,qtemp];
% %     Ql = [Ql,qtemp];
% %     Freq = [Freq,fmax];
%     
%     pause
%     close(1)
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find second peak Q%

clear qxls
clear Ys
clf reset

i = input('Please type in the file number:');

figure(1)
plot(Y(:,i))
grid on

n = 0;
Ys = [];
for m = 1+n:801-n
    ytemp = mean(Y(m-n:m+n,i));
    Ys = [Ys;ytemp];
end

figure(2)
plot(X(:,i),Ys,'-ok','MarkerSize',5)
grid on
hold on

% ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
% h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2)))
% h2 = min(find(Y(ftemp:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp-1)

f1 = input('Please type in the lower limit:');
f2 = input('Please type in the upper limit:');

ftemp = find(Ys(f1:f2) == max(Ys(f1:f2)))+f1-1; %find secone peak amplitude
fmax = X(ftemp,i); %find second peak frequency
    
h1 = find(Ys(f1:ftemp) < max(Ys(f1:f2))/sqrt(2), 1, 'last' )+f1-1;
fh1 = X(h1,i); %find left half maximum frequency
    
h2 = min(find(Ys(ftemp:f2) < max(Ys(f1:f2))/sqrt(2))+ftemp-1);
fh2 = X(h2,i);%find right half maximum frequency

q = fmax/(fh2-fh1); %esstimate Q
% qmax = fmax/2/min([fmax-fh1,fh2-fmax]);    
% qmin = fmax/2/max([fmax-fh1,fh2-fmax]);
% qxls = [fmax, q; 0,qmax; 0, qmin];
% 

    %% lorentzian fit
    %%loading data 
    x = X(:,i);
    yOrig = Ys;

%% define start point
c = min(Ys(f1:f2)); % nolse floor
a = max(Ys(f1:f2)); % peak
Q = q; % Q
b = fmax; % peak frequency
vStart=[c,a,Q,b];
fprintf('Start:  c = %e  a = %e  Q = %f  b = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
yStart=lfit(vStart,x);
% plot(x,yStart,'-b','LineWidth',2);

%% using nlinfit
vEnd=nlinfit(x,yOrig,@lfit,vStart);
yEnd=lfit(vEnd,x);
fprintf('End:  c=%f  a=%f  Q=%f  x0=%f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
plot(x,yEnd,'-r','LineWidth',2);
% legend('Orig','Start','End');
% set(gca,'Color',[0.7,0.7,0.7]);
% set(gcf,'Color',[1,1,1]);
%% save frequency and Q
qtemp = vEnd(3);
ffit = vEnd(4);
Q2 = [ffit,qtemp];
fprintf('filename: %g, Q = %g, f0 = %g\n',i,qtemp,ffit); 

%     Ql = [Ql,qtemp];
%     Freq = [Freq,fmax];

%% vfit
% vfit = [vEnd(1),vStart(2),vStart(3),vStart(4)];
% yfit=lfit(vfit,x);
% plot(x,yfit,'-g','LineWidth',2);

