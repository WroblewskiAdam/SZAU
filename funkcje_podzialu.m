function functions = funkcje_podzialu(liczba_regulatorow, function_type, val_min, val_max)
    width = val_max-val_min;
    functions = cell(1, liczba_regulatorow);
    for i = 1:1:liczba_regulatorow
        if function_type == "tr"
            functions{i} = ...
                @(x) trimf(x, [val_min+(i-1)*width/(liczba_regulatorow+1),...
                val_min+(i)*width/(liczba_regulatorow+1)...
                val_min+(i+1)*width/(liczba_regulatorow+1)]); 
        elseif function_type == "gaus"
            functions{i} =...
                @(x) gaussmf(x, [sqrt((width/(liczba_regulatorow+1))), ...
                val_min+i*width/(liczba_regulatorow+1)]);
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
    % print("Funkcje_1.png","-dpng","-r400")
end

