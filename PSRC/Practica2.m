%% Práctica II. PSRC
clc;
clear all;

%% Inicializaciones
Ts = 1/1e6;
Doppler = 40;
N = 10^6;

%% Diseño SISO.
h = rayleighchan(Ts, Doppler);
h.StorePathGains = 1;

a = ones(1,N);
H = filter(h,a);
h_siso_eq = abs(H.^2);

figure()
histogram(h_siso_eq,'Normalization','pdf')

%% MISO 4x1
%Diseñar un canal rayleigh.
h_miso = zeros(4,N);
a1 = ones(1,N);

for i = 1:4
    h1 = rayleighchan(Ts, Doppler);
    h1.StorePathGains = 1;
    h_miso(i,:) = filter(h1,a1);
end

%MRC
for j = 1:N
   h_miso_eq(1,j) =h_miso(:,j)' * h_miso(:,j);
end

figure()
histogram(h_miso_eq, 'Normalization','pdf')

%% SIMO 1x4

%% MIMO 4x4

h_mimo = zeros(16,N);
a2 = ones(1,N);

for i = 1:16
    h2 = rayleighchan(Ts, Doppler);
    h2.StorePathGains = 1;
    h_mimo(i,:) = filter(h2,a2);
end

for k = 1:N
   matrix = vec2mat(transpose(h_mimo(:,k)),4);
   [U,S,V] = svd(matrix);
   h_mimo1(k) = U(:,1)' * S * V(:,1);
end
%h_mimo_eq = h_mimo(1) + h_mimo(2) + h_mimo(3) + h_mimo(4);
h_mimo_eq = abs(h_mimo1.^2);

figure()
histogram(h_mimo_eq, 'Normalization','pdf')

%% MIMO 4x4 (1/4 de potencia)
