clear all ; close all;

%% Partie 1.1 Définition du système G(p) sous Matlab

p = tf('p');

%Déclaration des constantes

%Q3
k1=0.02; %°C/sV
tau1=2000; %s

G = k1/(p*(1+tau1*p));

% Partie 1.2 : Analyse du système G(p)

%Q4
p1 = pole(G);
z1 = zero(G);

% Le système possède 2 poles : [0; 5e-04] et aucun zéro, le système est
% marginalement stable

%Q5
gain = dcgain(G);
% en G(0) le gain est infini, G n'a pas de gain statique fini.

%Alimenter le four avec 6V revient Entree V(t)=6*u(t) avec u(t) la fonction echelon unitaire
%Si on alimente le four avec entrée v(t) = 6V, la température grimperait
%très rapidement et dépassera notre cahier des charges à 1400°C

%Q6
% figure(1);
% step(6*G);
% grid on;
% 
% title('Réponse indicielle de G(p) pour une entrée echelon avec amplitude 6V');
% xlabel('Temps');
% ylabel('Augmentation de température (°C)');


%% Partie 1.3 :
% Utilisation d'un capteur de température et analyse de fonction H(p)
p = tf('p');
%déclaration de constante
tau2=2; %s
K2=5e-3; %V/°C

%Q7

H=K2/(1+tau2*p);

%Q8

p2 = pole(H);
z2 = zero(H);
%Il y a un pôle réel négatif p0=-0.5, le système est donc stable

%Q9

% figure(2);
% step(H);
% grid on;
% 
% title('Réponse indicielle de H(p)');
% xlabel('Temps');
% ylabel('Tension u(t) (Volt)')

GainH = dcgain(H);
%=0.005

p3=pole(H*G*(1/p));
p4=pole(K2*G);

%Le temps de réponse à 5%
%d'un système du premier ordre vaut approximativement 3*tau, dans notre
%cas tr5% de H est de 6s On le vérifie graphiquement


%Q14 , Q15 , Q16
Kp=1;                                  %
Fbf=minreal(K2* (Kp*G)/(1+Kp*G*K2));

figure(3);
step(Fbf); hold on;
step(1-Fbf); hold on;
% xstep= [-5000 0 1 2.5*10^4];
% ystep = [0 1 1 1];
% plot(xstep, ystep, 'green'); hold on;
step(tf(1));                          %pas causal
grid on;

title('Réponse indicielle de Fbf');
xlabel('Temps');
ylabel('Augmentation de température (°C)');


%Q17
t = 0:1:300;                      

figure(4); clf;
impulse(Fbf/p^2, t); hold on;      % sortie
impulse(1/p^2, t); hold on;              % rampe d'entrée
grid on;
legend('Sortie \theta(t)', 'Rampe d''entrée', 'Location', 'northwest');
title('Réponse de Fbf à une rampe');
xlabel('Temps (s)'); ylabel('Température (°C)');


%Q18
figure(5); clf;
step(1200*Fbf); hold on;      % sortie
grid on;
legend('Sortie \theta(t) (°C)', 'Rampe d''entrée', 'Location', 'northwest');
title('Réponse de Fbf à un échelon de 1200');
xlabel('Temps (s)'); ylabel('Température (°C)');