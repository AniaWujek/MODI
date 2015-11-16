function  dh = obiektReg(t, h)
    global us skok t_skoku
    
    if skok==0 && t > t_skoku
        us = us + 1;
        skok = 1;
    end  
    dh = obiekt(h,us);

    
end
