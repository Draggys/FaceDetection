function [ Cparams ] = BoostingAlg( Tdata, T )
%BoostingAlg the boosting algorithm
    % Input: 
        % Tdata, trraining data
        % T, the number of weak classifiers
    % Output:
        % Cparams, a struct containing: alphas, Thetas, fmat, all_ftypes
            
    fs = Tdata.fmat * Tdata.ii_ims;
    
    n = size(fs, 2);
    m = Tdata.nrNFaces;
    
    % init weights
    w = zeros(1, n);
    for i = 1 : n
       if Tdata.ys(i) == -1
          w(i) = (2 * m)^(-1); 
       else
          w(i) = (2 * (n - m))^(-1);
       end
    end
    
    Thetas = zeros(T, 3);
    alphas = zeros(T, 1);
    for t = 1 : T
        w = w ./ sum(w);
        
        bestErr = NaN;
        % for each feature j train a weak classifier
        % TODO: Change back to length(fs)
        for j = 1 : length(fs)
    %    for j = 1 : 1000
            [theta, p, err] = LearnWeakClassifier(w, fs(j, :), Tdata.ys);
            
            % Same as err from LearnWeakClassifier..
            %err = 0.5 * sum(w .* abs(g(fs(j, :), p, theta) - Tdata.ys));
           
            if isnan(bestErr) || err < bestErr
               bestErr = err;
               bestP = p;
               bestTheta = theta;
               bestJ = j;
            end
        end
        
        alphas(t) = 0.5 * log((1-bestErr) / bestErr);
        w = w .* exp(-alphas(t) .* Tdata.ys .* bestP);
        
        Thetas(t, 1) = bestJ; % denotes the index of fs
        Thetas(t, 2) = bestTheta;
        Thetas(t, 3) = bestP;
    end
    
    alphas
    Cparams = struct('alphas', alphas, 'Thetas', Thetas, 'fmat', Tdata.fmat, 'all_ftypes', Tdata.all_ftypes);
end

