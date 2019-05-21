
% This is a Matlab code to generate hazy image
%
% Dong Zhao, Long Xu, Yihua Yan, Jie Chen, Lingyu Duan
% 2018.07.23


close all
clear all
clc


path_cleanimage = 'F:\1_MyWork\GitHub\hazyimage_generator\clean_image\';  % your path of the clean image
path_cleantrans = 'F:\1_MyWork\GitHub\hazyimage_generator\depth_map\' % your path of the transmission map or depth map

path_thickness = 'F:\1_MyWork\GitHub\hazyimage_generator\generate_trans\';  % your path of the generated transmission map or depth map
path_hazyimage = 'F:\1_MyWork\GitHub\hazyimage_generator\generate_hazy\'; % your path of the generated hazy image


if ~exist(path_thickness)
    mkdir(path_thickness);
end
if ~exist(path_hazyimage)
    mkdir(path_hazyimage);
end


%%  Image Reading
imgDataDir  = dir(path_cleanimage);
for ifile = 1 : 4
    if (isequal(imgDataDir(ifile).name, '.')||...
            isequal(imgDataDir(ifile).name, '..')||...
            imgDataDir(ifile).isdir)
        continue;
    end
    image_clean_name = dir([path_cleanimage '*.png']);
end

imgDataDir  = dir(path_cleantrans);
for ifile = 1 : 4
    if (isequal(imgDataDir(ifile).name, '.')||...
            isequal(imgDataDir(ifile).name, '..')||...
            imgDataDir(ifile).isdir)
        continue;
    end
    image_trans_name = dir([path_cleantrans '*.bmp']);
end
length_clean_image = size(image_clean_name, 1);
length_clean_thickness = size(image_trans_name, 1);

%% Parameters Setting
para.gaussian_window = [15, 15];
para.gaussian_delta = 5;
Gau_kernel = fspecial('gaussian', [para.gaussian_window], para.gaussian_delta);
%% !! NOTE : 
%% IF you want to generate one hazy image with one pair of haze-free image and depth/transmission map, total_number = 1; 
%% ELSE IF you want to generate several hazy images with different depth/transmission maps under the same haze-free image, total_number = n.

total_number = 1;
crop_size = 1024;
trans = 0;   % if you give the depth map, trans = 0; else if you give the transmission map , set trans = 1
%% iders Dehazing
for pic = 1 : 1 : length_clean_image
    pic
    picj = pic;   % picj = ceil(length_clean_image * rand(1))
    
    image_clean = im2double(imread(strcat(path_cleanimage, image_clean_name(picj).name)));
    [image_clean_h, image_clean_w, image_clean_c] = size(image_clean);
    
    for thic = 1 : 1 : total_number
        if total_number > 1
            pict = ceil(length_clean_thickness * rand(1));
        else
            pict = picj;
        end
        
        beta = 1 + 3 * rand(1);
        image_thickness_pro = rgb2gray(im2double(imread(strcat(path_cleantrans, image_trans_name(pict).name))));
        image_thickness = imresize(image_thickness_pro, [image_clean_h, image_clean_w], 'lanczos3');
        image_thickness = imfilter(image_thickness, Gau_kernel, 'symmetric') * beta;
        if ~trans
            image_trans_resize = exp(-image_thickness);
        else
            image_trans_resize = image_thickness;
        end
        if image_clean_c == 3
            A(1) = 0.8 + 0.2 * rand(1);
            A(2) = 0.8 + 0.2 * rand(1);
            A(3) = 0.8 + 0.2 * rand(1);
            for channle = 1 : image_clean_c
                image_hazy(:, :, channle) = image_clean(:, :, channle) .* image_trans_resize + A(channle) * (1 - image_trans_resize);
            end
        else
            A(1) = 0.8 + 0.4 * rand(1);
            image_hazy = image_clean .* image_trans_resize + A(1) * (1 - image_trans_resize);
        end
        
        
        saveName = [path_hazyimage 'train_I_' (image_clean_name(picj).name(1 : end - 4) ) '_' num2str(picj, '%06d') '_' num2str(pict, '%06d')  '.png']
        imwrite(imresize(image_hazy, [crop_size, crop_size], 'lanczos3') , saveName);
        saveName = [path_thickness 'train_d_' (image_clean_name(picj).name(1 : end - 4) ) '_' num2str(picj, '%06d') '_' num2str(pict, '%06d')  '.png']
        imwrite(imresize(image_thickness, [crop_size, crop_size], 'lanczos3'), saveName);
        
    end
    clear image_thickness_pro
    clear image_thickness
    clear image_trans_resize
    
    clear image_hazy
    clear image_clean
end
