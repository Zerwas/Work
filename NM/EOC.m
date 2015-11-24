function[result] = EOC(N1, N2, f = @(x) 1./(1.+25.*x.^2))
	result = [];
	for i = 1:min(length(N1),length(N2))
		result = horzcat(result,(log(interpolate(f,N1(i),0,3,1))-log(interpolate(f,N2(i),0,3,1)))/(log(2/N1(i))-log(2/N2(i))))
	end
endfunction

% 1.1572   2.6272   4.3901   2.1237   3.5334   3.8869   3.9719   3.9930   3.9982   3.9996   3.9999

