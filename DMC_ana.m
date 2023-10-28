function [E, y, yzad, u] = DMC_ana(wektor, yzad, Ts)
%Definicja horyzontów i parametrów
N = round(wektor(1));
N_u = round(wektor(2));
lambda = wektor(3);
D = 700;
start= D+1;
E = 0;

%model
s = pobranie_modelu(40, 34.5);

%deklaracja początkowych wektorów
u = 34.3 * ones(Ts , 1);
ya = 3.0 * ones(Ts , 1);
yb = 1.12 * ones(Ts , 1);
dUp = zeros(D-1, 1);

%Obliczenie części macierzy DMC
M = zeros(N, N_u);
for column=1:N_u
    for row=1:N
        if row - column + 1 >= 1
            M(row, column) = s(row - column + 1);
        else
            M(row, column) = 0;
        end
    end
end
L = lambda * eye(N_u);
K = (M.' * M + L) \ M.';
Mp = zeros(N, D-1);
for column=1:(D-1)
    for row=1:N
        Mp(row, column) = s(row + column) - s(column);
    end
end
Ku=K(1,:)*Mp;
Ke=sum(K(1,:));

for k=start:Ts
    %symulacja obiektu
    [yb_sim, ya_sim] = wywolanie_symulacji(1, u(k-1), ya(k-1), yb(k-1));
    ya(k) = ya_sim;
    yb(k) = yb_sim;

    %Obliczenie dUp
    for d=1:(D-1)
        dUp(d) = u(k-d) - u(k-d-1);
    end

    ek=yzad(k)-yb(k);
    
    %Obliczenie sterowania
    dU=Ke*ek-Ku*dUp;
    u(k) = u(k-1) + dU(1);

    % ograniczenia
    % if u(k) > 70
    %    u(k) = 70;
    % end
    % if u(k) < 0
    %    u(k) = 0;
    % end   
    E = E + (yzad(k)-yb(k))^2; 
end
%wyniki
yzad = yzad(start:Ts);
y = yb(start:Ts);
u = u(start:Ts);
end