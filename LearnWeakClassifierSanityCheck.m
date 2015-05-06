function [ ] = LearnWeakClassifierSanityCheck( Tdata )
    fmat = Tdata.fmat;
    ys = Tdata.ys;
    ii_ims = Tdata.ii_ims;
    fs = fmat(12028, :) * ii_ims;
    ws = ones(1, size(fs, 2)) / size(fs, 2);
    [ theta, p, err ] = LearnWeakClassifier( ws, fs, ys );
    
    % Should be around -3.7698
    %p
    %theta
    if ~(p == 1 && abs(theta - -3.7698) < 0.2)   
        msg = '[Fail] (Task II: LearnWeakClassifier Sanity Check)';
        error(msg);
    else
       disp('[Success] (Task II: LearnWeakClassifier Sanity check)'); 
    end
end

