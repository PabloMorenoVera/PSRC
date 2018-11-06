function h_snr = genera_canal(N,SNR_av,M)
%Toma como argumentos de entrada Longitud y SNR_med y num usuarios
h_c=(1/sqrt(2))*(randn(M,N)+1j*randn(M,N));
for m=1:M
    h_c=sqrt(SNR_av(m))*h_c(m,:);
end
h_snr=abs(h_c).^2;
end
