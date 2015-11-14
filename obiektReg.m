function  dh = obiektReg(t, h)
    global us poprz_h skok t_skoku U
    
    y = [0 0];
    y(1) = 0.068*h(1)+0.5116;
    y(2) = 0.0883*h(2)+0.6066;
    u = us;
        
    if skok==0 && abs(poprz_h(1) - h(1))<0.0001 && abs(poprz_h(2) - h(2)) <0.0001 && t > 10
        t_skoku = t
        skok = 1;
    end
    
    if skok && t >= t_skoku
        u = us + 1;
    else
        u = us;
    end
    poprz_h = h;
    dh = obiekt(h,u);
    U = [U ; t u];

end
