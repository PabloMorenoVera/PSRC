function l_sig = actualiza_est_mult(l, h, P_max, p)
    paso = 0.001;

    l_sig=l+ paso*(p - P_max);
    l_sig=max(l,0+.01*rand(1,1));
end