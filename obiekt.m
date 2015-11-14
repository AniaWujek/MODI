function dh = obiekt(h,u)
    global alfa1 g beta Umin alfa2 us

    dh = [0; 0];
    dh(1) = -alfa1*sqrt(2*g*h(1)) + beta*sqrt(u - Umin);
    dh(2) = alfa1*sqrt(2*g*h(1)) - alfa2*sqrt(2*g*h(2));
end
