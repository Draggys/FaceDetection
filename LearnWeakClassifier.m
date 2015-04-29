function [ theta, p, err ] = LearnWeakClassifier( ws, fs, ys )
%LearnWeakClassifier
    % Input:
        % ws, vector of weights associated with each training image
        % fs, vector containing the value of a particular feature
            % extracted from each training image
        % ys, vector of labels associated with each training image
    % Output:
        % theta, threshold
        % p, the learnt parameters of the weak classifier and its associated
        % err, error    
        
    uP = nansum(ws .* fs .* (1 + ys)) / nansum(ws .* (1 + ys));
    uN = nansum(ws .* fs .* (1 - ys)) / nansum(ws .* (1 - ys));

    theta = 0.5 * (uP + uN);
    
    eN = 0.5 * sum(ws .* abs(ys - g(fs, -1, theta)));
    eP = 0.5 * sum(ws .* abs(ys - g(fs, 1, theta)));
    
    if eN < eP
       err = eN;
       p = -1;
    else
       err = eP;
       p = 1;
    end
end

