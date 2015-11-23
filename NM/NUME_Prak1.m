% Parameters: 
% #1 function
% #2 number of grid intervalls
% #3 0 for aequidistant zeros, 1 for Tschepyschow zeros
% #4 0 plot f and g_N, 1 plot f - g_N
% example call: NUME_Prak1(runge,12)

function[] = NUME_Prak1(f,N,NS,Err)
	%fR = @(x) 1./(1.+25.*x.^2);
	%f1 = @(x) (1.+cos(3/2.*pi.*x)).^(2/3);
	aequiInt = @(left,right,n) [left:(right-left)/n:right];
	if (NS == 0) %aequidistant zeros
		x = [-1:2/N:1];
		xPlot = aequiInt(-1,1,10*N);
	else %Tschepyschow zeros
		T  = @(k) cos((2.*k.-1)./(2*(N+1)).*pi);
		x = T([N+1:-1:1]);
		xPlot = aequiInt(-1,x(1),10);
		for i=1:N
			xPlot = horzcat(xPlot,aequiInt(x(i),x(i+1),10)(2:end));
		end
		xPlot = horzcat(xPlot,aequiInt(x(N+1),1,10)(2:end));
	end

	y = f(x); % calculate grid points
	[P] = polyfit(x,y,N);

	
	yPlot = f(xPlot);
	polyPlot = polyval(P,xPlot);
	
	if (Err == 0)
		plot(xPlot,polyPlot,xPlot,yPlot);
	else
		plot(xPlot,yPlot-polyPlot)
	end
endfunction
