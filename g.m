function [ out ] = g( fs, p, theta )
%g weak classifier
    % Input:
        % fs, vector containing the value of a particular feature
            % extracted from each training image
        % p = {-1, 1}
        % theta = (p, theta)
    % Output:
        % out, -1 or 1
        
    if p .* fs < p .* theta
       out = 1; 
    else
       out = -1; 
    end
end

