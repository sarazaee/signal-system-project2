function [black_and_white] = mybinaryfunF(gray_image, treshHold)

WB = zeros(42,24);

for i = 1:42
    for j = 1:24
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