N = 12;

fR = @(x) 1./(1.+25.*x.^2);
f1 = @(x) (1.+cos(3/2.*pi.*x)).^(2/3);
T  = @(k) cos((2.*k.+1)./(2*N).*pi);


x = [-1:2/N:1];
xTsch = T([1:1:N]);

y = fR(x);
[P] = polyfit(x,y,N+1);

xPlot = [-1:2/(10*N):1];

yPlot = fR(xPlot);
polyPlot = polyval(P,xPlot);

plot(xPlot,polyPlot,xPlot,yPlot)



