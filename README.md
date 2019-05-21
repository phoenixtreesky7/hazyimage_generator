# hazyimage_generator

This is a matlab code for hazy image generating.

This code has two functions compared with other hazy image generating method.

Firstly, it can generate hazy image no matter you have depth map or transmission map, just by setting "trans = 0" (depth) or "trans = 1" (transmission).

Additionally, it can generate one hazy image with a pair of hazefree image and depth/transmission map by seting "total_number = 1". Also, if you want generate several hazy images with different depth/transmission maps while under the same hazefree image, you can set "total_number = n".
