%% DMC rozmyty
% zmiany wyjścia
Ts = 9000;
Fd(1:Ts) = 11;
yzad(1:550)= 9.9225;
yzad(551:1000)= 12.5;
yzad(1001:2000)= 8;
yzad(2001:3000)= 10;
yzad(3001:4500)= 4;
yzad(4501:6000)= 15;
yzad(6001:7500)= 2;
yzad(7501:9000)= 5;

wektorDMCR = [300,1,0.1, 300,1,0.1, 300,1,0.1];
[E_dmc_r, y_dmc_r, yzad_dmc_r, u_dmc_r] = DMC_ana_rozmyty(wektorDMCR, 4, 'gaus', yzad, Ts, Fd);

figure(1);
stairs(y_dmc_r);
hold on;
grid on;
stairs(yzad);
legend('h2','h2 zad');
title('wyjscie');

figure(2);
stairs(u_dmc_r);
hold on;
grid on;
title('sterowanie');

%% zmiany zakłóceń
yzad(1:Ts)= 9.9225;
Fd(1:1000)= 11;
Fd(1001:2000)= 15;
Fd(2001:Ts)= 5;
[E, y, yzad, u] = DMC_ana_rozmyty(wektorDMC, 3, 'tr', yzad, Ts, Fd);

figure(3);
stairs(y_dmc_r);
hold on;
grid on;
stairs(Fd);
legend('h2','Fd')
title('Zakłócone wyjście')

figure(4);
stairs(u_dmc_r);
hold on;
grid on;
title('Zakłócone sterowanie');