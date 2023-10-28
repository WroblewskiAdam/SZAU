function [step_response] = pobranie_modelu(u, u_pp)
%stabilizowanie obiektu w pp
[y_B1, y_A1]=wywolanie_symulacji(1500, u_pp, 3, 1.12);

y_b0 = y_B1(end);
y_a0 = y_A1(end);

%skok wartości zadanej
[y_B, y_A]=wywolanie_symulacji(1500, u, y_a0, y_b0);

%przeliczenie na skok jednostkowy
step_response = zeros(length(y_B),1);
for i=1:length(y_B)
    step_response(i) = (y_B(i) - y_b0) / ((u - u_pp));
end

% figure(3);
% hold on;
% grid on;
% stairs(step_response);
% title('Model', u)
% print("DMC_model.png","-dpng","-r400")
end

