function ICrecognition(icImage, pcbImage)



if ndims(icImage) == 3
    icImage = rgb2gray(icImage);
end
if ndims(pcbImage) == 3
    pcbImage = rgb2gray(pcbImage);
end


template = icImage;
templateRot = imrotate(template, 180);


[ht, wt] = size(template);


corr0  = normxcorr2(template, pcbImage);
corr180 = normxcorr2(templateRot, pcbImage);

threshold = 0.7;


[y0, x0] = find(corr0 >= threshold);
[y180, x180] = find(corr180 >= threshold);


figure;
imshow(pcbImage);
hold on;


for i = 1:length(x0)
    xTopLeft = x0(i) - wt;
    yTopLeft = y0(i) - ht;

    rectangle('Position', [xTopLeft, yTopLeft, wt, ht], ...
        'EdgeColor', 'b', 'LineWidth', 2);
end


for i = 1:length(x180)
    xTopLeft = x180(i) - wt;
    yTopLeft = y180(i) - ht;

    rectangle('Position', [xTopLeft, yTopLeft, wt, ht], ...
        'EdgeColor', 'r', 'LineWidth', 2);
end

end


