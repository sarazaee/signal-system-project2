function [gray_image] = mygrayfun(RGB_image)

gray = zeros(300,500);

for i = 1:300
    for j = 1:500
        gray(i,j) = 0.299*RGB_image(i,j,1) + 0.587*RGB_image(i,j,2) + 0.114*RGB_image(i , j , 3);
    end
end
gray_image = gray/255;
figure(1);
imshow(gray_image);