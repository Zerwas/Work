%Shanshan_Huang_Florian_Starke_2
%example call  EOC(2.^[1:11],2.^[2:12],f1,f1Derivation)
function[result] = EOC(N1, N2, f = @(x) 1./(1.+25.*x.^2), df = @(x) (-50).*x./((25.*x.^2.+1).^2))
	result = [];
	for i = 1:min(length(N1),length(N2))
		result = horzcat(result,(log(interpolate(N1(i),0,3,1,f,df))-log(interpolate(N2(i),0,3,1,f,df)))/(log(2/N1(i))-log(2/N2(i))))
	end
endfunction

%runge:
% 1.1572   2.6272   4.3901   2.1237   3.5334   3.8869   3.9719   3.9930   3.9982   3.9996   3.9999
%f1:
% 1.6644   1.4686   1.3727   1.3436   1.3359   1.3340   1.3335   1.3334   1.3333   1.3333   1.3333

