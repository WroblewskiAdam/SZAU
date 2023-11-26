% ZAD 1

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
F1_in(101:Ts) = 40;

% początkowe wartości
Ts = 1000;
% 
h1_pp = 9.9211;
h2_pp = 9.9225;

% 2: 5, 10

% 3: 3.75, 7.5, 11.25

% 4: 3, 6, 9, 12

% 5: 2.5, 5, 7.5, 10, 12.5

% %test ciągłe
[h1_c, h2_c, t] = obiekt_ciagly(0, Ts, h1_pp, h2_pp);
[h1_c_zlin, h2_c_zlin, t_zlin] = obiekt_ciagly(1, Ts, h1_pp, h2_pp);
% 
% % %test dyskretne
[h1_d, h2_d] = obiekt_dyskretny(0, Ts, h1_pp, h2_pp, F1_in);
[h1_d_zlin, h2_d_zlin] = obiekt_dyskretny(1, Ts, h1_pp, h2_pp, F1_in);
% 

% 
figure(1)
hold on
grid on
plot(h1_d);
plot(h2_d)
stairs(h1_d);
stairs(h2_d);
title('Nieliniowe');
legend('h1', 'h2', 'h1 dyskr', 'h2 dyskr');
% 
figure(2)
hold on
grid on
plot(t_zlin,h1_c_zlin);
plot(t_zlin,h2_c_zlin)
stairs(h1_d_zlin);
stairs(h2_d_zlin);
title('Zlinearyzowane');
legend('h1', 'h2', 'h1 dyskr', 'h2 dyskr');
% legend('h1_dyskr', 'h2_dyskr');
% 
% figure(3)
% hold on
% grid on
% plot(t,h1_c);
% plot(t,h2_c)
% plot(t_zlin,h1_c_zlin);
% plot(t_zlin,h2_c_zlin);
% title('Ciągłe');
% legend('h1', 'h2', 'h1 zlin', 'h2 zlin');
% 
% disp(h1_c(end));
% disp(h2_c(end));
% 
% 
% figure(4)
% hold on
% grid on
% stairs(h1_d);
% stairs(h2_d);
% stairs(h1_d_zlin);
% stairs(h2_d_zlin);
% title('Dyskretne')
% legend('h1', 'h2', 'h1 zlin', 'h2 zlin');
% 
% DMC
% global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
% C1 = 0.75;
% C2 = 0.55;
% alfa1 = 20;
% alfa2 = 20;
% 
% Ts = 10000;
% wektor = [400, 1, 0.01];
% 
% yzad(1:550)= 9.9225;
% yzad(551:1200)= 12.5;
% yzad(1001:1500)= 12;
% yzad(1501:3000)= 11.25;
% yzad(3001:3500)= 10;
% yzad(3501:4000)= 9;
% yzad(4001:5000)= 7.5;
% yzad(5001:6000)= 6;
% yzad(6001:7000)= 5;
% yzad(7001:8000)= 3.75;
% yzad(8001:9000)= 3;
% yzad(9001:10000)= 2.5;
% [E, y, h1, yzad, u] = DMC_ana(wektor, yzad, Ts);
% 
% figure(1);
% stairs(y);
% hold on;
% grid on;
% stairs(yzad);
% stairs(h1);
% legend('h2', 'h zad', 'h1')
% title('wyjscie')
% 
% figure(2);
% stairs(u);
% hold on;
% grid on;
% title('sterowanie')

%% ZAD 2


% DMC roz
global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;

Ts = 5000;
wektor = [400, 1, 0.01, 400, 1, 0.01, 400, 1, 0.01];

yzad(1:550)= 9.9225;
yzad(551:1200)= 12.5;
yzad(1001:1500)= 12;
yzad(1501:3000)= 11.25;
yzad(3001:3500)= 10;
yzad(3501:4000)= 9;
yzad(4001:5000)= 7.5;
% yzad(5001:6000)= 6;
% yzad(6001:7000)= 5;
% yzad(7001:8000)= 3.75;
% yzad(8001:9000)= 3;
% yzad(9001:10000)= 2.5;
[E, y, yzad, u] = DMC_ana_rozmyty(wektor,3, 'tr', yzad, Ts);
% wektor = [400, 1, 0.01];
% [Es, ys, yzads, us] = SL(wektor, 2, 'tr', yzad, Ts);

figure(1);
% stairs(y);
hold on;
grid on;
stairs(y);
stairs(yzad);
% legend('h2 sl','h2 dmc', 'h zad')
title('wyjscie')

figure(2);
% stairs(us);
hold on;
grid on;
stairs(u);
% legend('u sl','u dmc')
title('sterowanie')

