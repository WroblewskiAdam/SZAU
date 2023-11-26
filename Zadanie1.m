% stałe
global F1_in C1 C2 alfa1 alfa2 h1_pp h2_pp
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;

% punkt pracy
tau = 50;
Fd = 11;
h1_pp = 9.9211;
h2_pp = 9.9225;
F1_in(1:100) = 52;

% skok wartości
Ts = 1000;
F1_in(101:Ts) = 25;

[h1_c, h2_c, t] = obiekt_ciagly(0, Ts, h1_pp, h2_pp);
[h1_c_zlin, h2_c_zlin, t_zlin] = obiekt_ciagly(1, Ts, h1_pp, h2_pp);

[h1_d, h2_d] = obiekt_dyskretny(0, Ts, h1_pp, h2_pp, F1_in);
[h1_d_zlin, h2_d_zlin] = obiekt_dyskretny(1, Ts, h1_pp, h2_pp, F1_in);

% działanie dyskretnego
figure(1)
hold on
grid on
plot(t,h1_c);
stairs(h1_d);
plot(t,h2_c);
stairs(h2_d);
title('Nieliniowe');
legend('h1_c', 'h1_d', 'h2_c', 'h2_d');

figure(2)
hold on
grid on
plot(t_zlin,h1_c_zlin);
stairs(h1_d_zlin);
plot(t_zlin,h2_c_zlin);
stairs(h2_d_zlin);
title('Liniowe');
legend('h1_c', 'h1_d', 'h2_c', 'h2_d');

%% liniowy vs nieliniowy
figure(3)
hold on
grid on
stairs(h1_d);
stairs(h1_d_zlin)
stairs(h2_d);
stairs(h2_d_zlin)
legend('h1_l','h1_n', 'h2_l','h2_n');

F1_in(101:Ts) = 30;
[h1_d, h2_d] = obiekt_dyskretny(0, Ts, h1_pp, h2_pp, F1_in);
[h1_d_zlin, h2_d_zlin] = obiekt_dyskretny(1, Ts, h1_pp, h2_pp, F1_in);
figure(4)
hold on
grid on
stairs(h1_d);
stairs(h1_d_zlin)
stairs(h2_d);
stairs(h2_d_zlin)
legend('h1_l','h1_n', 'h2_l','h2_n');

F1_in(101:Ts) = 60;
[h1_d, h2_d] = obiekt_dyskretny(0, Ts, h1_pp, h2_pp, F1_in);
[h1_d_zlin, h2_d_zlin] = obiekt_dyskretny(1, Ts, h1_pp, h2_pp, F1_in);
figure(4)
hold on
grid on
stairs(h1_d);
stairs(h1_d_zlin)
stairs(h2_d);
stairs(h2_d_zlin)
legend('h1_l','h1_n', 'h2_l','h2_n');

%% DMC
% zmiany wyjścia
Ts = 3000;
wektor = [400, 1, 0.01];
Fd(1:Ts) = 11;
yzad(1:550)= 9.9225;
yzad(551:1200)= 12.5;
yzad(1001:1500)= 8;
yzad(1501:3000)= 10;
[E, y, h1, yzad, u] = DMC_ana(wektor, yzad, Ts, Fd);

figure(1);
stairs(y);
hold on;
grid on;
stairs(yzad);
stairs(h1);
legend('h2', 'h zad', 'h1')
title('wyjscie')
figure(2);
stairs(u);
hold on;
grid on;
title('sterowanie')

% zmiany zakłóceń
yzad(1:Ts)= 9.9225;
Fd(1:1000)= 11;
Fd(1001:2000)= 15;
Fd(2001:Ts)= 5;
[E, y, h1, yzad, u] = DMC_ana(wektor, yzad, Ts, Fd);

figure(3);
stairs(y);
hold on;
grid on;
stairs(yzad);
stairs(h1);
legend('h2', 'h zad', 'h1')
title('Zaklocone wyjscie')
figure(4);
stairs(u);
hold on;
grid on;
title('Zaklocone sterowanie')