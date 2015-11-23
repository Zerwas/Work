% Parameters: 
% #1 function
% #2 number of grid intervalls
% #3 0 for aequidistant zeros, 1 for Tschepyschow zeros
% #4 0 plot f and g_N, 1 plot f - g_N
% #5 0 interpolate with polynom, 1 interpolate with spline
% #6 derivation of f for splineinterpolation
% example call: NUME_Prak1(runge,12,0,0,1,rungeDerivation)

function[] = NUME_Prak1(f,N = 12,gridZeros = 0,plotThis = 0,interpolate = 0, df = @(x) x)
	%fR = @(x) 1./(1.+25.*x.^2);
	%f1 = @(x) (1.+cos(3/2.*pi.*x)).^(2/3);
	aequiInt = @(left,right,n) [left:(right-left)/n:right];
	if (gridZeros == 0) %aequidistant zeros
		x = [-1:2/N:1];
		xPlot = aequiInt(-1,1,10*N);
	else %Tschepyschow zeros
		T  = @(k) cos((2.*k.-1)./(2*(N+1)).*pi);
		x = T([N+1:-1:1]);
		xPlot = aequiInt(-1,x(1),10);
		for i = 1:N
			xPlot = horzcat(xPlot,aequiInt(x(i),x(i+1),10)(2:end));
		end
		xPlot = horzcat(xPlot,aequiInt(x(N+1),1,10)(2:end));
	end

	y = f(x); % calculate grid points
	if (interpolate == 0)
		[P] = polyfit(x,y,N);
	
		intPlot = polyval(P,xPlot);
	else 
		dy = df(x);
		intPlot = [];
		j = 1;
		for i = 1:length(x)-1
			h = x(i+1)-x(i);
			a = -2/h^3*(y(i+1)-y(i)) + 1/h^2*(  dy(i)+dy(i+1));
			b =  3/h^2*(y(i+1)-y(i)) - 1/h  *(2*dy(i)+dy(i+1));
			c = dy(i);
			d = y(i);
			%s = vertcat(s,[a,b,dy(i),y(i)]);
			while j <= length(xPlot) && xPlot(j) <= x(i+1)
				intPlot = horzcat(intPlot,polyval([a,b,c,d],[xPlot(j)-x(i)]));
				j = j+1;
			end
		end
		
	end
	length(xPlot)
	length(intPlot)
	if (plotThis == 0)
		plot(xPlot,intPlot,xPlot,f(xPlot));
	else
		plot(xPlot,f(xPlot)-intPlot)
	end
endfunction
