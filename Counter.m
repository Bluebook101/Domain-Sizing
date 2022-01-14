homepath = pwd;
path = 'C:\Users\joesa\Desktop\Domain Sizing';
cd(path);


clearvars;

%Code to load in Red,White,Blue images and count pixels to work out 
%average domain size


%Loading in the image and storing the rgb values as separate matrices
image = im2double(imread('20nm.png'));
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);

%calculating the number of pixels and intialising counter
[row,col] = size(r);
white = 0;
red = 0;
blue = 0;


%Counting the White Cells
for i=1:1:row
    for j=1:1:col
        if (r(i,j)>=0.5) &&  (g(i,j)>=0.5) && (b(i,j)>=0.5)
            white = white+1;
        end
    end 
end
 
%Counting the Red Cells
for i=1:1:row
    for j=1:1:col
        if (r(i,j)>=0.5) &&  (g(i,j)<=0.5) && (b(i,j)<=0.5)
            red = red+1;
        end
    end 
end

%Counting the Blue Cells
for i=1:1:row
    for j=1:1:col
        if (r(i,j)<=0.5) &&  (g(i,j)<=0.5) && (b(i,j)>=0.5)
            blue = blue+1;
        end
    end 
end

total = red + white + blue;
red_percent = 100*red/total;
blue_percent = 100*blue/total;
white_percent = 100*white/total;

%Printing the red, blue and white number of pixels
fprintf('The number of red pixels is %d (%.2f%%)\n', red, red_percent);
fprintf('The number of blue pixels is %d (%.2f%%)\n', blue, blue_percent);
fprintf('The number of white pixels is %d (%.2f%%)\n', white, white_percent);


%Second half of the code for calculating the domain size

%Initialising values for counting
runwidth = 0;
runtot = 0;
num = 0;
w_prev = 0; %0 if not a white pixel, 1 if it is a white pixel


%This nested loop calculates the number width and number of regions in
%the horizontal direction first and vertical direction second.

% %horizontal direction
 for i=1:1:row
     for j=1:1:col
         if (r(i,j)>=0.5) &&  (g(i,j)>=0.5) && (b(i,j)>=0.5) %white pixel
             
             if w_prev == 0 %not a white pixel before
                 num = num+1;
             end
             
             w_prev = 1;
             runtot = runtot + runwidth;
             runwidth = 0; %reset the width
             
         else
             %checks to see if the image has reached the end of the column
             if j == col
               num = num +1; 
             end
             %adds one to the current width calculation
             w_prev = 0;
             runwidth = runwidth +1;
         end        
     end 
 end

%vertical direction
for i=1:1:col
    for j=1:1:row
        if (r(j,i)>=0.5) &&  (g(j,i)>=0.5) && (b(j,i)>=0.5) %white pixel
            
            if w_prev == 0 %not a white pixel before
                num = num+1;
            end
            
            w_prev = 1;
            runtot = runtot + runwidth;
            runwidth = 0; %reset the width
            
        else
            %checks to see if the image has reached the end of the row
            if j == row
               num = num +1; 
            end
            %adds one to the current width calculation
            w_prev = 0;
            runwidth = runwidth +1;
        end        
    end 
end



%average width is total widths divided by the number of sections found
ave = runtot/num;

%thickness calculation based on the image being 800 nm wide
size = (2*ave)/(row+col) * 800;


%output the average domain size
fprintf('The average domain size is %.3f nm.\n', size);
