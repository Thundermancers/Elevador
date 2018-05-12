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
h = r

G2 = G*h

%% Sistema não compensado
Polo_dominante = -7.92 * 10^(-5) + 1 * 10^(-4)*i
Ganho = 0.0297
Damping = 0.621
Overshot = 8.28
Freq = 0.000128

Ts_NC = 4/abs(real(Polo_dominante)) %% tempo de subida

tetha = rad2deg( angle(Polo_dominante) ) - 90

Ts_C = 20
alpha_C = 4/20
imag_C = alpha_C / tan(tetha) 

zero_C = 0.2
polo = -0.2 - imag_C * i
P = pi + angle(polo+zero_C) - 2 * angle(polo)
P = 360 - rad2deg(P)


%%%%%

polo_C = alpha_C/tan(deg2rad(P)) + 0.2
k_C = 7.37 * 10^5

Compensador = K_c*(s+zero_C)/(s+polo_C)