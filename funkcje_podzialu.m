function functions = funkcje_podzialu(liczba_regulatorow, function_type, val_min, val_max)
    % z badań
    % po y
    %trap = {[0,0,0.4,0.7],[0.4,0.65,0.7,0.9],[0.6,0.9,0.9,1.2],[1,1.15,val_max,val_max]};
    % po u konwersja
    trap = {[0,0,5.38,12.26],[5.38,10.85,12.26,19.64],[9.56,19.64,19.64,45.67],[25,38.03,val_max,val_max]};



    %width = u_max-u_min;
    %width = [6.5, 21.8, 42];
    width = [4.8, 14.5, 28, 45];
    %trap = {[0,0,5,15],[5,15,16,26],[16,26,32,42],[32,42,y_max,y_max]};
    % 23.10 gir imo, nie ma anomali na startowym nastawie
    %trap = {[0,0,0.9,1.1],[0.9,1.1,1.1,1.2],[1.1,1.2,val_max,val_max]};
    %width = [4.8, 14.5, 26.6, 30.6, 50];
    %wi = [2,2,2,2,4];
    % width = [4.8, 14.5, 25, 33, 43.5, 54];
    %val = [2,2,1,0.75];
    
    functions = cell(1, liczba_regulatorow);
    for i = 1:1:liczba_regulatorow
        if function_type == "tr"
            functions{i} = ...
                @(x) trapmf(x, trap{i}); 
        elseif function_type == "gaus"
            functions{i} =...
                @(x) gaussmf(x, [2, ...
                width(i)]);
        end
    end
    %wykres
    % x=val_min:0.01:val_max;
    % figure(20)
    % title("Funkcje przynależności")
    % xlim([val_min val_max])
    % hold on
    % for i=1:1:liczba_regulatorow
    %     plot(x, functions{i}(x))
    % end
    % print("DMC_roz_01.png","-dpng","-r400")
end

