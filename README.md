# hazyimage_generator


This is Matlab code for hazy image generating.

This code has two functions compared with other hazy image generating method.

Firstly, it can generate a hazy image no matter you have a depth map or transmission map, just by setting "trans = 0" (depth) or "trans = 1" (transmission).

Additionally, it can generate one hazy image with a pair of haze-free image and depth/transmission map by setting "total_number = 1". Also, if you want to generate several hazy images with different depth/transmission maps while under the same haze-free image, you can set "total_number = n".
