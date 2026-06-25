clc;           
clear;        
close all;  
files=dir('P1_Map Set');
files([1,2])=[];
len=length(files);
TRAIN=cell(2,len);

for i=1:len
   TRAIN{1,i}=imread(['P1_Map Set','\',files(i).name]);
   TRAIN{2,i}=files(i).name(1);
end

save TRAININGSET TRAIN ;

