%% SL
% zmiany wyjścia
Ts = 3000;
wektorSL = [400, 1, 0.01];
Fd(1:Ts) = 11;
yzad(1:550)= 9.9225;
yzad(551:1200)= 12.5;
yzad(1001:1500)= 8;
yzad(1501:3000)= 10;
[E, y, yzad, u] = SL(wektorSL, 3, 'tr', yzad, Ts, Fd);

figure(1);
stairs(y);
hold on;
grid on;
stairs(yzad);
legend('h2', 'h2 zad')
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
[E, y, yzad, u] = SL(wektorSL, 3, 'tr', yzad, Ts, Fd);

figure(3);
stairs(y);
hold on;
grid on;
stairs(yzad);
legend('h2', 'h2 zad')
title('Zaklocone wyjscie')
figure(4);
stairs(u);
hold on;
grid on;
title('Zaklocone sterowanie')

%% SL vs DMC
% zmiany wyjścia
Ts = 3000;
wektorSL = [400, 1, 0.01];
wektorDMC = [400, 1, 0.01, 400, 1, 0.01, 400, 1, 0.01];
Fd(1:Ts) = 11;
yzad(1:550)= 9.9225;
yzad(551:1200)= 12.5;
yzad(1001:1500)= 8;
yzad(1501:3000)= 10;
[E_sl, y_sl, yzad_sl, u_sl] = SL(wektorSL, 3, 'tr', yzad, Ts, Fd);
[E, y, yzad, u] = DMC_ana_rozmyty(wektorDMC, 3, 'tr', yzad, Ts, Fd);

figure(1);
stairs(y_sl);
hold on;
grid on;
stairs(y);
stairs(yzad_sl);
legend('h2 sl', 'h2 dmc', 'h2 zad');
title('wyjscie');

figure(2);
stairs(u_sl);
hold on;
grid on;
stairs(u);
legend('u sl', 'u dmc');
title('sterowanie');

% zmiany zakłóceń
yzad(1:Ts)= 9.9225;
Fd(1:1000)= 11;
Fd(1001:2000)= 15;
Fd(2001:Ts)= 5;
[E_sl, y_sl, yzad_sl, u_sl] = SL(wektorSL, 3, 'tr', yzad, Ts, Fd);
[E, y, yzad, u] = DMC_ana_rozmyty(wektorDMC, 3, 'tr', yzad, Ts, Fd);

figure(3);
stairs(y_sl);
hold on;
grid on;
stairs(y);
stairs(yzad);
legend('h2', 'h2 dmc', 'h2 zad')
title('Zaklocone wyjscie')

figure(4);
stairs(u_sl);
hold on;
grid on;
stairs(u);
legend('u sl', 'u dmc');
title('Zaklocone sterowanie');