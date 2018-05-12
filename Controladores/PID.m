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

%% Controlador
C = K_c

%% Gannho proporcional para transformar em um sistema de 2 ordem superamortecido
G4 = C * G2

%% Polo dominante
Polo_dominante = -7.92 * 10^(-5) + 8.67e-6*i
Ganho = 1.16e3
Damping = 0.994
Overshot = 0
Freq = 7.97e-5

%% Calculando Ts
Ts_NC = 4/abs(real(Polo_dominante)) 
tetha = angle(Polo_dominante)
Ts_C = 5
alpha_C = 4/Ts_C
imag_C = alpha_C / tan(tetha)
