close all;
clear;
clc;
% stałe
global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
Ts = 1000;

% punkt pracy
tau = 50;
Fd = 11;
F1_in(1:1+tau) = 52;
F1_in(tau+1:100) = 52;
F1_in(101:Ts) = 50;

% początkowe wartości
Ts = 1000;

h1_pp = 9.9211;
h2_pp = 9.9225;
 
%test ciągłe
[h1_c, h2_c, t] = obiekt_ciagly(0, Ts, h1_pp, h2_pp);
[h1_c_zlin, h2_c_zlin, t_zlin] = obiekt_ciagly(1, Ts, h1_pp, h2_pp);


% % %test dyskretne
% [h1_d, h2_d] = obiekt_dyskretny(lin, Ts, 4, 5, F1in, tau, 51, Fd);


figure(1)
hold on
grid on
plot(t,h1_c);
plot(t,h2_c)
plot(t_zlin,h1_c_zlin);
plot(t_zlin,h2_c_zlin);
title('Punkt pracy ciągły');
legend('h1', 'h2', 'h1_zlin', 'h2_zlin');

disp(h1_c(end));
disp(h2_c(end));


% figure(2)
% hold on
% grid on
% plot(h1_d)
% plot(h2_d)
% title('Punkt pracy dyskretny')
% legend('h1', 'h2');