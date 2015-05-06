function [ ] = SaveTrainingData( all_ftypes, train_inds, s_fn )
%SaveTrainingData computes and saves the training data extracted from face
%and no-face images
    % Input: all_ftypes, all feature types
    %   train_inds, indices of images that will be trained
    %       in other words, ii_ims(:, train_inds)
    %   s_fn, name of file to save to 
    
    W = 19;
    H = 19;
    
    % Read face % non-face images
    faces = LoadImDataDir('Data\TrainingImages\FACES\');
    nfaces = LoadImDataDir('Data\TrainingImages\NFACES\');
    ii_ims = [faces nfaces];
    ii_ims = ii_ims(:, train_inds);
    
    % Ground truth array
    ys = [ones(1, size(faces, 2)) -ones(1, size(nfaces, 2))];
    ys = ys(:, train_inds);
    
    fmat = VecAllFeatures(all_ftypes, W, H);
   
    nrFaces = size(faces, 2);
    nrNFaces = size(nfaces, 2);
    
    save(s_fn, 'ii_ims', 'ys', 'fmat', 'all_ftypes', 'W', 'H', 'nrFaces', 'nrNFaces');
end

