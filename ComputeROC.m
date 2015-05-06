function [ thresh ] = ComputeROC( Cparams, Tdata )
%ComputeROC, plots the ROC curve
    % Output: a threshhold value where true positive rate > 70%
    thresh = NaN;
    
    test_inds = setdiff(1:size(Tdata.ii_ims, 2), Tdata.train_inds);
    nrIms = size(test_inds, 2);
    scores = zeros(1, nrIms);
    for i = 1 : nrIms
        scores(i) = ApplyDetector(Cparams, Tdata.all_ii_ims(:, test_inds(i)));
    end
    
    ys = [ones(1, Tdata.nrFaces) -ones(1, Tdata.nrNFaces)];
    ys = ys(:, test_inds);
    
    % try different thetas
    thresh_interval = min(scores):0.00001:max(scores);
    x = zeros(1, size(thresh_interval, 2));
    y = zeros(1, size(thresh_interval, 2));
    
    for z = 1 : size(thresh_interval, 2)
        theta = thresh_interval(z);
        tp = 0; fp = 0; tn = 0; fn = 0;
        for i = 1 : size(scores, 2)
           if scores(i) > theta
               prediction = 1;
           else
               prediction = -1;
           end

           label = ys(i);
           if label == prediction
              if prediction == 1
                  tp = tp + 1;
              else
                  tn = tn + 1;
              end
           else
              if prediction == 1
                  fp = fp + 1;
              else
                  fn = fn + 1;
              end
           end
        end
       
       tpr = tp / (tp + fn);
       fpr = fp / (tn + fp);
       
       if (tpr - 0.7) < 0.0001 && isnan(thresh)
          thresh = theta;
       end
        
       x(z) = fpr;
       y(z) = tpr;
    end
    plot(x, y, 'r-');
    title('ROC curve')
    xlabel('fpr')
    ylabel('tpr')
end

