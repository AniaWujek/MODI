close all;

global alfa1 beta Umin alfa2 us g poprz_h skok t_skoku U

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

h0_18 = [0; 0];
poprz_h = [0;0];
OPTIONS = odeset('MaxStep', 50);
[T_WYJSCIE_18, H_WYJSCIE_18] = ode45(@obiektReg, [0 10000], h0_18, OPTIONS); 
y1_18 = 0.068*H_WYJSCIE_18(:,1)+ones(size(H_WYJSCIE_18)(1),1)*0.5116;
y2_18 = 0.0883*H_WYJSCIE_18(:,2)+ones(size(H_WYJSCIE_18)(1),1)*0.6066;
Y_WYJSCIE_18 = [T_WYJSCIE_18, y1_18, y2_18];

%obliczenie wzmocnienia i stalej czasowej
h_ustalone_18 = [0 0];
for i = 10:size(H_WYJSCIE_18)(1)-1
    if abs(H_WYJSCIE_18(i,1)-H_WYJSCIE_18(i+1,1))<0.0001 && abs(H_WYJSCIE_18(i,2)-H_WYJSCIE_18(i+1,2))<0.0001
        h_ustalone_18 = [H_WYJSCIE_18(i,:)];
        break;
    end
end

K_18 = [0 0];
K_18 = h_ustalone_18/us;
K_18
T_18 = [0 0];
for i = 10:size(H_WYJSCIE_18)(1)-1
    if H_WYJSCIE_18(i,1)-0.63*h_ustalone_18(1)<0 && H_WYJSCIE_18(i+1,1)-0.63*h_ustalone_18(1)>=0
        T_18(1) = T_WYJSCIE_18(i);
    end
end

for i = 10:size(H_WYJSCIE_18)(1)-1
    if real(H_WYJSCIE_18(i,2)-0.63*h_ustalone_18(2))<0 && real(H_WYJSCIE_18(i+1,2)-0.63*h_ustalone_18(2))>=0
        T_18(2) = T_WYJSCIE_18(i);
    end
end
T_18

%koniec obliczania wzmocnienia i stalej czasowej

figure;

subplot(2,2,1);
plot(T_WYJSCIE_18,H_WYJSCIE_18(:,1));
hold on;
t_lin_10000 = linspace(0,10000,10000);
h1_lin_18 = K_18(1)*us*(1-e.^(-t_lin_10000/T_18(1)));
plot(t_lin_10000,h1_lin_18,'r');
U = sortrows(U);
plot(U(:,1),U(:,2),'g');
plot([t_skoku t_skoku],[0,30],'m');
legend('H1','model','us','zalaczenie');
grid on;
title('H1, u=1.8');
xlabel('t');
ylabel('H1');


subplot(2,2,2);
plot(T_WYJSCIE_18,H_WYJSCIE_18(:,2));
hold on;
h2_lin_18 = K_18(2)*us*(1-e.^(-t_lin_10000/T_18(2)));
plot(t_lin_10000,h2_lin_18,'r');
U = sortrows(U);
plot(U(:,1),U(:,2),'g');
plot([t_skoku t_skoku],[0,20],'m');
legend('H2','model','us','zalaczenie');
grid on;
title('H2, u=1.8');
xlabel('t');
ylabel('H2');

subplot(2,2,3);
plot(Y_WYJSCIE_18(:,1),Y_WYJSCIE_18(:,2));
grid on;
title('Y1, u=1.8');
xlabel('t');
ylabel('Y1');

subplot(2,2,4);
plot(Y_WYJSCIE_18(:,1),Y_WYJSCIE_18(:,3));
grid on;
title('Y2, u=1.8');
xlabel('t');
ylabel('Y2');


% *************************************** %
%                  us = 4                 %
% *************************************** %

%init
skok = 0;
t_skoku = 0;
U = [0 0];
us = 4;
%end init


h0_4 = [0; 0];
poprz_h = [0;0];
OPTIONS = odeset('MaxStep', 50);
[T_WYJSCIE_4, H_WYJSCIE_4] = ode45(@obiektReg, [0 20000], h0_4, OPTIONS); 
y1_4 = 0.068*H_WYJSCIE_4(:,1)+ones(size(H_WYJSCIE_4)(1),1)*0.5116;
y2_4 = 0.0883*H_WYJSCIE_4(:,2)+ones(size(H_WYJSCIE_4)(1),1)*0.6066;
Y_WYJSCIE_4 = [T_WYJSCIE_4, y1_4, y2_4];

%obliczenie wzmocnienia i stalej czasowej
h_ustalone_4 = [0 0];
for i = 10:size(H_WYJSCIE_4)(1)-1
    if abs(H_WYJSCIE_4(i,1)-H_WYJSCIE_4(i+1,1))<0.0001 && abs(H_WYJSCIE_4(i,2)-H_WYJSCIE_4(i+1,2))<0.0001
        h_ustalone_4 = [H_WYJSCIE_4(i,:)];
        break;
    end
end

K_4 = [0 0];
K_4 = h_ustalone_4/us;
K_4
T_4 = [0 0];
for i = 10:size(H_WYJSCIE_4)(1)-1
    if H_WYJSCIE_4(i,1)-0.63*h_ustalone_4(1)<0 && H_WYJSCIE_4(i+1,1)-0.63*h_ustalone_4(1)>=0
        T_4(1) = T_WYJSCIE_4(i);
    end
end

for i = 10:size(H_WYJSCIE_4)(1)-1
    if real(H_WYJSCIE_4(i,2)-0.63*h_ustalone_4(2))<0 && real(H_WYJSCIE_4(i+1,2)-0.63*h_ustalone_4(2))>=0
        T_4(2) = T_WYJSCIE_4(i);
    end
end
T_4

%koniec obliczania wzmocnienia i stalej czasowej

figure;

subplot(2,2,1);
plot(T_WYJSCIE_4,H_WYJSCIE_4(:,1));
hold on;
t_lin_20000 = linspace(0,20000,20000);
h1_lin_4 = K_4(1)*us*(1-e.^(-t_lin_20000/T_4(1)));
plot(t_lin_20000,h1_lin_4,'r');
U = sortrows(U);
plot(U(:,1),U(:,2),'g');
plot([t_skoku t_skoku],[0,300],'m');
legend('H1','model','us','zalaczenie');
grid on;
title('H1, u=1.8');
xlabel('t');
ylabel('H1');


subplot(2,2,2);
plot(T_WYJSCIE_4,H_WYJSCIE_4(:,2));
hold on;
h2_lin_4 = K_4(2)*us*(1-e.^(-t_lin_20000/T_4(2)));
plot(t_lin_20000,h2_lin_4,'r');
U = sortrows(U);
plot(U(:,1),U(:,2),'g');
plot([t_skoku t_skoku],[0,150],'m');
legend('H2','model','us','zalaczenie');
grid on;
title('H2, u=1.8');
xlabel('t');
ylabel('H2');

subplot(2,2,3);
plot(Y_WYJSCIE_4(:,1),Y_WYJSCIE_4(:,2));
grid on;
title('Y1, u=1.8');
xlabel('t');
ylabel('Y1');

subplot(2,2,4);
plot(Y_WYJSCIE_4(:,1),Y_WYJSCIE_4(:,3));
grid on;
title('Y2, u=1.8');
xlabel('t');
ylabel('Y2');

