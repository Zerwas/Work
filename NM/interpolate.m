%Shanshan_Huang_Florian_Starke_2
% Parameters: 
% #1 number of grid intervalls
% #2 0 for aequidistant zeros, 1 for Tschepyschow zeros
% #3 0 plot f and g_N, 1 plot f - g_N, 3 plot nothing
% #4 0 interpolate with polynom, 1 interpolate with spline
% #5 function
% #6 derivation of f for splineinterpolation
% example call: interpolate(12,0,0,1,runge,rungeDerivation)

function[EhN] = interpolate(N = 12,gridZeros = 0,plotThis = 0,interpolate = 0, f = @(x) 1./(1.+25.*x.^2), df = @(x) (-50).*x./((25.*x.^2.+1).^2))
	%fR = @(x) 1./(1.+25.*x.^2);
	%f1 = @(x) (1.+cos(3/2.*pi.*x)).^(2/3);
	aequiInt = @(left,n,right) [left:(right-left)/n:right];
	if (gridZeros == 0) %aequidistant zeros
		x = aequiInt(-1,N,1);
		xPlot = aequiInt(-1,10*N,1);
	else %Tschepyschow zeros
		T = @(k) cos((2.*k.+1)./(2*(N+1)).*pi);
		x = T([N:-1:0]);
		xPlot = aequiInt(-1,10,x(1));
		for i = 1:N
			xPlot = horzcat(xPlot,aequiInt(x(i),10,x(i+1))(2:end));
		end
		xPlot = horzcat(xPlot,aequiInt(x(N+1),10,1)(2:end));
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
			% for the ith interval calculate the coefficients of s_i
			h = x(i+1)-x(i);
			a = -2/h^3*(y(i+1)-y(i)) + 1/h^2*(  dy(i)+dy(i+1));
			b =  3/h^2*(y(i+1)-y(i)) - 1/h  *(2*dy(i)+dy(i+1));
			c = dy(i);
			d = y(i);

			% evaluate the calculated polnomial
			while j <= length(xPlot) && xPlot(j) <= x(i+1)
				intPlot = horzcat(intPlot,polyval([a,b,c,d],[xPlot(j)-x(i)]));
				j = j+1;
			end
		end
		
	end

	% to save plot enter "print -djpg filename.jpg"
	if (plotThis == 0) % plot the funktion and its interpolation
		plot(xPlot,intPlot,'r',xPlot,f(xPlot),'b');
		xlabel('x','Fontsize',15);
		ylabel('f(x)','Fontsize',15);
		set(gca,'Fontsize',15);
		legend('g','f');
	elseif (plotThis == 1)% plot the error
		plot(xPlot,f(xPlot)-intPlot)
		xlabel('x','Fontsize',15);
		ylabel('err(x)','Fontsize',15);
		set(gca,'Fontsize',15);
		legend('err');
	end
	EhN = max(abs(f(xPlot)-intPlot));
endfunction
