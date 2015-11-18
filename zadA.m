close all;

global alfa1 beta Umin alfa2 g us skok t_skoku
%init
%parametry niezmienne
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

%parametry zmienne
us = 1.8;
skok = -1;
t_skoku = 0;

%end init

% wyznaczenie punktu pracy
liczba_chwil = 3000;
OPTIONS = odeset('MaxStep',10);
[TOUT HOUT] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
Y = [HOUT(:,1)*0.068 + ones(size(HOUT,1),1)*0.5116 , HOUT(:,2)*0.0883 + ones(size(HOUT,1),1)*0.6066];
for i = 1:size(Y,1)-1
    if TOUT(i)>10 && abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
        t_stab = TOUT(i); %czas ustabilizowania
        ind_stab = i;
        y_stab = Y(i,:);
        break;
    end
end
disp(['Czas ustabilizowania dla us=' num2str(us) ': ' num2str(t_stab) ' na y1=' num2str(Y(ind_stab,1)) ' i na y2=' num2str(Y(ind_stab,2))]);

figure;
subplot(2,2,1);
plot(TOUT,Y(:,1));
hold on;
plot([t_stab t_stab],[0 y_stab(1)],'m');
grid on;
title('Y1, us = 1.8');
xlabel('t');
ylabel('Y1');

subplot(2,2,2)
plot(TOUT,Y(:,2));
hold on;
plot([t_stab t_stab],[0 y_stab(2)],'m');
grid on;
title('Y2, us = 1.8');
xlabel('t');
ylabel('Y2');

subplot(2,2,3);
plot(TOUT,HOUT(:,1));
hold on;
grid on;
title('H1, us = 1.8');
xlabel('t');
ylabel('H1');

subplot(2,2,4)
plot(TOUT,HOUT(:,2));
hold on;
grid on;
title('H2, us = 1.8');
xlabel('t');
ylabel('H2');


%skok jednostkowy
liczba_chwil = 10000;
t_skoku = t_stab;
skok = 0;
[TOUT HOUT] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
Y = [HOUT(:,1)*0.068 + ones(size(HOUT,1),1)*0.5116 , HOUT(:,2)*0.0883 + ones(size(HOUT,1),1)*0.6066];
for i = ind_stab:size(Y,1)-1
    if abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
        t_stab_skok = TOUT(i); %czas ustabilizowania
        ind_stab_skok = i;
        y_stab_skok = Y(i,:);
        break;
    end
end
disp(['Czas ustabilizowania po skoku jednostkowym dla us=' num2str(us) ': ' num2str(t_stab_skok) ' na y1=' num2str(Y(ind_stab,1)) ' i na y2=' num2str(Y(ind_stab,2))]);

T = [0 0];
%wyznaczenie wzmocnienia, stalej czasowej i opoznienia
K = (y_stab_skok - y_stab) / (1);
for i = ind_stab:ind_stab_skok
    if Y(i,1)-y_stab(1) <= (1-1/exp(1))*(y_stab_skok(1)-y_stab(1)) && Y(i+1,1)-y_stab(1) > (1-1/exp(1))*(y_stab_skok(1)-y_stab(1))
        T(1) = TOUT(i) - t_skoku;
    end
    if Y(i,2)-y_stab(2) <= (1-1/exp(1))*(y_stab_skok(2)-y_stab(2)) && Y(i+1,2)-y_stab(2) > (1-1/exp(1))*(y_stab_skok(2)-y_stab(2))
        T(2) = TOUT(i) - t_skoku;
    end
end

tau1 = 0;
tau2 = 0;
for i = ind_stab:ind_stab_skok
    if abs(Y(i,1)-Y(ind_stab-1,1)) > 0.00001
       tau1 = i -  ind_stab;
       break;
    end
end
for i = ind_stab:ind_stab_skok
    if abs(Y(i,2)-Y(ind_stab-1,2)) > 0.00001
       tau2 = i -  ind_stab;
       break;
    end
