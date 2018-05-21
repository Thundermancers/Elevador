%% Valores encontrados com experimetos
s = tf( [1,0], [1] )

Kt = 0.83*10^(-3)
Ra = 15.15
Kce = 0.09548083941
r = 5 * 10^(-3)
Jm = 0.5

N = Kt/(Ra*Jm)
D = (Kt*Kce)/Jm

%% Função de transferência Theta/Ea
G = N/(s*(s+D))

%% Transformação de Theta em distância
G2 = G*r

%% Gannho proporcional para transformar em um sistema de 2 ordem superamortecido
Pb = 8e-1
Ir = 1e-5
Dt = 2e4

%% Se can menor que 1, então é factível
can = 4*Dt*Ir

%% Controlador PID
C = (100/Pb)*(s^2*Dt + s + Ir)/s
CF = 30e5*(s+0.0000361803)*(s+0.0000138197)/s

%% Controlador físico 1
K_1 = 100
R1C1_1 = 1/0.0000361803
R2C2_1 = 1/0.000138197
C1 = K_1 * (R2C2_1*s + 1) * (R1C1_1*s + 1) / (R2C2_1*s);

%% Controlador físico comercial 1
K_2 = 3e3
R1C1_2 = 1e3 
R2C2_2 = 5e2 
C2 = K_2 * (R2C2_2*s + 1) * (R1C1_2*s + 1) / (R2C2_2*s);

% %% Controlador físico comercial 2
% K_4 = 3
% R1C1_4 = 270 
% R2C2_4 = 720 
% C4 = K_4 * (R2C2_4*s + 1) * (R1C1_4*s + 1) / (R2C2_4*s);
