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
%% the second peak and third peak
fprintf('Setting the limits to the second and third peak \n');


                fprintf('\n Fitting the second peak! \n');
                figure(2)
                plot(Y(:,i))
                grid on
 fprintf('The first peak \n');                 
                f11 = input('Please type in the lower limit:');
                f12 = input('Please type in the upper limit:');
                
 fprintf('The second peak \n');                          
                f21 = input('Please type in the lower limit:');
                f22 = input('Please type in the upper limit:');  
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
global a1
global a2
global b
global b1
global b2
%global vEnd
% ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
% h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2)))
% h2 = min(find(Y(ftemp:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp-1)

%% fit the first peak
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
%% fit the second peak
ftemp1 = find(Ys(f11:f12) == max(Ys(f11:f12)))+f11-1; %find secone peak amplitude
fmax1 = X(ftemp1,i); %find second peak frequency
    
h11 = find(Ys(f11:ftemp1) < max(Ys(f11:f12))/sqrt(2), 1, 'last' )+f11-1;
fh11 = X(h11,i); %find left half maximum frequency
    
h12 = min(find(Ys(ftemp1:f12) < max(Ys(f11:f12))/sqrt(2))+ftemp1-1);
fh12 = X(h12,i);%find right half maximum frequency

q1 = fmax1/(fh12-fh11);
%% fit the third peak
ftemp2 = find(Ys(f21:f22) == max(Ys(f21:f22)))+f21-1; %find secone peak amplitude
fmax2 = X(ftemp2,i); %find second peak frequency
    
h21 = find(Ys(f21:ftemp2) < max(Ys(f21:f22))/sqrt(2), 1, 'last' )+f21-1;
fh21 = X(h21,i); %find left half maximum frequency
    
h22 = min(find(Ys(ftemp2:f22) < max(Ys(f21:f22))/sqrt(2))+ftemp2-1);
fh22 = X(h22,i);%find right half maximum frequency

q2 = fmax2/(fh22-fh21);
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
       
                c = min(Ys);
                
            else
                disp('Error!!');
            end
            Baseline = 0.1;
    end % nolse floor
a = max(Ys(f1:f2)); % peak middle
a1 = max(Ys(f11:f12)) ; %second peak
a2 = max(Ys(f21:f22)); %Third peak
Qtemp = q; % Q
Qtemp1 = q1; %Q1
Qtemp2 = q2; %Q2

b = fmax; % peak frequency
b1 = fmax1; %2 peak max
b2 = fmax2; %3 peak max
vStart=[Qtemp,Qtemp1,Qtemp2];
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 

%% using nlinfit
vEnd=nlinfit(x,yOrig,@lfit,vStart);
yEnd=lfit(vEnd,X(:,i));
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
% fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
figure(1)
plot(X(:,i),yEnd,'-r','LineWidth',1.5);
legend('Orig','Start','End');
axis tight
% set(gca,'Color',[0.7,0.7,0.7]);
% set(gcf,'Color',[1,1,1]);
%% display frequency and Q
% Q2 = [ffit,qtemp];
fprintf('filename: %s, Q = %g, f0 = %g\n',Ctemp(i).name, vEnd(1), b); 
 
fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',c,a,vEnd(1),b,c,a1,vEnd(2),b1,c,a2,vEnd(3),b2);

fitresults = [b,vEnd(1),a; b1,vEnd(2),a1;b2,vEnd(3),a2];

%     Ql = [Ql,qtemp];
%     Freq = [Freq,fmax];


%% 3 peaks
%global d
%d = vEnd(1);
%vfit = [c,a,b];
%yfit=lfit(vfit,X(:,i));
%semilogy(X(:,i), sqrt((a./sqrt(4.*(1-x./b).^2.*d.^2+1)).^2)+c,'b','LineWidth',1.5)

%global D
%D = vEnd(2);
%vfit = [c,a1,b1];
%yfit=lfit(vfit,X(:,i));
%semilogy(X(:,i), sqrt((a1./sqrt(4.*(1-x./b1).^2.*D.^2+1)).^2)+c,'b','LineWidth',1.5)

%global g
%g = vEnd(3);
%vfit = [c,a2,b2];
%yfit=lfit(vfit,X(:,i));
%semilogy(X(:,i), sqrt((a2./sqrt(4.*(1-x./b2).^2.*g.^2+1)).^2)+c,'b','LineWidth',1.5)
