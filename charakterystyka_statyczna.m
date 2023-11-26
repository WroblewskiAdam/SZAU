%cha-ka statyczna
% stałe
global C1 C2 alfa1 alfa2 F1_in
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;

Y = 9;
U = 20;
stat = [];
stat2 = [];
i = 1;
while U < 200
        Y = pobranie_odpowiedzi(U, U+1);
        stat(i) = Y;
        stat2(i) = U;
        i = i + 1;
        U = U + 1;
end
figure(1)
plot(stat2, stat);
xlim([0 200])
grid on;
xlabel('sterowanie')
ylabel('wyjscie')
% print("charakterystyka_statyczna.png","-dpng","-r400")

