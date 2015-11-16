function  dh = obiektReg(t, h)
    global us skok poprz_h h_stab t_stab
    if skok==0 && t>10 && abs(poprz_h(1)-h(1))<0.0001 && abs(poprz_h(2)-h(2)) < 0.0001
        skok = 1
        us = us  +1;
        h_stab = h;
        t_stab = t;
    end    
    dh = obiekt(h,us);
    poprz_h = h;
    
end
