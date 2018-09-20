function z = HG(n,m,w,x,y)
N=n+m;
z=2^(-N/2)*sqrt(2/pi/factorial(m)/factorial(n))/w.*mfun('H',m,sqrt(2)*x/w).*mfun('H',n,sqrt(2)*y/w).*exp(-(x.^2+y.^2)./w.^2);
