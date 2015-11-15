function  dh = obiektReg(t, h)
    global us skok poprz_h
    if skok==0 && t>10 && abs(poprz_h(1)-h(1))<0.0001 && abs(poprz_h(2)-h(2)) < 0.0001
        skok = 1;
    end    
    dh = obiekt(h,us);
    poprz_h = h;
    
end
