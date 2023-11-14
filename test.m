close all;
clear;
clc;
% stałe
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
Ts = 1000;

% punkt pracy
global F1in
tau = 50;
Fd = 11;
F1in(1:1+tau) = 52;
F1in(tau+1:100) = 52;
F1in(101:Ts) = 60;

% początkowe wartości
lin = 0;
Ts = 1000;
% h1_pp = 0.00001;
% h2_pp = 0.00001;

h1_pp = 9.9211;
h2_pp = 9.9225;
 

%test ciągłe
[h1_c, h2_c] = obiekt_ciagly(lin, Ts, h1_pp, h2_pp);
% % %test dyskretne
% [h1_d, h2_d] = obiekt_dyskretny(lin, Ts, 4, 5, F1in, tau, 51, Fd);


figure(1)
hold on
grid on
plot(h1_c);
plot(h2_c)
title('Punkt pracy ciągły');
legend('h1', 'h2');

disp(h1_c(end));
disp(h2_c(end));


% figure(2)
% hold on
% grid on
% plot(h1_d)
% plot(h2_d)
% title('Punkt pracy dyskretny')
% legend('h1', 'h2');