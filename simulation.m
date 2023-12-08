close all
clc
clear

a1 = -1.413505;
a2 = 0.462120;
b1 = 0.016447;
b2 = 0.012722;

Ts = 2000;
x1 = zeros(1, Ts);
x2 = zeros(1, Ts);
y = zeros(1, Ts);
u = zeros(1, Ts);
umin = -1;
umax = 1;



%Generowanie przebiegu U
value = umin+rand(1,1)*(umax-umin);
for i = 1:Ts
	if mod(i,50) == 0
		value = umin+rand(1,1)*(umax-umin);
	end
	u(i) = value;
end

for k=10:Ts
	x1(k) =  -a1 * x1(k-1) + x2(k-1) + b1 * g1(u(k-4));
	x2(k) =  -a2 * x1(k-1) + b2 *g1(u(k-4));
	
	y(k) = g2(x1(k));
end


figure(1)
plot(u)
grid on
xlabel('k')
ylabel('u')

figure(2)
plot(y)
grid on
xlabel('k')
ylabel('y')
