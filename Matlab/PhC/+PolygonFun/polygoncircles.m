function c = polygoncircles(x,y,r,n)
    a = linspace(0, 2*pi, n);
    g = x + sin(a)*r;
    h = y + cos(a)*r;
    c = zeros(1, 2*n);
    c(1:2:end) = g;
    c(2:2:end) = h;
end