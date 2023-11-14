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


% %test dyskretne
[h1_d, h2_d] = obiekt_dyskretny(0, Ts, h1_pp, h2_pp, F1_in);
[h1_d_zlin, h2_d_zlin] = obiekt_dyskretny(1, Ts, h1_pp, h2_pp, F1_in);



figure(1)
hold on
grid on
plot(t,h1_c);
plot(t,h2_c)
stairs(h1_d);
stairs(h2_d);
title('Punkt pracy ciągły');
legend('h1', 'h2', 'h1_dyskr', 'h2_dyskr');
% legend('h1_dyskr', 'h2_dyskr');

figure(2)
hold on
grid on
plot(t_zlin,h1_c_zlin);
plot(t_zlin,h2_c_zlin)
stairs(h1_d_zlin);
stairs(h2_d_zlin);
title('Punkt pracy ciągły');
legend('h1', 'h2', 'h1_dyskr', 'h2_dyskr');
% legend('h1_dyskr', 'h2_dyskr');

% figure(1)
% hold on
% grid on
% plot(t,h1_c);
% plot(t,h2_c)
% plot(t_zlin,h1_c_zlin);
% plot(t_zlin,h2_c_zlin);
% title('Punkt pracy ciągły');
% legend('h1', 'h2', 'h1_zlin', 'h2_zlin');
% 
% disp(h1_c(end));
% disp(h2_c(end));
% 
% 
% figure(2)
% hold on
% grid on
% plot(h1_d)
% plot(h2_d)
% title('Punkt pracy dyskretny')
% legend('h1', 'h2');
%% DMC
global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;

Ts = 3000;
wektor = [500, 250, 1];

yzad(1:550)= 9.9225;
yzad(551:1000)= 12;
yzad(1001:1500)= 8;
yzad(1501:3000)= 10;
[E, y, yzad, u] = DMC_ana(wektor, yzad, Ts);

figure(1);
stairs(y);
hold on;
grid on;
stairs(yzad);
legend('h2', 'h zad')
title('wyjscie')

figure(2);
stairs(u);
hold on;
grid on;
title('sterowanie')