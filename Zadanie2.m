%% DMC rozmyty
% zmiany wyjścia
% close all;
global C1 C2 alfa1 alfa2
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
Ts = 7500;
Fd(1:Ts) = 11;
yzad(1:500)= 9.9225;
yzad(501:1500)= 12.5;
yzad(1501:2500)= 8;
yzad(2501:3500)= 10;
yzad(3501:6000)= 5;
yzad(6001:7500)= 14;

% 4 obszary bo błąd dla 4 ma 'dołek'
wektorDMCR = [300,1,0.1, 300,2,1, 500,1,0.1, 300,1,0.1];
[E_dmc_r, y_dmc_r, yzad_dmc_r, u_dmc_r] = DMC_ana_rozmyty(wektorDMCR, 4, 'gaus', yzad, Ts, Fd);
disp(E_dmc_r);
figure(1);
stairs(y_dmc_r);
hold on;
grid on;
stairs(yzad);
legend('h2','h2 zad', 'Location', 'SE');
title('wyjscie');

figure(2);
stairs(u_dmc_r);
hold on;
grid on;
title('sterowanie');

%% zmiany zakłóceń
global C1 C2 alfa1 alfa2
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
% yzad(1:Ts)= 9.9225;
% Fd(1:1000)= 11;
% Fd(1001:2000)= 15;
% Fd(2001:Ts)= 5;
% [E, y, yzad, u] = DMC_ana_rozmyty(wektorDMC, 3, 'tr', yzad, Ts, Fd);
% 
% figure(3);
% stairs(y_dmc_r);
% hold on;
% grid on;
% stairs(Fd);
% legend('h2','Fd')
% title('Zakłócone wyjście')
% 
% figure(4);
% stairs(u_dmc_r);
% hold on;
% grid on;
% title('Zakłócone sterowanie');