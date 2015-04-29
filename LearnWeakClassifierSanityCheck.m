function [ ] = LearnWeakClassifierSanityCheck( Tdata )
    fmat = Tdata.fmat;
    ys = Tdata.ys;
    ii_ims = Tdata.ii_ims;
    fs = fmat(12028, :) * ii_ims;
    ws = rand(1, size(fs, 2));
    ws = ws / norm(ws, 1);
    [ theta, p, err ] = LearnWeakClassifier( ws, fs, ys );
    
    % Should be around -3.7698
    if ~(p == 1 && theta > -3.9 && theta < -3.5)   
        msg = '[Fail] (Task II: LearnWeakClassifier Sanity Check)';
        error(msg);
    else
       disp('[Success] (Task II: LearnWeakClassifier Sanity check)'); 
    end
end

