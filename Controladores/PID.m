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

%% Realimentação unitária negativa
G1 = G/(G+1)

%% Transformação de Theta em distância
G2 = G*r

%% Wn e Zeta
Wn = sqrt(5.479e-07)
Zeta = (1.585e-4)/(2*Wn)

%% Realimentação unitária negativa
G3 = G2/(G2+1)

%% Precisamos de um ganho de menor que 9.4084e-4
K_c = 1e-5

%% Gannho proporcional para transformar em um sistema de 2 ordem superamortecido
Pb = 8e-1
Ir = 1e-5
Dt = 2e4

%% Se can menor que 1, então é factível
can = 4*Dt*Ir

%% Controlador PID
C = (100/Pb)*(s^2*Dt + s + Ir)/s


