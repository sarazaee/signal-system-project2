function [black_and_white] = mybinaryfun(gray_image, treshHold)

WB = zeros(300,500);

for i = 1:300
    for j = 1:500
        if gray_image(i,j) < treshHold
            WB(i,j) = 0;
        else
            WB(i,j) = 1;
        end
    end
end
black_and_white = ~WB;
figure(2);
imshow(black_and_white);

end