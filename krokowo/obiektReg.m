function  dh = obiektReg(t, h)
    global us poprz_h skok t_skoku U y_hist h_stab1 h_stab2 t_stab1 t_stab2
    
    y = [0 0];
    y(1) = 0.068*h(1)+0.5116;
    y(2) = 0.0883*h(2)+0.6066;
    u = us;
        
    if skok
        u = us + 1;
    else
        u = us;
    end
    
    if abs(poprz_h(1) - h(1))<0.0001 && abs(poprz_h(2) - h(2)) <0.0001 && t > 10
        if skok == 0
            t_skoku = t
            skok = 1;
            h_stab1 = h;
            t_stab1 = t;
        else
            h_stab2 = h;
            t_stab2 = t;
        end
            
    end
    
    
    poprz_h = h;
    dh = obiekt(h,u);
    U = [U ; t u];
    y_hist = [y_hist; t y];

end
