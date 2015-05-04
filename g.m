function [ out ] = g( fs, p, theta )
%g weak classifier
    % Input:
        % fs, vector containing the value of a particular feature
            % extracted from each training image
        % p = {-1, 1}
        % theta = (p, theta)
    % Output:
        % out, -1 or 1

     out = p .* fs < p * theta;
     out = double(out);
     out(out == 0) = -1;
end

