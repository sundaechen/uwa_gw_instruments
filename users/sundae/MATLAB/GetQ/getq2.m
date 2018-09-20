% % Q for get 2nd peak by f0/bandwidth  
for i = 51:84 %1<= i <= size(Ctemp)

display(i)
figure(1)
plot(X(:,i),Y(:,i))

ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
fmax = X(ftemp,i); %find peak frequency
    
h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2))); 
fh1 = X(h1,i); %find left half maximum frequency
    
h2 = min(find(Y(ftemp:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp-1);
fh2 = X(h2,i);%find right half maximum frequency
    
q = fmax/(fh2-fh1);
qmax = fmax/2/min([fmax-fh1,fh2-fmax]);    
qmin = fmax/2/max([fmax-fh1,fh2-fmax]);
qxls = [fmax, q; 0,qmax; 0, qmin];
    
    pause
    close(1)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find second peak Q%

clear qxls
clear Ys

i = 67;
figure(1)
plot(Y(:,i))
grid on

n = 1;
Ys = [];
for m = 1+n:801-n
    ytemp = mean(Y(m-n:m+n,i));
    Ys = [Ys;ytemp];
end

figure(2)
plot(Ys,'k')
grid on

% ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
% h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2)))
% h2 = min(find(Y(ftemp:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp-1)

f1 = 350;
f2 = 430;

ftemp = find(Ys(f1:f2) == max(Ys(f1:f2)))+f1-1 %find secone peak amplitude
fmax = X(ftemp,i); %find second peak frequency
    
h1 = find(Ys(f1:ftemp) < max(Ys(f1:f2))/sqrt(2), 1, 'last' )+f1-1
fh1 = X(h1,i); %find left half maximum frequency
    
h2 = min(find(Ys(ftemp:f2) < max(Ys(f1:f2))/sqrt(2))+ftemp-1)
fh2 = X(h2,i);%find right half maximum frequency

q = fmax/(fh2-fh1);
qmax = fmax/2/min([fmax-fh1,fh2-fmax]);    
qmin = fmax/2/max([fmax-fh1,fh2-fmax]);
qxls = [fmax, q; 0,qmax; 0, qmin];
