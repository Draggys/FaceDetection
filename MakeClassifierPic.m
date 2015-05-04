function [ cpic ] = MakeClassifierPic( all_ftypes, chosen_f, alphas, ps, W, H )
%MakeClassifierPic display function for the strong classifier        
    cpic = zeros(size(H, W));
    w = alphas .* ps;
    for i = 1 : size(chosen_f, 2)
       fpic = MakeFeaturePic(all_ftypes(chosen_f(i), :), W, H) .* w(i);
       cpic = cpic + fpic;
    end
end

