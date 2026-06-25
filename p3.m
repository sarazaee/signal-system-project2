[file,path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s = [path,file];

img = imread(s);

imgHSV = rgb2hsv(img);
H = imgHSV(:,:,1);
S = imgHSV(:,:,2);
V = imgHSV(:,:,3);

blueMask = (H > 0.55 & H < 0.75) & (S> 0.4) & (V > 0.2);
blueMask = bwareaopen(blueMask , 50);
CC = bwconncomp(blueMask);
template = imread('bluestrip.png');

scores = zeros(1, CC.NumObjects);

for k = 1:CC.NumObjects
    
    pixels = CC.PixelIdxList{k};
    [r, c] = ind2sub(size(blueMask), pixels);
    
    ymin = min(r); ymax = max(r);
    xmin = min(c); xmax = max(c);

    
    cropImg = img(ymin:ymax, xmin:xmax, :);

    
    cropResized = imresize(cropImg, [size(template,1), size(template,2)]);
    
    tGray = rgb2gray(template);
    cGray = rgb2gray(cropResized);

    
    score = corr2(double(tGray), double(cGray));

    scores(k) = score;

end


[bestScore, bestIdx] = max(scores);


pixels = CC.PixelIdxList{bestIdx};
[r, c] = ind2sub(size(blueMask), pixels);

ymin = min(r); ymax = max(r);
xmin = min(c); xmax = max(c);

figure(1);
subplot(1,2,1);
imshow(img);
hold on;

blueStripBox = [xmin ymin xmax-xmin ymax-ymin];

rectangle('Position', blueStripBox, ...
          'EdgeColor', 'red', ...
          'LineWidth', 2);
hold off;



onlyPelak = img(ymin-20:ymax+20 , xmax:xmax+10*(xmax-xmin) , :);
subplot(1,2,2);

imshow(onlyPelak);

picture = onlyPelak;

picture = imresize(picture,[300 500]);

gray_image = mygrayfun(picture);

wb = mybinaryfun(gray_image, 0.4); % tresh hold must be some value between 0 and 1, otherwise the output is not the thing that we expected. 

clean_image = myremoveobject(wb, 500);


[L , Ne] = mysegmentation(clean_image);

propied=regionprops(L,'BoundingBox');
hold on
for n=1:Ne
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

load TRAININGSETF;
totalLetters=size(TRAINF,2);



final_output=[];
t=[];

for n=1:Ne
    
    if n==7
       saeed=1; 
    end
    
    
    [r,c]=find(L==n);
    Y=clean_image(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[42,24]);
    
    

    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAINF{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=cell2mat(TRAINF(2,pos));       
        final_output=[final_output out];
    end
    
    
end



file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')

