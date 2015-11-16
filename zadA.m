% close all;

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

% %parametry zmienne
% us = 1.8;
% skok = -1;
% t_skoku = 0;
% liczba_chwil = 10000;
% %end init
% 
% % wyznaczenie punktu pracy
% OPTIONS = odeset('MaxStep',10);
% [T H] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
% Y = [H(:,1)*0.068 + ones(size(H,1),1)*0.5116 , H(:,2)*0.0883 + ones(size(H,1),1)*0.6066];
% for i = 1:size(Y,1)-1
%     if T(i)>10 && abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
%         t_stab = T(i); %czas ustabilizowania
%         ind_stab = i;
%         y_stab = Y(i,:);
%         break;
%     end
% end
% 
% %skok jednostkowy
% t_skoku = t_stab;
% skok = 0;
% [T H] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
% Y = [H(:,1)*0.068 + ones(size(H,1),1)*0.5116 , H(:,2)*0.0883 + ones(size(H,1),1)*0.6066];
% for i = ind_stab:size(Y,1)-1
%     if abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
%         t_stab_skok = T(i) %czas ustabilizowania
%         ind_stab_skok = i;
%         y_stab_skok = Y(i,:);
%         break;
%     end
% end
% 
% 
% %wyznaczenie wzmocnienia, stalej czasowej i opoznienia
% K = (y_stab_skok - y_stab) / (1);
% for i = ind_stab:ind_stab_skok
%     if Y(i,1) <= (1-1/exp(1))*y_stab_skok(1) && Y(i+1,1) > (1-1/exp(1))*y_stab_skok(1)
%         T1 = T(i) - t_skoku;
%     end
%     if Y(i,2) <= (1-1/exp(1))*y_stab_skok(2) && Y(i+1,2) > (1-1/exp(1))*y_stab_skok(2)
%         T2 = T(i) - t_skoku;
%     end
% end
% tau1 = 0;
% tau2 = 0;
% for i = ind_stab:ind_stab_skok
%     if abs(Y(i,1)-Y(ind_stab-1,1)) > 0.00001
%        tau1 = i -  ind_stab;
%        break;
%     end
% end
% for i = ind_stab:ind_stab_skok
%     if abs(Y(i,2)-Y(ind_stab-1,2)) > 0.00001
%        tau2 = i -  ind_stab;
%        break;
%     end
% end
% tau1
% tau2
% 
% figure;
% subplot(2,1,1);
% plot(T,H(:,1));
% grid on;
% title('H1, us = 1.8');
% 
% subplot(2,1,2)
% plot(T,H(:,2));
% grid on;
% title('H2, us = 1.8');
% 
% figure;
% subplot(2,1,1);
% plot(T,Y(:,1));
% hold on;
% %rysunek modelu
% T_model = T(ind_stab:end);
% y1_model = K(1)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T1))+y_stab(1);
% plot(T_model,y1_model,'m');
% 
% grid on;
% title('Y1, us = 1.8');
% % 
% subplot(2,1,2)
% plot(T,Y(:,2));
% hold on;
% %rysunek modelu
% y2_model = K(2)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T2))+y_stab(2);
% plot(T_model,y2_model,'m');
% 
% grid on;
% title('Y2, us = 1.8');
% 
% % ************************************* %
% %                 us = 4                %
% % ************************************* %

%parametry zmienne
us = 4;
skok = -1;
t_skoku = 0;
liczba_chwil = 20000;
%end init

% wyznaczenie punktu pracy
OPTIONS = odeset('MaxStep',10);
[T H] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
Y = [H(:,1)*0.068 + ones(size(H,1),1)*0.5116 , H(:,2)*0.0883 + ones(size(H,1),1)*0.6066];
for i = 1:size(Y,1)-1
    if T(i)>10 && abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
        t_stab = T(i); %czas ustabilizowania
        ind_stab = i;
        y_stab = Y(i,:);
        break;
    end
end

%skok jednostkowy
t_skoku = t_stab;
skok = 0;
[T H] = ode45(@obiektReg,[0 liczba_chwil],[0 0],OPTIONS);
Y = [H(:,1)*0.068 + ones(size(H,1),1)*0.5116 , H(:,2)*0.0883 + ones(size(H,1),1)*0.6066];
for i = ind_stab:size(Y,1)-1
    if abs(Y(i,1)-Y(i+1,1)) < 0.00001 && abs(Y(i,2)-Y(i+1,2)) < 0.00001
        t_stab_skok = T(i) %czas ustabilizowania
        ind_stab_skok = i;
        y_stab_skok = Y(i,:);
        break;
    end
end


%wyznaczenie wzmocnienia, stalej czasowej i opoznienia
K = (y_stab_skok - y_stab) / (1);
for i = ind_stab:ind_stab_skok
    if Y(i,1) <= (1-1/exp(1))*y_stab_skok(1) && Y(i+1,1) > (1-1/exp(1))*y_stab_skok(1)
        T1 = T(i) - t_skoku
    end
    if Y(i,2) <= (1-1/exp(1))*y_stab_skok(2) && Y(i+1,2) > (1-1/exp(1))*y_stab_skok(2)
        T2 = T(i) - t_skoku
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
tau1
tau2

figure;
subplot(2,1,1);
plot(T,H(:,1));
grid on;
title('H1, us = 4');

subplot(2,1,2)
plot(T,H(:,2));
grid on;
title('H2, us = 4');


figure;
subplot(2,1,1);
plot(T,Y(:,1));
hold on;
%rysunek modelu
T_model = T(ind_stab:end);
y1_model = K(1)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T1))+y_stab(1);
plot(T_model,y1_model,'m');

grid on;
title(['Y1, us = 4, T=' num2str(T1) ', K=' num2str(K(1))]);
% 
subplot(2,1,2)
plot(T,Y(:,2));
hold on;
%rysunek modelu
y2_model = K(2)*(1)*(1-exp(1).^(-(T_model-t_skoku)/T2))+y_stab(2);
plot(T_model,y2_model,'m');

grid on;
title(['Y2, us = 4, T=' num2str(T2) ', K=' num2str(K(2))]);
