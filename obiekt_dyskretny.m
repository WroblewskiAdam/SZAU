function [h1_out, h2_out] = obiekt_dyskretny(lin, t_sim, h1_0, h2_0, F1in, tau, t, Fd)
%stałe
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;

%punkt pracy
tau = tau;
Fd = Fd;
F1 = F1in(t-tau);

%startowe h1, h2
h1 = zeros(t_sim,1);
h1(1) = h1_0;
h2 = zeros(t_sim,1);
h2(1) = h2_0;

for k=2:t_sim
    if lin == 1
        % zlinearyzowany TODO
        %dh1 = @(h1, h2, F1) (F1 + Fd - alfa2*sqrt(h1))/(2*C1*h1);
        %dh2 = @(h1, h2) (alfa1*sqrt(h1) - alfa2*sqrt(h2))/(3*C2*(h2^2));
    else
        % nieliniowy
        h1(k) = ((F1 + Fd - alfa2*sqrt(h1(k-1)))/(2*C1*h1(k-1))) * 1 + h1(k-1);
        h2(k) = ((alfa1*sqrt(h1(k-1)) - alfa2*sqrt(h2(k-1))) / (3*C2*(h2(k-1)^2)))  * 1 + h2(k-1);
    end
end
h1_out = h1(2:end);
h2_out = h2(2:end);
end