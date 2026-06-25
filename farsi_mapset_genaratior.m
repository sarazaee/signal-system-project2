files = dir('Map set Farsi');
files([1,2]) = [];
len = length(files);
TRAINF = cell(2, len);

for i = 1:len
    
    img = imread(['Map set Farsi','\',files(i).name]);
    
  
    if size(img,3) == 3
        img = rgb2gray(img);
    end
    
   
    img = ~mybinaryfunF(img, 0.4);
    
   
    img = imresize(img, [42, 24]);
    
   
    TRAINF{1,i} = img;
    TRAINF{2,i} = files(i).name(1); 
end

save TRAININGSETF TRAINF;
