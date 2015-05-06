function [ scs ] = ApplyDetector( Cparams, ii_ims )  
    fs = Cparams.fmat * ii_ims(:);
    T = size(Cparams.alphas, 1);
    score = 0;
    for t = 1 : T
       score = score + Cparams.alphas(t) * g(fs(Cparams.Thetas(t, 1), :), ...
           Cparams.Thetas(t, 3), Cparams.Thetas(t, 2)); 
    end
    scs = score;
end

