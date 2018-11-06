function p = f_waterfilling( h, l)
%Devuelve un escalar con p_optima
p = 1/l - 1/h;
p = max(0,p);
end