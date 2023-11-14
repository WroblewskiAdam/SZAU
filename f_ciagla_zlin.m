function [h] = f_ciagla_zlin(t,h)
	global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
	Fd = 11;
	tau = 50;

	if floor(t) - tau < 1
		F1 = F1_in(1);
	else
    	F1 = F1_in(floor(t) - tau);
	end
	
	h1_plin = h1_pp;
	h2_plin = h2_pp;

	%wysryw wolfram 2
	h1 = (-alfa1 * sqrt(h1_plin) + Fd + F1) / (2*C1*h1_plin) + ((alfa1*sqrt(h1_plin) - 2*Fd - 2*F1)/(4*C1*h1_plin^2)) * (h(1) - h1_plin) ;
	h2 = (alfa1*sqrt(h(1)) - alfa2*sqrt(h2_plin)) / (3*C2*h2_plin^2) + ((3*alfa2*sqrt(h2_plin) - 4*alfa1*sqrt(h(1)))/(6*C2*h2_plin^3)) * (h(2) - h2_plin);
	h = [h1;h2];

	% mój wysryw
	% h = [((F1 + Fd - alfa1*sqrt(h1_plin))/(2*C1*h1_plin) + ((-F1 - Fd)/(2*C1*(h1_plin^2))  + (alfa1 / (4*C1*h1_plin*sqrt(h1_plin))) * (h(1)- h1_plin))); ((alfa1*sqrt(h(1)) + alfa2 * sqrt(h2_plin))/(3*C2*h2_plin^2)  - ((3*alfa1 - 3*alfa2)/(6*C2*h2_plin^2 * sqrt(h2_plin))) * (h(2)- h2_plin))];

	%wysryw wolfram 1 
	% h = [( 42  - 13.3333 * sqrt(h1_plin))/h1_plin + ((6.66667 * sqrt(h1_plin) - 42) * (h(1)- h1_plin))/h1_plin^2; (12.1212 * sqrt(h(1))  - 12.1212*sqrt(h2_plin)) / h2_plin^2 + ((18.1818*sqrt(h2_plin) - 24.2424*sqrt(h(1)))/h2_plin^3) * (h(2)- h2_plin)];
end


