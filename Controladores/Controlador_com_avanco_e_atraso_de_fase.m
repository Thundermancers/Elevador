hold off
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
Gt = N/(s*(s+D))

%% Transformação de Theta em distância
Gh = Gt*r

%% Realimentação unitária
FGh = feedback(Gh,1)
Wn = sqrt(5.479e-7)
Zt = 1.585e-4/(Wn*2)
roots_Fgh = roots([1,1.585e-4,5.479e-7])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Projetando o PD                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Utilizando a técnica Lugar Geométrico das Raízes
%%% As restrições zeta > 1 e Ts aproximadamente 1, permite uma faixa de 
%%% operação com o zeta consecutivamente, o parte imaginária do polo. Por 
%%% este motivo foi escolhido, o polo dominante -1 + 0i.
pause
%%% Para projetar um PD ou Avanço de Fase, é preciso analisar com
%%% malha fechada.
rlocus( FGh ) 
%%% Com o Root Locus percebece-se que não existe um ganho K que torne o
%%% Ts aproximadamente 4, onde Ts = 4/(abs(real(polo_dominante)), assim
%%% deve ser adicioar um PD ou Avançador de Fase, devido que o PD é
%%% inestável, por este motivo será adicionado um avançador de fase. Para 
%%% isso, é preciso adicionar um zero próximo a origem. Desta maneira, foi
%%% escolhido zero em -0.005.
PD_zero = 0.005
%%% Adicionando um polo para finalizar o avançador, porém devesse respeitar
%%% os ângulos para manter o sistema estável. Devido que se terá 1 polo e 1 
%%% zero à direita do polo dominante e ambos tem ângulo 0°, então é preciso
%%% adicionar um polo a esquerda para formar os -180° para estabilidade.
%%% Foi escolhido o polo em -4.
PD_pole = 4
%%% Após tais escolhas, o controlador de forma genérica:
C_PD = (s+PD_zero)/(s+PD_pole)
%%% Foi utilizado o Root Locus afim de obter o ganho para o êxito do projeto.
pause
FCGh = feedback( C_PD * Gh , 1 )
rlocus( FCGh )
%%% Percebesse que o ganho está próximo de 5e6, porém será utilizado um
%%% valor um pouco maior.
PD_K = 6e6
%%% Após estes passos, obtem o controlador PD:
C_PD = PD_K*(s+PD_zero)/(s+PD_pole)
%%% Aplicando a entrada ao degrau:
pause
step( feedback( C_PD * Gh , 1 ) )

%%% Percebe-se um erro no regime permanente assim, é preciso adicionar um
%%% PI ou um Atraso de Fase.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Projetando o PI                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PI_K = 1
PI_zero = 1e-3
PI_polo = 1e-5
C_PI = PI_K*(s+PI_zero)/(s+PI_polo) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Projetando o PDI                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C_PID = C_PD * C_PI 
pause
step( feedback( C_PID * Gh , 1 ) )

%%% Comparação
step( feedback( C_PD * Gh , 1 ) )
hold on
step( feedback( C_PID * Gh , 1 ) )
legend('PD' ,'PDI')
pause
step( feedback( Gh , 1 ) )
legend('PD' , 'PDI' , 'G')