end
disp(['Wzmocnienie K1=' num2str(K(1)) ', K2=' num2str(K(2))]);
disp(['Stala czasowa T1=' num2str(T(1)) ', T2=' num2str(T(2))]);
disp(['Opoznienie tau1=' num2str(tau1) ', tau2=' num2str(tau2)]);

figure;
subplot(2,1,1);
plot(TOUT,HOUT(:,1));
grid on;
title('H1, us = 1.8');
xlabel('t');
ylabel('H1');

subplot(2,1,2)
plot(TOUT,HOUT(:,2));
grid on;
title('H2, us = 1.8');
xlabel('t');
ylabel('H2');

figure;
subplot(2,1,1);
plot(TOUT,Y(:,1));
hold on;
%rysunek modelu
T_model = TOUT(ind_stab:end);
y1_model = K(1)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T(1)))+y_stab(1);
plot(T_model,y1_model,'m');
xlabel('t');
ylabel('Y1');

grid on;
title(['Y1, us = 1.8, T=' num2str(T(1)) ', K=' num2str(K(1)) ', tau=' num2str(tau1)]);
% 
subplot(2,1,2)
plot(TOUT,Y(:,2));
hold on;
%rysunek modelu
y2_model = K(2)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T(2)))+y_stab(2);
plot(T_model,y2_model,'m');
grid on;
title(['Y2, us = 1.8, T=' num2str(T(2)) ', K=' num2str(K(2)) ', tau=' num2str(tau2)]);
xlabel('t');
ylabel('Y2');

%blad sredniokwadratowy dla Y1
mse_y1 = mean((Y(ind_stab:end,1) - y1_model).^2);
%blad sredniokwadratowy dla Y2
mse_y2 = mean((Y(ind_stab:end,2) - y2_model).^2);
disp(['Blad sredniokwadratowy dla Y1: ' num2str(mse_y1)]);
disp(['Blad sredniokwadratowy dla Y2: ' num2str(mse_y2)]);


% ************************************* %
%                 us = 4                %
% ************************************* %

%parametry zmienne
us = 4;
skok = -1;
t_skoku = 0;
%end init

% wyznaczenie punktu pracy
liczba_chwil = 10000;
OPTIONS = odeset('MaxStep',10);
[TOUT HOUT] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
Y = [HOUT(:,1)*0.068 + ones(size(HOUT,1),1)*0.5116 , HOUT(:,2)*0.0883 + ones(size(HOUT,1),1)*0.6066];
for i = 1:size(Y,1)-1
    if TOUT(i)>10 && abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
        t_stab = TOUT(i); %czas ustabilizowania
        ind_stab = i;
        y_stab = Y(i,:);
        break;
    end
end
disp(['Czas ustabilizowania dla us=' num2str(us) ': ' num2str(t_stab)  ' na y1=' num2str(Y(ind_stab,1)) ' i na y2=' num2str(Y(ind_stab,2))]);

figure;
subplot(2,2,1);
plot(TOUT,Y(:,1));
hold on;
plot([t_stab t_stab],[0 y_stab(1)],'m');
grid on;
title('Y1, us = 4');
xlabel('t');
ylabel('Y1');

subplot(2,2,2)
plot(TOUT,Y(:,2));
hold on;
plot([t_stab t_stab],[0 y_stab(2)],'m');
grid on;
title('Y2, us = 4');
xlabel('t');
ylabel('Y2');

subplot(2,2,3);
plot(TOUT,HOUT(:,1));
hold on;
grid on;
title('H1, us = 4');
xlabel('t');
ylabel('H1');

subplot(2,2,4)
plot(TOUT,HOUT(:,2));
hold on;
grid on;
title('H2, us = 4');
xlabel('t');
ylabel('H2');

