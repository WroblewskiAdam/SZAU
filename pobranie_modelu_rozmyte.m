function responses = pobranie_modelu_rozmyte(ilosc_obszarow)
    responses = cell(1, ilosc_obszarow);
    u_min = 0;
    u_max = 70;
    % z badań
    %U = [u_min:(u_max-u_min)/ilosc_regulatorow:u_max];
    %U(U == 0) = [];
    %U_pp = [10, 40, 50];
    %U = [11, 41, 51];
    % 
    U_pp = [3, 14, 27, 45];
    U = [4, 15, 28, 46];
    % U_pp = [3, 9.8, 20, 39];
    % U = [4, 10.5, 20.5, 40];
    % 
    % U_pp = [5, 15, 27, 31, 50];
    % U = [5.2, 15.2, 27.2, 31.2, 50.2];
    % 
    % U_pp = [5, 15, 25, 35, 44, 54];
    % U = [7, 17, 27, 37, 46, 56];

    % figure(21)
    % title('Rozmyte odpowiedzi skokowe')
    for i=1:length(U)
        responses{i} = pobranie_modelu(U(i), U_pp(i));
    %    hold on
    %    stairs(responses{i})
    end
    % legend('obszar 1', 'obszar 2', 'obszar 3', 'obszar 4')
    % print("DMC_roz_02.png","-dpng","-r400")
end