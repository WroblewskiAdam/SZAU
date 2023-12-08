a1 = -1.413505;
a2 = 0.462120;
b1 = 0.016447;
b2 = 0.012722;

U = linspace(-1,1,100);

for i = 1:length(U)
	u = U(i);
	x = (g1(u) * (b1+b2)) / (1 + a1 + a2);
	Y(i) = g2((g1(u) * (b1+b2)) / (1 + a1 + a2));
end
figure(1)
grid on;
plot(U,Y)
title('Charakterystyka statyczna' )
xlabel('u')
ylabel('y')