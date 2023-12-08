clc;
clear all;
close all

% Zlołdowanie modelu
run("sieci\model.m")
load("dane_uczace.mat")
load("dane_weryfikujace.mat")

Ts = 4000;

%obliczenie wyjścia 
y_mod_ucz_oe(1:5) = y_ucz(1:5);
y_mod_ucz_arx(1:5) = y_ucz(1:5);

y_mod_wer_oe(1:5) = y_wer(1:5);
y_mod_wer_arx(1:5) = y_wer(1:5);

for k = 6:Ts
	%dane uczące
	q_oe_ucz = [u_ucz(k-4); u_ucz(k-5); y_mod_ucz_oe(k-1); y_mod_ucz_oe(k-2)];
	q_arx_ucz = [u_ucz(k-4); u_ucz(k-5); y_ucz(k-1); y_ucz(k-2)];
	
	y_mod_ucz_oe(k) = w20 + w2*tanh(w10+ w1*q_oe_ucz);
	y_mod_ucz_arx(k) = w20 + w2*tanh(w10+ w1*q_arx_ucz);

	%dane weryfikujące
	q_oe_wer = [u_wer(k-4); u_wer(k-5); y_mod_wer_oe(k-1); y_mod_wer_oe(k-2)];
	q_arx_wer = [u_wer(k-4); u_wer(k-5); y_wer(k-1); y_wer(k-2)];
	
	y_mod_wer_oe(k) = w20 + w2*tanh(w10+ w1*q_oe_wer);
	y_mod_wer_arx(k) = w20 + w2*tanh(w10+ w1*q_arx_wer);
end




Error_ucz_arx = 0;
Error_ucz_oe = 0;

Error_wer_arx = 0;
Error_wer_oe = 0;
for k = 1:Ts
	Error_ucz_arx = Error_ucz_arx + (y_ucz(k) - y_mod_ucz_arx(k))^2;
	Error_ucz_oe = Error_ucz_oe + (y_ucz(k) - y_mod_ucz_oe(k))^2;

	Error_wer_arx = Error_wer_arx + (y_wer(k) - y_mod_wer_arx(k))^2;
	Error_wer_oe = Error_wer_oe + (y_wer(k) - y_mod_wer_oe(k))^2;
end

figure(1)
hold on
plot(y_ucz)
plot(y_mod_ucz_oe)
title('Wyjście modelu dla danych uczących')

figure(2)
hold on
plot(y_wer)
plot(y_mod_wer_oe)
title('Wyjście modelu dla danych weryfikuyjących')

