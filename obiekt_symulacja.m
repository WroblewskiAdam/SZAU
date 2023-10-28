function [h1_out, h2_out] = obiekt_symulacja(dx1, dx2, h_1, h_2, u, h, t_sim, epsw, epsb, hmax, hmin, s)
for i=1:t_sim
    %pełny krok
    k11=dx1(h_1, h_2, u);
    k12=dx2(h_1, h_2);
    
    k21=dx1(h_1 + 0.5*h*k11, h_2 + 0.5*h*k12, u);
    k22=dx2(h_1 + 0.5*h*k11, h_2 + 0.5*h*k12);
    
    k31=dx1(h_1 + 0.5*h*k21, h_2 + 0.5*h*k22, u);
    k32=dx2(h_1 + 0.5*h*k21, h_2 + 0.5*h*k22); 
    
    k41=dx1(h_1 + h*k31, h_2 + h*k32, u);
    k42=dx2(h_1 + h*k31, h_2 + h*k32);
    
    xfull1= h_1 + (1/6)*h*(k11 + 2*k21 + 2*k31 + k41);
    xfull2= h_1 + (1/6)*h*(k12 + 2*k22 + 2*k32 + k42);
    
    %pierwszy półkrok
    h2 = h/2;
    
    khf21=dx1(h_1 + 0.5*h2*k11, h_2 + 0.5*h2*k12, u);
    khf22=dx2(h_1 + 0.5*h2*k11, h_2 + 0.5*h2*k12);
    
    khf31=dx1(h_1 + 0.5*h2*khf21, h_2 + 0.5*h2*khf22, u);
    khf32=dx2(h_1 + 0.5*h2*khf21, h_2 + 0.5*h2*khf22); 
    
    khf41=dx1(h_1 + h2*khf31, h_2 + h2*khf32, u);
    khf42=dx2(h_1 + h2*khf31, h_2 + h2*khf32);
    
    xhalf1=h_1 + (1/6)*h2*(k11 + 2*khf21 + 2*khf31 + khf41);
    xhalf2=h_2 + (1/6)*h2*(k12 + 2*khf22 + 2*khf32 + khf42);
    
    %drugi półkrok
    khs11 = dx1(xhalf1, xhalf2, u);
    khs12 = dx2(xhalf1, xhalf2);
    
    khs21=dx1(h_1 + h2*khs11, h_2 + h2*khs12, u);
    khs22=dx2(h_1 + h2*khs11, h_2 + h2*khs12);  
    
    khs31=dx1(h_1 + h2*khs21, h_2 + h2*khs22, u);
    khs32=dx2(h_1 + h2*khs21, h_2 + h2*khs22);  
    
    khs41=dx1(h_1 + h2*khs31, h_2 + h2*khs32, u);
    khs42=dx2(h_1 + h2*khs31, h_2 + h2*khs32);
    
    xhalfsec1=xhalf1 + (1/3)*h2*(khs11 + 2*khs21 + 2*khs31 + khs41);
    xhalfsec2=xhalf2 + (1/3)*h2*(khs12 + 2*khs22 + 2*khs32 + khs42);
   
    %obliczenie błędu
    d1 = (1/15)*(abs(xhalfsec1 - h_1));
    d2 = (1/15)*(abs(xhalfsec2 - h_1));
    
    e1 = abs(xhalfsec1)*epsw + epsb;
    e2 = abs(xhalfsec2)*epsw + epsb;
    
    alfa = min((e1/d1)^(1/5), ((e2/d2)^(1/5)));
    h= h*alfa*s;
    
    if h<hmin
        h=hmin;
    end
    if h>hmax
        h=hmax;
    end
    
    h1_out(:,i) = xfull1;
    h2_out(:,i) = xfull2;
    
    %przesunięcie współrzędnych do następnego punktu
    h1 = xfull1;
    h2 = xfull2;
end

end