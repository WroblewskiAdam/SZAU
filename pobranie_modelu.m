function [step_response] = pobranie_modelu(u, u_pp)
%stabilizowanie obiektu w pp
upp = u_pp * ones(1500 , 1);
% upp(51:1500) = u_pp;
[h1, h2]=obiekt_dyskretny(0, 1500, 9.9225, 9.9221, upp);
h1_0 = h1(end);
h2_0 = h2(end);

%skok wartości zadanej
uu = u_pp * ones(1500, 1);
uu(2:1500) = u;
[h1, h2]=obiekt_dyskretny(0, 1500, h1_0, h2_0, uu);

%przeliczenie na skok jednostkowy
step_response = zeros(length(h2),1);
for i=1:length(h2)
    step_response(i) = (h2(i) - h2_0) / ((u - u_pp));
end

% figure(30);
% hold on;
% grid on;
% stairs(step_response);
% title('Model', u)
% % print("DMC_model.png","-dpng","-r400")
end

