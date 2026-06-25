function [clean_image] = myremoveobject(picture, minSize)
cc = bwconncomp(picture,4);
clean_image = zeros(300,500);

for i = 1:cc.NumObjects
    if numel(cc.PixelIdxList{i}) >= minSize
        clean_image(cc.PixelIdxList{i}) = 1;
    end
end
figure(3);
imshow(clean_image);

end