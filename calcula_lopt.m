function l_opt = calcula_lopt(I,P_max, N)
%Calcula iterativamente el multiplicador optimo de Lagrange para un unico usuario
paso = 0.001;
l=zeros(I,1);
l(1)=.01*rand(1,1);
pot_media = zeros(I,1)

for i=1:(I - 1)
    %1. Hay que calcular la potencia media correspondiente al valor del multiplicador
    for n=1:N
        p(n) = f_waterfilling(h(n), l(i));
    end
    pot_media(i) = mean(p)
    %2. Una vez que se tiene, el multiplicador se actualiza
    l(i+1)=l(i)+ paso*(pot_media(l(i)) - P_max);
    %3. Nos aseguramos de que el multiplicador no es negativo (y tampoco le dejamos que llegue a cero)
    l(i+1)=max(l(i+1),0+.01*rand(1,1));
end