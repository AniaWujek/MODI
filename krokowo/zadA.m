% close all;

global alfa1 beta Umin alfa2 g

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
y_mnoznik = [0.068 0 ;0 0.0883];
y_dodane = [0.5116 0.6066];

%parametry zmienne
us = 1.8;
H_HIST = [0 0]; % [h1 h2]
Y_HIST = [0*0.068+0.5116 0*0.0883+0.6066]; %[y1 y2]
skok = 0;
punkt_pracy = 0;
%end init

h_stab_przed = [0 0]; %ustabilizowany h przed skokiem
t_stab_przed = 0;
y_stab_przed = 0;
h_stab = [0 0]; %ustabilizowany h po skoku jednostkowym
t_stab = 0;
y_stab = 0;


liczba_chwil = 10000;
for t = 1:liczba_chwil
    dh = obiekt(H_HIST(t,:),us);
    H_HIST(t+1,:) = H_HIST(t,:)+dh';
    Y_HIST(t+1,:) = H_HIST(t+1,:)*y_mnoznik + y_dodane;
    if skok == 0 && abs(H_HIST(t+1,1)-H_HIST(t,1))<0.0001 && abs(H_HIST(t+1,2)-H_HIST(t,2))<0.0001
        skok = 1;
        us = us+1;
        h_stab_przed = H_HIST(t+1,:)
        t_stab_przed = t+1;
        y_stab_przed = Y_HIST(t+1,:);
    elseif skok == 1 && punkt_pracy == 0 && abs(H_HIST(t+1,1)-H_HIST(t,1))<0.0001 && abs(H_HIST(t+1,2)-H_HIST(t,2))<0.0001
        h_stab = H_HIST(t+1,:)
        t_stab = t+1;
        punkt_pracy = 1;
        y_stab = Y_HIST(t+1,:);
    end
end

KH = (h_stab - h_stab_przed) / (1);
disp('wzmocnienie H:');
KH

KY = (h_stab*y_mnoznik+y_dodane - (h_stab_przed*y_mnoznik+y_dodane)) / (1);
disp('wzmocnienie Y:');
KY

TH1 = 0;
for t = t_stab_przed:t_stab
    if H_HIST(t,1)-h_stab_przed(1) < 0.63*(h_stab(1)-h_stab_przed(1)) && H_HIST(t+1,1)-h_stab_przed(1) >= 0.63*(h_stab(1)-h_stab_przed(1))
        TH1 = t+1-t_stab_przed;
        break;
    end
end
TH2 = 0;
for t = t_stab_przed:t_stab
    if H_HIST(t,2)-h_stab_przed(2) < 0.63*(h_stab(2)-h_stab_przed(2)) && H_HIST(t+1,2)-h_stab_przed(2) >= 0.63*(h_stab(2)-h_stab_przed(2))
        TH2 = t+1-t_stab_przed;
        break;
    end
end
TH1
TH2

tau1 = 0;
tau2 = 0;
for i = t_stab_przed:t_stab
    if abs(Y_HIST(i,1)-Y_HIST(t_stab_przed-1,1)) > 0.0001
       tau1 = i -  t_stab_przed;
       break;
    end
end
for i = t_stab_przed:t_stab
    if abs(Y_HIST(i,2)-Y_HIST(t_stab_przed-1,2)) > 0.0001
       tau2 = i -  t_stab_przed;
       break;
    end
end

figure;
subplot(2,1,1);
plot(H_HIST(:,1));
hold on;
plot([t_stab_przed t_stab_przed],[0 20],'r');
%rysunek modelu
t_lin = linspace(t_stab_przed,10000,10000-t_stab_przed);
h_lin = KH(1)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH1))+h_stab_przed(1);
plot(t_lin,h_lin,'m');
%
grid on;
title('H1, us = 1.8');

subplot(2,1,2)
plot(H_HIST(:,2));
hold on;
plot([t_stab_przed t_stab_przed],[0 20],'r');
%rysunek modelu
h_lin = KH(2)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH2))+h_stab_przed(2);
plot(t_lin,h_lin,'m');
%
grid on;
title('H2, us = 1.8');

figure;
subplot(2,1,1);
plot(Y_HIST(:,1));
hold on;
%rysunek modelu
y_lin = KY(1)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH1))+y_stab_przed(1);
plot(t_lin,y_lin,'m');
%
grid on;
title(['krokowo Y1, us = 1.8, T=' num2str(TH1) ', K=' num2str(KY(1)) ', tau=' num2str(tau1)]);

subplot(2,1,2)
plot(Y_HIST(:,2));
hold on;
%rysunek modelu
y_lin = KY(2)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH2))+y_stab_przed(2);
plot(t_lin,y_lin,'m');
%
grid on;
title(['krokowo Y2, us = 1.8, T=' num2str(TH2) ', K=' num2str(KY(2)) ', tau=' num2str(tau2)]);

