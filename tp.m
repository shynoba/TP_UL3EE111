%%Partie 1 Définition du système G(p) sous Matlab

%Déclaration des constantes

p = tf('p');

K1=0.02; %°C/sV
tau1=2000; %s

G = K1/(p(1+tau1*p));


