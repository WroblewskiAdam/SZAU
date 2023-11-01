function [h1_out, h2_out] = obiekt_ciagly(lin, t_sim, h1_0, h2_0, F1in, tau, t, Fd)
%stałe
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
%punkt pracy
tau = tau;
Fd = Fd;
F1 = F1in(t-tau);
if lin == 1
    % zlinearyzowany todo	
	% dh1 = @(h1, h2) ((F1 + Fd - alfa1*sqrt(h1_0))/(2*C1*h1_0) + ((-F1 - Fd)/(2*C1*(h1_0^2))  + (alfa1 / (4*C1*h1_0*sqrt(h1_0))) * (h1 - h1_0)));
	% dh2 = @(h1, h2) ((alfa1*sqrt(h1_0) + alfa2 * sqrt(h2_0))/(3*C2*h2_0^2)  - ((3*alfa1 - 3*alfa2)/(6*C2*h2_0^2 * sqrt(h2_0))) * (h2 - h2_0));
	dh = @(h) [((F1 + Fd - alfa1*sqrt(h1_0))/(2*C1*h1_0) + ((-F1 - Fd)/(2*C1*(h1_0^2))  + (alfa1 / (4*C1*h1_0*sqrt(h1_0))) * (h1 - h1_0))); ((alfa1*sqrt(h1_0) + alfa2 * sqrt(h2_0))/(3*C2*h2_0^2)  - ((3*alfa1 - 3*alfa2)/(6*C2*h2_0^2 * sqrt(h2_0))) * (h2 - h2_0))];
else
    % nieliniowy
    dh = @(t, h) [((F1 + Fd - alfa2*sqrt(h(1)))/(2*C1*h(1))); ((alfa1*sqrt(h(1)) - alfa2*sqrt(h(2)))/(3*C2*(h(2)^2)))];
    % dh2 = @(h1, h2) ((alfa1*sqrt(h1) - alfa2*sqrt(h2))/(3*C2*(h2^2)));
end

%zakres czasu i punkty początkowe
[T, h_out] = ode45(dh, [0 t_sim], [h1_0 h2_0]);
h1_out = h_out(:,1);
h2_out = h_out(:,2);
end