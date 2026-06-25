[file,path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s = [path,file];

picture = imread(s);
picture = imresize(picture,[300 500]);

gray_image = mygrayfun(picture);

wb = mybinaryfun(gray_image, 0.3); % tresh hold must be some value between 0 and 1, otherwise the output is not the thing that we expected. 

clean_image = myremoveobject(wb, 500);


[L , Ne] = mysegmentation(clean_image);

propied=regionprops(L,'BoundingBox');
hold on
for n=1:Ne
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

load TRAININGSET;
totalLetters=size(TRAIN,2);



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
        ro(k)=corr2(TRAIN{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=cell2mat(TRAIN(2,pos));       
        final_output=[final_output out];
    end
    
    
end



file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')