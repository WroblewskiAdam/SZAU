%% SL
% zmiany wyjścia
Ts = 3000;
wektorSL = [300, 1, 0.1];
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
Ts = 9000;
wektor = [300, 1, 0.1];
Fd(1:Ts) = 11;
yzad(1:550)= 9.9225;
yzad(551:1000)= 12.5;
yzad(1001:2000)= 8;
yzad(2001:3000)= 10;
yzad(3001:4500)= 4;
yzad(4501:6000)= 15;
yzad(6001:7500)= 2;
yzad(7501:9000)= 5;

wektorSL = [300, 1, 0.1];
wektorDMCR = [300,1,0.1, 300,1,0.1, 300,1,0.1];
wektorDMC = [300, 1, 0.1];
[E_sl, y_sl, yzad_sl, u_sl] = SL(wektorSL, 3, 'tr', yzad, Ts, Fd);
[E_dmc_r, y_dmc_r, yzad_dmc_r, u_dmc_r] = DMC_ana_rozmyty(wektorDMCR, 3, 'tr', yzad, Ts, Fd);
[E_dmc, y_dmc, yzad_dmc, u_dmc] = DMC_ana(wektorDMC, yzad, Ts, Fd);

figure(1);
stairs(y_sl);
hold on;
grid on;
stairs(y_dmc_r);
stairs(y_dmc);
stairs(yzad_sl);
legend('h2 sl', 'h2 dmc rozmyty', 'h2 dmc','h2 zad');
title('wyjscie');

figure(2);
stairs(u_sl);
hold on;
grid on;
stairs(u_dmc_r);
stairs(u_dmc);
legend('u sl', 'u dmc');
title('sterowanie');

%% zmiany zakłóceń
yzad(1:Ts)= 9.9225;
Fd(1:1000)= 11;
Fd(1001:2000)= 15;
Fd(2001:Ts)= 5;

wektorSL = [300, 1, 0.1];
wektorDMCR = [300,1,0.1, 300,1,0.1, 300,1,0.1];
wektorDMC = [300, 1, 0.1];
[E_sl, y_sl, yzad_sl, u_sl] = SL(wektorSL, 3, 'tr', yzad, Ts, Fd);
[E_dmc_r, y_dmc_r, yzad_dmc_r, u_dmc_r] = DMC_ana_rozmyty(wektorDMCR, 3, 'tr', yzad, Ts, Fd);
[E_dmc, y_dmc, yzad_dmc, u_dmc] = DMC_ana(wektorDMC, yzad, Ts, Fd);

figure(3);
stairs(y_sl);
hold on;
grid on;
stairs(y_dmc_r);
stairs(y_dmc);
stairs(Fd);
legend('h2', 'h2 dmc rozmyty', 'h2 dmc','Fd')
title('Zakłócone wyjscie')

figure(4);
stairs(u_sl);
hold on;
grid on;
stairs(u_dmc_r);
stairs(u_dmc);
legend('u sl', 'u dmc rozmyty', 'u dmc');
title('Zakłócone sterowanie');