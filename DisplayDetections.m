function [ ] = DisplayDetections( im, dets )

    figure
    imagesc(im);
    axis equal
    hold on
    
    for i = 1:size(dets, 1)
       r = rectangle('Position', dets(i, :));
       set(r, 'EdgeColor' ,'r');
    end
end

