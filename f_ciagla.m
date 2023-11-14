function [h] = f_ciagla(t,h)
	C1 = 0.75;
	C2 = 0.55;
	alfa1 = 20;
	alfa2 = 20;
	Fd = 11;
	tau = 50;
	global F1_in

	if floor(t) - tau < 1
		F1 = F1_in(1);
	else
    	F1 = F1_in(floor(t) - tau);
	end

	h = [((F1 + Fd - alfa2*sqrt(h(1)))/(2*C1*h(1))); ((alfa1*sqrt(h(1)) - alfa2*sqrt(h(2)))/(3*C2*(h(2)^2)))];
end

