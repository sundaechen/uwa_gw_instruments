
Ql = [];
% Freq = [];
Qlxls = [];
for i = 85:103 %1:size(Ctemp)
    clf reset
    fprintf('   %g\n',i); 
    figure(1);
    plot(X(:,i),Y(:,i),'-ob','MarkerSize',5)
    grid on
    hold on
    pause
    
    ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
    fmax = X(ftemp,i); %find peak frequency
    
    h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2))); 
    fh1 = X(h1,i); %find left half maximum frequency
    
    h2 = min(find(Y(ftemp+1:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp);
    fh2 = X(h2,i);%find right half maximum frequency
    
    q = fmax/(fh2-fh1); %estimate Q
%     qmax = fmax/2/min([fmax-fh1,fh2-fmax]);    
%     qmin = fmax/2/max([fmax-fh1,fh2-fmax]);
%     qxls = [fmax, q; 0,qmax; 0, qmin];
%     qtemp = [q; qmax; qmin];
    
    %% lorentzian fit
    %%loading data 
    x = X(:,i);
    yOrig = Y(:,i);

%% define start point
c = min(Y(:,i)); % nolse floor
a = max(Y(:,i)); % peak
Q = q; % Q
b = fmax; % peak frequency
vStart=[c,a,Q,b];
fprintf('Start:  noise floor = %e  A = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
yStart=lfit(vStart,x);
plot(x,yStart,'-k','LineWidth',1);

pause

%% using nlinfit
vEnd=nlinfit(x,yOrig,@lfit,vStart);
yEnd=lfit(vEnd,x);
fprintf('End:  noise floor = %e  A = %e  Q = %f  x0 = %f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
plot(x,yEnd,'-r','LineWidth',2);
legend('Orig','Start','End');
% set(gca,'Color',[0.7,0.7,0.7]);
% set(gcf,'Color',[1,1,1]);
%% save frequency and Q
qtemp = vEnd(3);
ffit = vEnd(4);
% vFit = [vEnd(1),vStart(2),vStart(3),vStart(4)]
% yFit = lfit(vFit,x);
% plot(x,yFit,'-y','LineWidth',2)

Qlxls = [Qlxls,ffit,qtemp];
%     Ql = [Ql,qtemp];
%     Freq = [Freq,fmax];
%% ending
    pause
      
end

% save Qlxls.txt Qlxls -ascii
% save Ql.txt Ql -ascii
% save Freq.txt Freq -ascii
