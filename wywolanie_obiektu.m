function [h1_out, h2_out] = wywolanie_obiektu(lin, t_sim, h1_0, h2_0, F1in, tau, Fd, t)
%stałe
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
tau = tau;
Fd = Fd;
t = t;
if lin == 1
    % zlinearyzowany
    dh1 = @(h1, h2, F1in) (F1in(t-tau) + Fd - alfa2*sqrt(h1))/(2*C1*h1);
    dh2 = @(h1, h2) (alfa1*sqrt(h1) - alfa2*sqrt(h2))/(3*C2*(h2^2));
else
    dh1 = @(h1, h2, F1in) ((F1in + Fd - 20*sqrt(h1))/(2*0.75*h1));
    dh2 = @(h1, h2) ((20*sqrt(h1) - 20*sqrt(h2))/(3*0.55*(h2^2)));
end
%do RK
epsw=0.1;
epsb=0.01;
hmax=0.1;
hmin=0.0000001;
s=0.9;
h=0.00001;


%Rungego–Kutty:
[h1_out, h2_out] = obiekt_symulacja(dh1, dh2, h1_0, h2_0, F1in, h, t_sim, epsw, epsb, hmax, hmin, s);
end