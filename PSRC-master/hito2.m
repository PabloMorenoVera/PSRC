%% Hito 2

%% Apartado a
M = 3;  %Numero de usuarios
SNR_av = [4,4,2];   %SNR en unidades naturales
lamda = 0.01:0.01:10;
N = 10000; %Numero de instantes

h = genera_canal(N,SNR_av, M);

p = zeros(M,N);
c = zeros(M,N);
p_med = zeros(M,length(lamda));
c_med = zeros(M,length(lamda));

for l = 1:length(lamda)
    for m=1:M
        for n=1:N
            p(m,n) = f_waterfilling(h(m,n),lamda(l));
            c(m,n) = log(1 + h(m,n)*p(m,n));
        end
        p_med(m,l) = mean(p(m));
        c_med(m,l) = mean(c(m));
    end
end
