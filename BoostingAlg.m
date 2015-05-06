function [ Cparams ] = BoostingAlg( Tdata, T )
%BoostingAlg the boosting algorithm
    % Input: 
        % Tdata, trraining data
        % T, the number of weak classifiers
    % Output:
        % Cparams, a struct containing: alphas, Thetas, fmat, all_ftypes
            
    fs = Tdata.fmat * Tdata.ii_ims;
   
    m = sum(Tdata.ys == -1);
    n = size(Tdata.ys, 2);
    
    % init weights
    w = zeros(1, size(Tdata.ys, 2));
    for i = 1 : size(Tdata.ys, 2)
        if Tdata.ys(i) == -1
           w(i) = 1 / (2 * m); 
        else
           w(i) = 1 / (2 * (n - m));
        end
    end
    
    Thetas = zeros(T, 3);
    alphas = zeros(T, 1);
    % for each classifier
    
    for t = 1 : T
        w = w / sum(w);
        
        bestErr = NaN;
        % train the weak classifier for each feature j
        for j = 1 : size(fs, 1)
            [theta, p, err] = LearnWeakClassifier(w, fs(j, :), Tdata.ys);
            
            % Same as err from LearnWeakClassifier..
            % err = 0.5 * sum(w .* abs(g(fs(j, :), p, theta) - Tdata.ys));
           
            if isnan(bestErr) || err <= bestErr
               bestErr = err;
               bestP = p;
               bestTheta = theta;
               bestJ = j;
            end
        end
        
        alphas(t) = 0.5 * log((1-bestErr) / bestErr);
       w = w .* exp(-alphas(t) .* Tdata.ys .* g(fs(bestJ, :), bestP, bestTheta));
       %w = w .* exp(-alphas(t) * Tdata.ys .* ((bestP * fs(bestJ, :) < bestP * bestTheta) * 2 -1));
        
        Thetas(t, 1) = bestJ; % denotes the index of fs
        Thetas(t, 2) = bestTheta;
        Thetas(t, 3) = bestP;
    end
    
%     disp('------------------------------------------------------')
%     Thetas(:)
%     alphas
    Cparams = struct('alphas', alphas, 'Thetas', Thetas, 'fmat', Tdata.fmat, 'all_ftypes', Tdata.all_ftypes);
end
