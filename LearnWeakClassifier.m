function [ theta, p, err ] = LearnWeakClassifier( ws, fs, ys, vargin )
%LearnWeakClassifier
    % Input:
        % ws, vector of weights associated with each training image
        % fs, vector containing the value of a particular feature
            % extracted from each training image
        % ys, vector of labels associated with each training image
        % set vargin to nrFaces
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
    
    if nargin == 4
        % Plot histograms
        % divide into faces and non faces
        n = size(fs, 2);
        nrFaces = vargin(1);
        nrNFaces = n - vargin(1);
        fsFaces = fs(1:nrFaces);
        fsNFaces = fs(nrFaces+1:n);
        % create histogram
        [countsF, centersF] = hist(fsFaces);
        [countsN, centersN] = hist(fsNFaces);
        % normalize
        countsF = countsF / nrFaces;
        countsN = countsN / nrNFaces;
        % plotting
        fig1 = figure;
        hold on;
        plot(centersF, countsF);
        plot(centersN, countsN);
        y = 0:0.01:0.45;
        plot(theta * ones(size(y)), y);
        title('Simple Weak Classifier');
        xlabel('feature response');
        ylabel('frequency'); 
    end
end

