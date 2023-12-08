%% ZAD1- Charakterystyka statyczna 
clear all
clc
a1 = -1.413505;
a2 = 0.462120;
b1 = 0.016447;
b2 = 0.012722;

U = linspace(-1,1,100);

for i = 1:length(U)
	u_wer = U(i);
	x = (g1(u_wer) * (b1+b2)) / (1 + a1 + a2);
	Y(i) = g2((g1(u_wer) * (b1+b2)) / (1 + a1 + a2));
end
figure(1)
plot(U,Y)
title('Charakterystyka statyczna' )
xlabel('u')
ylabel('y')
grid on;


%% ZAD1 - symulacja procesu
close all
clc
clear

% a1 = -1.413505;
% a2 = 0.462120;
% b1 = 0.016447;
% b2 = 0.012722;
% 
% Ts = 4000;
% x1 = zeros(1, Ts);
% x2 = zeros(1, Ts);
% y_wer = zeros(1, Ts);
% u_wer = zeros(1, Ts);
% umin = -1;
% umax = 1;
% 
% %Generowanie przebiegu U
% value = umin+rand(1,1)*(umax-umin);
% for i = 1:Ts
% 	if mod(i,100) == 0
% 		value = umin+rand(1,1)*(umax-umin);
% 	end
% 	u_wer(i) = value;
% end
% 
% for k=5:Ts
% 	x1(k) =  -a1 * x1(k-1) + x2(k-1) + b1 * g1(u_wer(k-4));
% 	x2(k) =  -a2 * x1(k-1) + b2 *g1(u_wer(k-4));
% 	y_wer(k) = g2(x1(k));
% end
% 
% figure(1)
% plot(u_wer)
% grid on
% xlabel('k')
% ylabel('u')
% 
% figure(2)
% plot(y_wer)
% grid on
% xlabel('k')
% ylabel('y')
% 
% save("dane_weryfikujace.mat","u_wer","y_wer")


load("dane_uczace.mat")
load("dane_weryfikujace.mat")
figure(1)
plot(u_ucz)
grid on
xlabel('k')
ylabel('u')
title('Dane uczące - u')

figure(2)
plot(y_ucz)
grid on
xlabel('k')
ylabel('y')
title('Dane uczące - y')

figure(3)
plot(u_wer)
grid on
xlabel('k')
ylabel('u')
title('Dane weryfikujace - u')

figure(4)
plot(y_wer)
grid on
xlabel('k')
ylabel('y')
title('Dane weryfikujace - y')