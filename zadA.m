close all;

c1 = 0.6;
S1 = 0.10635;
S2=S1;
G = 981;
c2 = 0.85;
a = 31;
Umin = 1.7;
A1 = pi*100;
A2 = A1;

alfa1 = c1*S1/A1;
alfa2 = c2*S2/A2;
beta = a/A1;

us = 1.8;
if us < 1.7
    us = 0;
end


h1_0 = 0;
h2_0 = 0;

H1 = [h1_0];
H2 = [h2_0];

us = [];
for i = 1:6000
    us(i) = 1.8;
end

for i = 6000:30000
    us(i) = 1.8+1;
end



for c = 1:30000
    dh1dt = -alfa1*sqrt(2*G*H1(c))+beta*sqrt(us(c)-Umin);
    if H1(c)+dh1dt > 0
        H1(c+1) = H1(c)+dh1dt;
    else
        H1(c+1) = 0;
    end
    dh2dt = alfa1*sqrt(2*G*H1(c))-alfa2*sqrt(2*G*H2(c));
    if H2(c)+dh2dt > 0
        H2(c+1) = H2(c)+dh2dt;
    else
        H2(c+1) = 0;
    end
end

x=linspace(1,20,1);

hold on
plot(H1,'g')
plot(H2)
plot(us,'r')






















