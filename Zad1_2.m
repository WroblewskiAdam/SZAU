clear;
clc;
close all;

func = 1; %1 - Ackley, 2 - Himmelblau

options = optimoptions('particleswarm', 'PlotFcn', 'pswplotbestf');

for i = 1:10
	if func == 1
		x = particleswarm(@(X) Ackley2(X), 2, [-5, -5], [5, 5], options);
		y = Ackley2(x);
	elseif func == 2
		x = particleswarm(@(X) Himmelblau2(X), 2, [-5, -5], [5, 5], options);
		y = Himmelblau2(x);
	end
	disp(x)
	disp(y)
	
end
