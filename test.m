% stałe
C1 = 0.75;
C2 = 0.55;
alfa1 = 20;
alfa2 = 20;
% punkt pracy
lin = 0;
t_sim = 1000;
F1in(1:51) = 40;
tau = 50;
Fd = 11;
t = 51;
Ts = 1000;
h1 = 12 * ones(Ts , 1);
h2 = 12 * ones(Ts , 1);
for k=2:Ts
    
    h1(k) = ((F1in(5) + Fd - alfa2*sqrt(h1(k-1)))/(2*C1*h1(k-1))) * 1 + h1(k-1);
    h2(k) = ((alfa1*sqrt(h1(k-1)) - alfa2*sqrt(h2(k-1))) / (3*C2*(h2(k-1)^2)))  * 1 + h2(k-1);
end
figure(1)
subplot(1,2,1);
hold on
grid on
plot(h1)
subplot(1,2,2);
hold on
grid on
plot(h2)