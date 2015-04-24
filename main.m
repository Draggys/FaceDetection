close all;
clear all;
clc;

addpath('Data\TrainingImages\FACES\');

% Debug Point 1
[im, ii_im] = LoadIm('face00001.bmp', 1);
dinfo1 = load('Data\DebugInfo\debuginfo1.mat');
eps = 1e-6;
s1 = sum(abs(dinfo1.im(:) - im(:)) > eps);
s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps);
if ((s1 == 0) && s2 == 0)
    disp('[Success] (Debug Point1): LoadIm is reliable');
else
    msg = '[Fail] (Debug Point1): LoadIm is not reliable';
    error(msg);
end

%Debug Point 2
[W, H] = size(ii_im);
for x = 1 : W
   for y = 1 : H
       for w = 1 : W
          for h = 1 : H
             b_vec = VecBoxSum(x, y, w, h, 19, 19);
             if ~isnan(b_vec)
                 A1 = b_vec * ii_im(:);
                 A2 = sum(sum(im(y:y+h-1, x:x+w-1)));
                 if ~(abs(A1 - A2) < 0.001)
                    msg = ('[Fail] (Debug Point2): VecBoxSum is not reliable'); 
                    error(msg);
                 end
             end
          end
       end
   end
end
disp('[Success] (Debug Point2): VecBoxSum is reliable');