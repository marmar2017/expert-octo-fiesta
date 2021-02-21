%% Metalic Pieces %%

clear all
close all
clc

% read the path 
path = path = ".../Image";;
path = strcat(path,'\');

for i=1:21    
    I =imread(strcat(path,'piece', num2str(i),'.bmp'));
    I_bw = im2bw(im2double(I));% for transfer images to black and  wihte
    stas=regionprops(I_bw, 'EulerNumber','Centroid'); % using regionprops function for counting the
    %euler number and Centroid coordinate 
    %adressing struct to get the number of Euler and the centroid 
    EulerNo=[stas.EulerNumber]; 
    centroid=[stas.Centroid];
    %obtaining the value of x and y of the centroid 
    centroidx = centroid(1,1); 
    centroidy = centroid(1,2);
    resMatrix(i,1)=i;% in this matrix we keep the image number that we are reading
 % to discard the images with a number of euler! = - 2 to detect the defective ones
    if EulerNo ==-2 
        %we keep the value of X and Y of the centroid of the (and,or) images in this matrix
       resMatrix(i,2)=centroidx;
       resMatrix(i,3)=centroidy;
       
     % we print the images, the centroid in the same image to know where it is
       % change the value of the centroid to (uint8) to be able to graph it
       figure(i), imshow(I_bw); hold on 
       plot(uint8(centroidx),uint8(centroidy),'Linestyle','none','Marker','*')
       hold on 
       %we find the value of the pixel that is in the same
       %position than the centroid, 1 for class and and 0 for class or
       CentroidVal=I_bw(uint8(centroidy),uint8(centroidx));
       
           
       % we assign the value of 0 to  indicate class or and 1 for
       % indicate class 2 in the resMatrix matrix
       if CentroidVal==0
           resMatrix(i,4)=1;
           title ('OR'); 
          
       else 
           resMatrix(i,4)=2;
           title ('AND')
           
       end
    % if euler! = - 2 so it is Defect
    else
        
        figure(i), imshow(I_bw); title ('Defect');
      
       
    end

   end
class_or = find(resMatrix (:,4)==1 )  
class_and = find(resMatrix (:,4)==2 ) 
class_defects = find(resMatrix (:,4)==0 ) 
%% Methodology 
% 
%for solving this problem i used the regionprops function for counting the
%euler number(number of connected component  - number of holes)for each image 
%and also the Centroid of each image. if pieces have euler number (-2) then
%they should classify as (or, and) otherwise they are Defect.
% for the seperating two classes (and , or) i used the value of Centroid 
%and the fact that the image allways is white 
% and the background is black(holes are in black) 
% so for (or ) based on its shape the value of Centroid is always zero(black) 
% and for (and) is always one(white)
% I used the euler number because it is always rubost to scalong and also
% rotation and is very good signature. and also Center of the region is also
% rubost for the rotation and scaling. so in this case they bothe worked
% well.



