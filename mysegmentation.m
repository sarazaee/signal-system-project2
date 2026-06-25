function [L , Ne] = mysegmentation(clean_image)

segment = bwconncomp(clean_image,4);

new_segmentation = zeros(300,500);


for i = 1:segment.NumObjects
    new_segmentation(segment.PixelIdxList{i})= i;
end
L = new_segmentation;
Ne = segment.NumObjects;

end

