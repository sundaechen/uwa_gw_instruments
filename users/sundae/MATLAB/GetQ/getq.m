
Q = [];
Freq = [];
Qxls = [];
for i = 1:size(Ctemp)
%     display(i)
%     figure(1)
%     plot(X(:,i),Y(:,i))
    
    ftemp = find(Y(:,i) == max(Y(:,i))); %find peak amplitude
    fmax = X(ftemp,i); %find peak frequency
    
    h1 = max(find(Y(1:ftemp,i) < max(Y(:,i))/sqrt(2))); 
    fh1 = X(h1,i); %find left half maximum frequency
    
    h2 = min(find(Y(ftemp+1:size(Y(:,i),1),i) < max(Y(:,i))/sqrt(2))+ftemp);
    fh2 = X(h2,i);%find right half maximum frequency
    
    q = fmax/(fh2-fh1);
    qmax = fmax/2/min([fmax-fh1,fh2-fmax]);    
    qmin = fmax/2/max([fmax-fh1,fh2-fmax]);
    qxls = [fmax, q; 0,qmax; 0, qmin];
    qtemp = [q; qmax; qmin];
    
    Qxls = [Qxls,qxls];
    Q = [Q,qtemp];
    Freq = [Freq,fmax];
%     pause
%     close(1)
    
end

save Qxls.txt Qxls -ascii
save Q.txt Q -ascii
save Freq.txt Freq -ascii
