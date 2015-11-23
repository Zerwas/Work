function[] = NUME_Prak1(f,N)
	%fR = @(x) 1./(1.+25.*x.^2);
	%f1 = @(x) (1.+cos(3/2.*pi.*x)).^(2/3);
	T  = @(k) cos((2.*k.+1)./(2*N).*pi);

	x = [-1:2/N:1];
	xTsch = T([1:1:N]);

	y = f(x);
	[P] = polyfit(x,y,N+1);

	xPlot = [-1:2/(10*N):1];

	yPlot = f(xPlot);
	polyPlot = polyval(P,xPlot);

	plot(xPlot,polyPlot,xPlot,yPlot);
	return
endfunction
