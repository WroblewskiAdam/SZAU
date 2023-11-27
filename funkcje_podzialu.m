function functions = funkcje_podzialu(liczba_regulatorow, function_type, val_min, val_max)
    % modyfikacje pozycji aby dostroić dmc rozmytego
    width = val_max-val_min;
    % dmc rozmyty
    % size = [width-10, width-10, width+15, width+50, width];
    % locration = [val_min+1*(width-15)/(liczba_regulatorow), val_min+2*(width-12)/(liczba_regulatorow+1), val_min+3*(width-5)/(liczba_regulatorow+1), val_min+4*(width-4)/(liczba_regulatorow+1), val_min+5*width/(liczba_regulatorow+1)];
    % sl
    size = [width-10, width-2, width-2, width-2, width+10];
    location = [val_min+1*(width)/(liczba_regulatorow+1), val_min+2*(width)/(liczba_regulatorow+1), val_min+3*(width)/(liczba_regulatorow+1), val_min+4*(width)/(liczba_regulatorow+1), val_min+5*width/(liczba_regulatorow+1)];
    functions = cell(1, liczba_regulatorow);
    for i = 1:1:liczba_regulatorow
        if function_type == "tr"
            functions{i} = ...
                @(x) trimf(x, [val_min+(i-1)*width(i)/(liczba_regulatorow+1),...
                val_min+(i)*width(i)/(liczba_regulatorow+1)...
                val_min+(i+1)*width(i)/(liczba_regulatorow+1)]); 
        elseif function_type == "gaus"
            % [szerokosc, punkt]
            functions{i} =...
                @(x) gaussmf(x, [sqrt((size(i)/(liczba_regulatorow+1))), ...
                location(i)]);
        end
    end

    %wykres
    x=val_min:0.01:val_max;
    figure(20)
    title("Funkcje przynależności")
    xlim([val_min val_max])
    hold on
    for i=1:1:liczba_regulatorow
        plot(x, functions{i}(x))
    end
    print("Funkcje_SL.png","-dpng","-r400")
end

