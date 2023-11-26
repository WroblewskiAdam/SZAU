function responses = pobranie_modelu_rozmyte(ilosc_obszarow)
    responses = cell(1, ilosc_obszarow);

    if ilosc_obszarow == 2
        u_pp = [33.8, 52];
        u = [34.8, 53];
    elseif ilosc_obszarow == 3
        u_pp = [27.8, 44.8, 56];
        u = [28.8, 45.8, 57];
    elseif ilosc_obszarow == 4
        u_pp = [23.7, 38, 49, 58];
        u = [24.7, 39, 50, 59];
    elseif ilosc_obszarow == 5
        u_pp = [20.6, 33.8, 43.8, 52, 60];
        u = [21.6, 34.8, 44.8, 53, 61];
    end

    figure(21)
    title('Rozmyte odpowiedzi skokowe')
    for i=1:length(u)
        responses{i} = pobranie_modelu(u(i), u_pp(i));
       hold on
       stairs(responses{i})
    end
    legend('obszar 1', 'obszar 2', 'obszar 3', 'obszar 4')
    % print("DMC_roz_02.png","-dpng","-r400")
end