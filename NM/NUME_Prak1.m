fR = @(x) 1./(1.+25.*x.^2);
f1 = @(x) (1.+cos(3./2.*pi.*x)).^(2/3);
N = 12;
x = [-1:2/N:1];
y = fR(x);
[P] = polyfit(x,y,N+1);

xPlot = [-1:2/(10*N):1];

yPlot = fR(xPlot);
polyPlot = polyval(P,xPlot);

plot(xPlot,polyPlot,xPlot,yPlot)



