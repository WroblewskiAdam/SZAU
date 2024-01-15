%% wgranie zmiennych
clear; 
close all;
% global u y Nu N k d y_zad lambda;
% global w20 w2 w10 w1;
% model;
run("model_best_zad22.m")
% parametry;
alfa1 = -1.413505;
alfa2 = 0.462120;
beta1 = 0.016447;
beta2 = 0.012722;

%% czas symulacji
Ts = 1000;
start = 6;

%% regulator
% NPL = 1, GPC = 2, PID = 3;
regulator = 1;

%% nastawy 
% NPL,GPC
if regulator == 1 || regulator == 2
    D = 100;
    N = 30;
    Nu = 5;
    lambda = 10;
end
%PID
if regulator == 3
    PID_K = 0.25;
    PID_Ti = 10;
    PID_Td = 0.75;
    Tp = 1;
end

%% inicjalizacje
% NPL
if regulator == 1
    delta = 0.000001;
end
% GPC
if regulator == 2

    % paramtery modelu liniowego
    ts = 4000;
    load("dane_uczace.mat")
    load("dane_weryfikujace.mat")
    M = zeros(ts - 5, 4);
    for i=6: length ( y_ucz )
	    row = [ u_ucz(i -4) u_ucz(i -5)  y_ucz(i -1)  y_ucz(i -2) ];
	    M(i-5,:) = row;
    end    
    Y = y_ucz(6:ts)';
    W = M\Y;

    % linearyzacja numeryczna w punkcie pracy
    % delta = 0.000001;
    % GPC_b4 = ((w20 + w2*tanh(w10+w1*[delta 0 0 0]'))- (w20 + w2*tanh(w10+w1*[0 0 0 0]')))/delta;
    % GPC_b5 = ((w20 + w2*tanh(w10+w1*[0 delta 0 0]'))- (w20 + w2*tanh(w10+w1*[0 0 0 0]')))/delta;
    % GPC_a1 = ((w20 + w2*tanh(w10+w1*[0 0 delta 0]'))- (w20 + w2*tanh(w10+w1*[0 0 0 0]')))/delta;
    % GPC_a2 = ((w20 + w2*tanh(w10+w1*[0 0 0 delta]'))- (w20 + w2*tanh(w10+w1*[0 0 0 0]')))/delta;
    
    %odpowiedz s modelu
    GPC_y_sym_s(1:D+6) = 0;
    GPC_u_sym_s(1:D+6) = 0;
    GPC_u_sym_s(6:end) = 1;
    for k=start:D+6
        GPC_y_sym_s(k) = W(1)*GPC_u_sym_s(k-4)+W(2)*GPC_u_sym_s(k-5)+W(3)*GPC_y_sym_s(k-1)+W(4)*GPC_y_sym_s(k-2);
    end
    GPC_s = GPC_y_sym_s(6:end);

    % macierz M
    GPC_M = zeros(N,Nu);
    for i=1:N
        for j=1:Nu
            if(i>=j)
                GPC_M(i,j) = GPC_s(i-j+1);
            end
        end
    end

    % K
    GPC_K = ((GPC_M' * GPC_M + eye(Nu) * lambda)^-1) * GPC_M';
end
% PID
if regulator == 3
    PID_R0 = PID_K*(1+(Tp/(2*PID_Ti))+(PID_Td/Tp));
    PID_R1 = PID_K*((Tp/(2*PID_Ti))-((2*PID_Td)/Tp)-1);
    PID_R2 = PID_K*(PID_Td/Tp);
end

%% inicalizacja wektorów
y(1:Ts+N) = 0;
u(1:Ts) = 0;
x1(1:Ts) = 0;
x2(1:Ts) = 0;
e(1:Ts) = 0;
d(1:Ts) = 0;
%% trajketoria zadana
y_zad(1:Ts) = 0;
y_zad(10:Ts) = 1.5;
y_zad(200:Ts) = 2;
y_zad(400:Ts) = -0.1;
y_zad(600:Ts) = 0.2;
y_zad(800:Ts) = -0.5;

%% głowa pętla symulacji
for k=start:Ts
    % PROCES
    x1(k) = -alfa1*x1(k-1)+x2(k-1)+beta1*g1(u(k-4));
    x2(k) = -alfa2*x1(k-1)+beta2*g1(u(k-4));
    y(k) = g2(x1(k));
    
    e(k) = y_zad(k) - y(k);
    
    % REGULATORY
    if regulator == 1 % NPL
        % dokładność modelu
        d(k) = y(k) - (w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1) y(k-2)]'));
                   
        %linearyzacja
        NPL_b4 = ((w20 + w2*tanh(w10+w1*[u(k-4)+delta u(k-5) y(k-1) y(k-2)]'))- (w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1) y(k-2)]')))/delta;
        NPL_b5 = ((w20 + w2*tanh(w10+w1*[u(k-4) u(k-5)+delta y(k-1) y(k-2)]'))- (w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1) y(k-2)]')))/delta;
        NPL_a1 = ((w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1)+delta y(k-2)]'))- (w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1) y(k-2)]')))/delta;
        NPL_a2 = ((w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1) y(k-2)+delta]'))- (w20 + w2*tanh(w10+w1*[u(k-4) u(k-5) y(k-1) y(k-2)]')))/delta;

        % odp skokowa
        NPL_y_sym_s(1:D+6) = 0;
        NPL_u_sym_s(1:D+6) = 0;
        NPL_u_sym_s(6:end) = 1;
        for i=7:D+6
            NPL_y_sym_s(i) = NPL_b4*NPL_u_sym_s(i-4)+NPL_b5*NPL_u_sym_s(i-5)+NPL_a1*NPL_y_sym_s(i-1)+NPL_a2*NPL_y_sym_s(i-2);
        end
        NPL_s = NPL_y_sym_s(6:end);

        % macierz M
        NPL_M = zeros(N,Nu);
        for i=1:N
            for j=1:Nu
                if(i>=j)
                    NPL_M(i,j) = NPL_s(i-j+1);
                end
            end
        end

        % K
        NPL_K = ((NPL_M' * NPL_M + eye(Nu) * lambda)^-1) * NPL_M';

        % nieliniowa predykcja
        y(k+1) = w20 + w2*tanh(w10+w1*[u(k-3) u(k-4) y(k) y(k-1)]') + d(k);
        y(k+2) = w20 + w2*tanh(w10+w1*[u(k-2) u(k-3) y(k+1) y(k)]') + d(k);
        y(k+3) = w20 + w2*tanh(w10+w1*[u(k-1) u(k-2) y(k+2) y(k+1)]') + d(k);
        for i=3:N
            y(k+i) = w20 + w2*tanh(w10+w1*[u(k-1) u(k-1) y(k+i-1) y(k+i-2)]') + d(k);
        end

        % sterowanie
        NPL_DELTA_U_K = NPL_K*(ones(N,1) * y_zad(k) - y(k+1:k+N)');
        u(k) = NPL_DELTA_U_K(1) + u(k-1);

    elseif regulator == 2 % GPC
        % dokładność modelu
        d(k) = y(k) - (W(1)*u(k-4)+W(2)*u(k-5)+W(3)*y(k-1)+W(4)*y(k-2));

        % predykcja
        y(k+1) = W(1)*u(k-3)+W(2)*u(k-4)+W(3)*y(k)+W(4)*y(k-1) + d(k);
        y(k+2) = W(1)*u(k-2)+W(2)*u(k-3)+W(3)*y(k+1)+W(4)*y(k) + d(k);
        y(k+3) = W(1)*u(k-1)+W(2)*u(k-2)+W(3)*y(k+2)+W(4)*y(k+1) + d(k);
        for i=4:N
            y(k+i) = W(1)*u(k-1)+W(2)*u(k-1)+W(3)*y(k+i-1)+W(4)*y(k+i-2) + d(k);
        end
        % sterowanie
        GPC_DELTA_U_K = GPC_K*(ones(N,1) * y_zad(k) - y(k+1:k+N)');
        u(k) = GPC_DELTA_U_K(1) + u(k-1);


    elseif regulator == 3 % PID

        u(k) = PID_R2*e(k-2) + PID_R1*e(k-1) + PID_R0*e(k) + u(k-1);
    end

    
    % ograniczenia sterowania
    if u(k) > 1
        u(k) = 1;
    elseif u(k) < -1
        u(k) = -1;
    end

end
%% wyliczenie bledu i plot
E = (norm(e))^2;
disp(E);
%y

figure(1);
subplot(2,1,1);
hold on;
% set(0,'defaultLineLineWidth',1);
% set(0,'DefaultStairLineWidth',1);
% set(gca,'fontsize',12);
plot(y(1:Ts));
plot(y_zad);
% title("y");
xlabel('k')
ylabel('wyjście')
legend('GPC','y_z');
%print(mfilename + "_test",'-dpng','-r400');

%u
subplot(2,1,2);
% figure;
hold on;
% set(0,'defaultLineLineWidth',1);
% set(0,'DefaultStairLineWidth',1);
% set(gca,'fontsize',12);
plot(u(1:Ts));
% title("u");
xlabel('k')
ylabel('sterowanie')
% print("GPC",'-dpng','-r400');