%% Hito 1

%% Apartado b
clear all;

%Generamos el canal
N = 10000; %Numero de instantes
SNR_av = 6; %SNR en unidades naturales
M = 1;   %Numero de usuarios
h = genera_canal(N,SNR_av, M);

%Calculamos el multiplicador 贸ptimo (offline)
I=5000; %Numero maximo de prestaciones
P_max = 0.5;

%Medida de prestaciones para el offline
p = zeros(N,1);
c = zeros(N,1);
lamda = 0.01:0.001:10;
p_med = zeros(length(lamda),1);
c_med = zeros(length(lamda),1);

for l = 1:length(lamda)
    for n=1:N
        p(n) = f_waterfilling(h(n),lamda(l));
        c(n) = log(1 + h(n)*p(n));
    end
    p_med(l) = mean(p);
    c_med(l) = mean(c);
end

figure()
subplot(2,1,1)
semilogy(lamda, p_med)
subplot(2,1,2)
semilogy(lamda, c_med)

disp('Pot media offline')
mean(p_med)
disp('Tasa media offline')
mean(c_med)

%% Apartado c
clear all;
%Generamos el canal
N = 10000; %Numero de instantes
SNR_av = 4; %SNR en unidades naturales
M = 1;   %Numero de usuarios
h = genera_canal(N,SNR_av, M);

%Calculamos el multiplicador 贸ptimo (offline)
I=5000;
%Numero maximo de prestaciones
P_max = 0.5;
[l_opt, l] = calcula_lopt(I,P_max, N, h);

%Medida de prestaciones para el offline
p = zeros(N,1);
for n=1:N
    p(n) = f_waterfilling( h(n), l_opt);
    c(n) = log(1 + h(n)*p(n));
end

disp('Pot media offline')
mean(p)
disp('Tasa media offline')
mean(c)
disp('Valor de lamda')
l(I)
figure()
plot(l)


%%
%Medida de prestaciones para el online
p = zeros(N,1);
c = zeros(N,1);
l = zeros(N,1);
l(1) = 1/P_max;     % Transmites con una potencia peque馻 hasta que vas calculando el lambda 髉timo, 
                    % 
                    porque desde el comienzo est醩 transmitiendo.

for n=1:N
    p(n) = f_waterfilling( h(n), l(n));
    c(n) = log(1 + h(n)*p(n));
    if n<N
        %Si no estamos en el 煤ltimo instante, actualizamos la estimaci贸n
        %del multiplicador para el pr贸ximo instante
        l(n+1) = actualiza_est_mult(l(n),h(n), P_max, p(n));
        %Esta funci贸n hay que codificarla (es muy sencilla)
    end
end
disp('Pot media online')
mean(p)
disp('Tasa media online')
mean(c)
figure()
semilogy(l)
