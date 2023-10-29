% stałe
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;

% punkt pracy
tau = 50;
F1in(1:1+tau) = 52;
Fd = 11;

% początkowe wartości
lin = 0;
Ts = 1000;

%test ciągłe
[h1_c, h2_c] = obiekt_ciagly(lin, Ts, 4, 5, F1in, tau, 51, Fd);
%test dyskretne
[h1_d, h2_d] = obiekt_dyskretny(lin, Ts, 4, 5, F1in, tau, 51, Fd);


figure(1)
hold on
grid on
plot(h1_c);
plot(h2_c)
title('Punkt pracy ciągły');
legend('h1', 'h2');

figure(2)
hold on
grid on
plot(h1_d)
plot(h2_d)
title('Punkt pracy dyskretny')
legend('h1', 'h2');