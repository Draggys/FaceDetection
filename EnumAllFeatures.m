function [ all_ftypes ] = EnumAllFeatures( W, H )
%EnumAllFeatures enumerates all features
    % Input: width and height of the image
    % Output: a feature matrix of size nf x 5 where nf is the number of
        % features. Each row is of the form, (type, x, y, w, h), where type
        % is a member of the set {1, 2, 3, 4}, corresponding to a feature
        % type.
        
    all_ftypes = zeros(50000, 5);
    i = 1;
    
    % Type 1
    for w = 1 : W - 2
       for h = 1 : floor(H/2) - 2
           for x = 2 : W - w
               for y = 2: H - 2 * h
                   all_ftypes(i, :) = [1, x, y, w, h];
                   i = i + 1;
               end
           end
       end
    end
    
    % Type 2
    for w = 1 : floor(W/2) - 2
       for h = 1 : H - 2
           for x = 2 : W - 2 * w
               for y = 2 : H - h
                   all_ftypes(i, :) = [2, x, y, w, h];
                   i = i + 1;
               end
           end
       end
    end
    
    % Type 3
    for w = 1: floor(W/3) - 2
       for h = 1 : H - 2
           for x = 2 : W - 3 * w
               for y = 2 : H - h
                   all_ftypes(i, :) = [3, x, y, w, h];
                   i = i + 1;
               end
           end
       end
    end
    
    % Type 4
    for w = 1: floor(W/2) - 2
       for h = 1 : floor(H/2) - 2
           for x = 2 : W - 2 * w
               for y = 2 : H - 2 * h
                   all_ftypes(i, :) = [4, x, y, w, h];
                   i = i + 1;
               end
           end
       end
    end
    
    %trim matrix from zeros
    all_ftypes(all_ftypes == 0) = [];
    all_ftypes = reshape(all_ftypes, length(all_ftypes) / 5, 5);
end