% ************************************* %
%                 us = 4                %
% ************************************* %
%parametry zmienne
us = 4;
H_HIST = [0 0]; % [h1 h2]
Y_HIST = [0*0.068+0.5116 0*0.0883+0.6066]; %[y1 y2]
skok = 0;
punkt_pracy = 0;
%end init

h_stab_przed = [0 0]; %ustabilizowany h przed skokiem
t_stab_przed = 0;
y_stab_przed = 0;
h_stab = [0 0]; %ustabilizowany h po skoku jednostkowym
t_stab = 0;
y_stab = 0;


liczba_chwil = 20000;
for t = 1:liczba_chwil
    dh = obiekt(H_HIST(t,:),us);
    H_HIST(t+1,:) = H_HIST(t,:)+dh';
    Y_HIST(t+1,:) = H_HIST(t+1,:)*y_mnoznik + y_dodane;
    if skok == 0 && abs(H_HIST(t+1,1)-H_HIST(t,1))<0.0001 && abs(H_HIST(t+1,2)-H_HIST(t,2))<0.0001
        skok = 1;
        us = us+1;
        h_stab_przed = H_HIST(t+1,:)
        t_stab_przed = t+1;
        y_stab_przed = Y_HIST(t+1,:);
    elseif skok == 1 && punkt_pracy == 0 && abs(H_HIST(t+1,1)-H_HIST(t,1))<0.0001 && abs(H_HIST(t+1,2)-H_HIST(t,2))<0.0001
        h_stab = H_HIST(t+1,:)
        t_stab = t+1;
        punkt_pracy = 1;
        y_stab = Y_HIST(t+1,:);
    end
end

KH = (h_stab - h_stab_przed) / (1);
disp('wzmocnienie H:');
KH

KY = (h_stab*y_mnoznik+y_dodane - (h_stab_przed*y_mnoznik+y_dodane)) / (1);
disp('wzmocnienie Y:');
KY

TH1 = 0;
for t = t_stab_przed:t_stab
    if H_HIST(t,1)-h_stab_przed(1) < 0.63*(h_stab(1)-h_stab_przed(1)) && H_HIST(t+1,1)-h_stab_przed(1) >= 0.63*(h_stab(1)-h_stab_przed(1))
        TH1 = t+1-t_stab_przed;
        break;
    end
end
TH2 = 0;
for t = t_stab_przed:t_stab
    if H_HIST(t,2)-h_stab_przed(2) < 0.63*(h_stab(2)-h_stab_przed(2)) && H_HIST(t+1,2)-h_stab_przed(2) >= 0.63*(h_stab(2)-h_stab_przed(2))
        TH2 = t+1-t_stab_przed;
        break;
    end
end
TH1
TH2

tau1 = 0;
tau2 = 0;
for i = t_stab_przed:t_stab
    if abs(Y_HIST(i,1)-Y_HIST(t_stab_przed-1,1)) > 0.0001
       tau1 = i -  t_stab_przed;
       break;
    end
end
for i = t_stab_przed:t_stab
    if abs(Y_HIST(i,2)-Y_HIST(t_stab_przed-1,2)) > 0.0001
       tau2 = i -  t_stab_przed;
       break;
    end
end

figure;
subplot(2,1,1);
plot(H_HIST(:,1));
hold on;
plot([t_stab_przed t_stab_przed],[0 20],'r');
%rysunek modelu
t_lin = linspace(t_stab_przed,20000,20000-t_stab_przed);
h_lin = KH(1)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH1))+h_stab_przed(1);
plot(t_lin,h_lin,'m');
%
grid on;
title('H1, us = 4');

subplot(2,1,2)
plot(H_HIST(:,2));
hold on;
plot([t_stab_przed t_stab_przed],[0 20],'r');
%rysunek modelu
h_lin = KH(2)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH2))+h_stab_przed(2);
plot(t_lin,h_lin,'m');
%
grid on;
title('H2, us = 4');

figure;
subplot(2,1,1);
plot(Y_HIST(:,1));
hold on;
%rysunek modelu
y_lin = KY(1)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH1))+y_stab_przed(1);
plot(t_lin,y_lin,'m');
%
grid on;
title(['krokowo Y1, us = 4, T=' num2str(TH1) ', K=' num2str(KY(1)) ', tau=' num2str(tau1)]);

subplot(2,1,2)
plot(Y_HIST(:,2));
hold on;
%rysunek modelu
y_lin = KY(2)*(1)*(1-exp(1).^(-(t_lin-t_stab_przed)/TH2))+y_stab_przed(2);
plot(t_lin,y_lin,'m');
%
grid on;
title(['krokowo Y1, us = 4, T=' num2str(TH2) ', K=' num2str(KY(2)) ', tau=' num2str(tau2)]);
