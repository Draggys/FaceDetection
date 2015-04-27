function [] = VecFeatureSanityCheck( im, ii_im, type)
%VecFeatureSanityCheck a sanity check function for the function VecFeature
%Subtracts white from black in the Viola & Jones system
    eps = 1e-6;
    [W, H] = size(ii_im);
    for x = 1 : W
       for y = 1 : H
           for w = 1 : W
              for h = 1 : H
                 ftype_vec = VecFeature([type, x, y, w, h], 19, 19); % feature type 1 test
                 if isnan(ftype_vec)
                    continue; 
                 end
                 A1 = ii_im(:)' * ftype_vec';
                 if type == 1
                    black = sum(sum(im(y:y+h-1, x:x+w-1)));
                    white = sum(sum(im(y+h:y+2*h-1, x:x+w-1)));
                    A2 = black - white;
                 elseif type == 2
                    black = sum(sum(im(y:y+h-1, x+w:x+2*w-1)));
                    white = sum(sum(im(y:y+h-1, x:x+w-1)));
                    A2 = black - white;
                 elseif type == 3
                    black = sum(sum(im(y:y+h-1, x+w:x+2*w-1)));
                    whiteLeft = sum(sum(im(y:y+h-1, x:x+w-1)));
                    whiteRight = sum(sum(im(y:y+h-1, x+2*w:x+3*w-1)));
                    A2 = black - whiteLeft - whiteRight;
                 elseif type == 4
                    white1 = sum(sum(im(y:y+h-1, x:x+w-1)));
                    white2 = sum(sum(im(y+h:y+2*h-1, x+w:x+2*w-1)));
                    black1 = sum(sum(im(y+h:y+2*h-1, x:x+w-1)));
                    black2 = sum(sum(im(y:y+h-1, x+w:x+2*w-1)));
                    A2 = black1 + black2 - white1 - white2;
                 end
                 if ~(abs(A2 - A1) < eps && abs(A2 - A1) > -eps)
                    msg = (['[Fail] (Debug Point3, Sanity Check): VecFeature is not reliable, feature type: ' num2str(type)]); 
                    error(msg);
                 end
              end
           end
       end
    end
    disp(['[Success] (Debug Point3, Sanity Check): VecFeature is reliable, feature type: ' num2str(type)]);
end

