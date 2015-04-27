function [ output_args ] = VecBoxSumSanityCheck( im, ii_im )
%VecBoxSumSanityCheck a sanity check function for the function VecFeature

    eps = 1e-6;
    [W, H] = size(ii_im);
    for x = 1 : W
       for y = 1 : H
           for w = 1 : W
              for h = 1 : H
                 b_vec = VecBoxSum(x, y, w, h, 19, 19);
                 if ~isnan(b_vec)
                     A1 = b_vec * ii_im(:);
                     A2 = sum(sum(im(y:y+h-1, x:x+w-1)));
                     if ~(abs(A1 - A2) < eps)
                        msg = ('[Fail] (Debug Point2): VecBoxSum is not reliable'); 
                        error(msg);
                     end
                 end
              end
           end
       end
    end
    disp('[Success] (Debug Point2): VecBoxSum is reliable');

end

