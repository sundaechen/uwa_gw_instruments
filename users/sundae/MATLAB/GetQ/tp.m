%% program for 2 peak selection
clear qxls
clear Ys
fprintf('Setting the limits to the second peak \n');


                fprintf('\n Findting the second peak! \n');
                figure(2)
                plot(Y(:,i))
                grid on
 fprintf('The second peak \n');                 
                f11 = input('Please type in the lower limit:');
                f12 = input('Please type in the upper limit:');
                
n = 0;
% input('average points(0 = No Average, 1 = 3 points):');
%  while (size(n) == 0)
%         disp('You must how many points you want to average!');
%         n = input('average points(0 = No Average, 1 = 3 points):');
%     end
    
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
global b
global b1

%global vEndx
%% fitting the first peak
ftemp = find(Ys(f1:f2) == max(Ys(f1:f2)))+f1-1; %find secone peak amplitude
fmax = X(ftemp,i); %find second peak frequency
    
h1 = find(Ys(f1:ftemp) < max(Ys(f1:f2))/sqrt(2), 1, 'last' )+f1-1;
fh1 = X(h1,i); %find left half maximum frequency
    
h2 = min(find(Ys(ftemp:f2) < max(Ys(f1:f2))/sqrt(2))+ftemp-1);
fh2 = X(h2,i);%find right half maximum frequency

q = fmax/(fh2-fh1);

%% fit the second peak
ftemp1 = find(Ys(f11:f12) == max(Ys(f11:f12)))+f11-1; %find secone peak amplitude
fmax1 = X(ftemp1,i); %find second peak frequency
    
h11 = find(Ys(f11:ftemp1) < max(Ys(f11:f12))/sqrt(2), 1, 'last' )+f11-1;
fh11 = X(h11,i); %find left half maximum frequency
    
h12 = min(find(Ys(ftemp1:f12) < max(Ys(f11:f12))/sqrt(2))+ftemp1-1);
fh12 = X(h12,i);%find right half maximum frequency

q1 = fmax1/(fh12-fh11);
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
L1 = max(Ys(f11:f12)) ; %second peak

Qtempx = q; % Q
Qtempx1 = q1; %Q1
amp = L1;
b = fmax; % peak frequency
b1 = fmax1; %2 peak max
A = a;
vStartx=[Qtempx,Qtempx1,amp,A];
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 

%% using nlinfit
vEndx=nlinfit(x,yOrig,@lfit1,vStartx);
yEndx=lfit1(vEndx,X(:,i));
% fprintf('Start:  c = %e  a = %e  Q = %f  x0 = %f\n',vStart(1),vStart(2),vStart(3),vStart(4)); 
% fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',vEnd(1),vEnd(2),vEnd(3),vEnd(4));
figure(1)
plot(X(:,i),yEndx,'-r','LineWidth',1.5);
legend('Orig','Start','End');
axis tight
% set(gca,'Color',[0.7,0.7,0.7]);
% set(gcf,'Color',[1,1,1]);
%% display frequency and Q
% Q2 = [ffit,qtemp];
fprintf('filename: %s, Q = %g, f0 = %g\n',Ctemp(i).name, vEndx(1), b); 

fprintf('End:    c = %e  a = %e  Q = %f  x0 = %f\n',c,vEndx(4),vEndx(1),b,c,vEndx(3),vEndx(2),b1);

% fitresults = [b, vEndx(1),vEndx(4); b1, vEndx(2), vEndx(3)];
%     Ql = [Ql,qtemp];
%     Freq = [Freq,fmax];


%% 2 peaks
%global u
%u = vEndx(1);
%vfit1 = [c,a,b];
%yfit1=lfit1(vfit1,X(:,i));
%semilogy(X(:,i), sqrt((a./sqrt(4.*(1-x./b).^2.*u.^2+1)).^2+c.^2),'b','LineWidth',1.5)

%global h
%h = vEndx(2);
%vfit1 = [c,a1,b1];
%yfit1=lfit1(vfit1,X(:,i));
%semilogy(X(:,i), sqrt((a1./sqrt(4.*(1-x./b1).^2.*h.^2+1)).^2+c.^2),'b','LineWidth',1.5)
