close all;

global alfa1 beta Umin alfa2 us g poprz_h skok t_skoku Y_WYJSCIE U

%init
skok = 0;
c1 = 0.6;
S1 = 0.10635;
S2=S1;
g = 981;
c2 = 0.85;
a = 31;
Umin = 1.7;
A1 = 81;
A2 = A1;

alfa1 = c1*S1/A1;
alfa2 = c2*S2/A2;
beta = a/A1;
U = [0 0];
%end init

us = 1.8;
if us < 1.7
    us = 0;
end

h0 = [0; 0];
poprz_h = [0;0];
OPTIONS = odeset('MaxStep', 50);
[T_WYJSCIE, H_WYJSCIE] = ode45(@obiektReg, [0 10000], h0, OPTIONS); 
pom1 = 0.068*H_WYJSCIE(:,1)+ones(size(H_WYJSCIE)(1),1)*0.5116;
pom2 = 0.0883*H_WYJSCIE(:,2)+ones(size(H_WYJSCIE)(1),1)*0.6066;
Y_WYJSCIE = [T_WYJSCIE, pom1, pom2];

%obliczenie wzmocnienia i stalej czasowej
h_ustalone = [0 0];
for i = 10:size(H_WYJSCIE)(1)-1
    if abs(H_WYJSCIE(i,1)-H_WYJSCIE(i+1,1))<0.01 && abs(H_WYJSCIE(i,2)-H_WYJSCIE(i+1,2))<0.01
        h_ustalone = [H_WYJSCIE(i,:)]
        break;
    end
end

K = [0 0];
K = h_ustalone/us;
K
for i = 10:size(H_WYJSCIE)(1)
    if H_WYJSCIE(i,1)-0.63*h_ustalone(1)<0 && H_WYJSCIE(i,2)-0.63*h_ustalone(2)>=0
        T1 = T_WYJSCIE(i);
    end
    if H_WYJSCIE(i,1)-0.95*h_ustalone(1)<0 && H_WYJSCIE(i,2)-0.95*h_ustalone(2)>=0
        T3 = T_WYJSCIE(i);
    end
    if H_WYJSCIE(i,1)-0.99*h_ustalone(1)<0 && H_WYJSCIE(i,2)-0.99*h_ustalone(2)>=0
        T5 = T_WYJSCIE(i);
    end
end
T1
T3
T5

%koniec obliczania wzmocnienia i stalej czasowej

figure;

subplot(2,2,1);
plot(T_WYJSCIE,H_WYJSCIE(:,1));
hold on;
t_lin = linspace(0,10000,10000);
h1_lin1 = K(1)*1.8*(1-e.^(-t_lin/T1));
plot(t_lin,h1_lin1,'r');
U = sortrows(U);
plot(U(:,1),U(:,2),'g');
plot([t_skoku t_skoku],[0,20],'m');
legend('H1','model','us','zalaczenie');
grid on;
title('H1, u=1.8');
xlabel('t');
ylabel('H1');


subplot(2,2,2);
plot(T_WYJSCIE,H_WYJSCIE(:,2));
grid on;
title('H2, u=1.8');
xlabel('t');
ylabel('H2');

subplot(2,2,3);
plot(Y_WYJSCIE(:,1),Y_WYJSCIE(:,2));
grid on;
title('Y1, u=1.8');
xlabel('t');
ylabel('Y1');

subplot(2,2,4);
plot(Y_WYJSCIE(:,1),Y_WYJSCIE(:,3));
grid on;
title('Y2, u=1.8');
xlabel('t');
ylabel('Y2');

%init
Y_WYJSCIE = [];
h_hist=[];
h0 = [0; 0];
poprz_h = [0;0];
skok = 0;
us = 4;
%end init

OPTIONS = odeset('MaxStep', 50,'NonNegative',1);
[TT_WYJSCIE, YH_WYJSCIE] = ode45(@obiektReg, [0 20000], h0, OPTIONS); 
pom1 = 0.068*YH_WYJSCIE(:,1)+ones(size(YH_WYJSCIE)(1),1)*0.5116;
pom2 = 0.0883*YH_WYJSCIE(:,2)+ones(size(YH_WYJSCIE)(1),1)*0.6066;
Y_WYJSCIE = [TT_WYJSCIE, pom1, pom2];

figure;
subplot(2,2,1);
plot(TT_WYJSCIE,YH_WYJSCIE(:,1));
grid on;
title('H1, u=4');
xlabel('t');
ylabel('H1');

subplot(2,2,2);
plot(TT_WYJSCIE,YH_WYJSCIE(:,2));
grid on;
title('H2, u=4');
xlabel('t');
ylabel('H2');

subplot(2,2,3);
plot(Y_WYJSCIE(:,1),Y_WYJSCIE(:,2));
grid on;
title('Y1, u=4');
xlabel('t');
ylabel('Y1');

subplot(2,2,4);
plot(Y_WYJSCIE(:,1),Y_WYJSCIE(:,3));
grid on;
title('Y2, u=4');
xlabel('t');
ylabel('Y2');