%skok jednostkowy
t_skoku = t_stab;
skok = 0;
liczba_chwil = 20000;
[TOUT HOUT] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
Y = [HOUT(:,1)*0.068 + ones(size(HOUT,1),1)*0.5116 , HOUT(:,2)*0.0883 + ones(size(HOUT,1),1)*0.6066];
for i = ind_stab:size(Y,1)-1
    if abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
        t_stab_skok = TOUT(i); %czas ustabilizowania
        ind_stab_skok = i;
        y_stab_skok = Y(i,:);
        break;
    end
end
disp(['Czas ustabilizowania po skoku jednostkowym dla us=' num2str(us) ': ' num2str(t_stab_skok) ' na y1=' num2str(Y(ind_stab,1)) ' i na y2=' num2str(Y(ind_stab,2))]);

T = [0 0];
%wyznaczenie wzmocnienia, stalej czasowej i opoznienia
K = (y_stab_skok - y_stab) / (1);
for i = ind_stab:ind_stab_skok
    if Y(i,1)-y_stab(1) <= (1-1/exp(1))*(y_stab_skok(1)-y_stab(1)) && Y(i+1,1)-y_stab(1) > (1-1/exp(1))*(y_stab_skok(1)-y_stab(1))
        T(1) = TOUT(i) - t_skoku;
    end
    if Y(i,2)-y_stab(2) <= (1-1/exp(1))*(y_stab_skok(2)-y_stab(2)) && Y(i+1,2)-y_stab(2) > (1-1/exp(1))*(y_stab_skok(2)-y_stab(2))
        T(2) = TOUT(i) - t_skoku;
    end
end
tau1 = 0;
tau2 = 0;
for i = ind_stab:ind_stab_skok
    if abs(Y(i,1)-Y(ind_stab-1,1)) > 0.00001
       tau1 = i -  ind_stab;
       break;
    end
end
for i = ind_stab:ind_stab_skok
    if abs(Y(i,2)-Y(ind_stab-1,2)) > 0.00001
       tau2 = i -  ind_stab;
       break;
    end
end
disp(['Wzmocnienie K1=' num2str(K(1)) ', K2=' num2str(K(2))]);
disp(['Stala czasowa T1=' num2str(T(1)) ', T2=' num2str(T(2))]);
disp(['Opoznienie tau1=' num2str(tau1) ', tau2=' num2str(tau2)]);

figure;
subplot(2,1,1);
plot(TOUT,HOUT(:,1));
grid on;
title('H1, us = 4');
xlabel('t');
ylabel('H1');

subplot(2,1,2)
plot(TOUT,HOUT(:,2));
grid on;
title('H2, us = 4');
xlabel('t');
ylabel('H2');


figure;
subplot(2,1,1);
plot(TOUT,Y(:,1));
hold on;
%rysunek modelu
T_model = TOUT(ind_stab:end);
y1_model = K(1)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T(1)))+y_stab(1);
plot(T_model,y1_model,'m');
grid on;
title(['Y1, us = 4, T=' num2str(T(1)) ', K=' num2str(K(1)) ', tau=' num2str(tau1)]);
xlabel('t');
ylabel('Y1');

subplot(2,1,2)
plot(TOUT,Y(:,2));
hold on;
%rysunek modelu
y2_model = K(2)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T(2)))+y_stab(2);
plot(T_model,y2_model,'m');
grid on;
title(['Y2, us = 4, T=' num2str(T(2)) ', K=' num2str(K(2)) ', tau=' num2str(tau2)]);
xlabel('t');
ylabel('Y2');

%blad sredniokwadratowy dla Y1
mse_y1 = mean((Y(ind_stab:end,1) - y1_model).^2);
%blad sredniokwadratowy dla Y2
mse_y2 = mean((Y(ind_stab:end,2) - y2_model).^2);
disp(['Blad sredniokwadratowy dla Y1: ' num2str(mse_y1)]);
disp(['Blad sredniokwadratowy dla Y2: ' num2str(mse_y2)]);
