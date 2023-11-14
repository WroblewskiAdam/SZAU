function [step_response] = pobranie_odpowiedzi(u_pp, u)
%stabilizowanie obiektu w pp
[h1, h2]=obiekt_dyskretny(0, 500, 0.001, 0.001, u_pp);

h1_0 = h1(end);
h2_0 = h2(end);

%skok wartości zadanej
[h1, h2]=obiekt_dyskretny(0, 500, h1_0, h2_0, u);

%wartość
step_response = h2(end);