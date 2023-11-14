function [h] = f_dyskretna_zlin(t,h)
	global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
	Fd = 11;
	tau = 50;
	
	if (k-tau < 1)
		F1 = F1_in(k)
	end

	h1_plin = h1_pp;
	h2_plin = h2_pp;
	h1 = h(1);
	h2 = h(2);

	h1(k) = (-alfa1 * sqrt(h1_plin) + Fd + F1) / (2*C1*h1_plin) + ((alfa1*sqrt(h1_plin) - 2*Fd - 2*F1)/(4*C1*h1_plin^2)) * (h1(k-1) - h1_plin) + h1(k-1);
	h2(k) = (alfa1*sqrt(h1(k-1)) - alfa2*sqrt(h2_plin)) / (3*C2*h2_plin^2) + ((3*alfa2*sqrt(h2_plin) - 4*alfa1*sqrt(h1(k-1)))/(6*C2*h2_plin^3)) * (h2(k-1) - h2_plin) + h2(k-1);
	h = [h1;h2];
end


