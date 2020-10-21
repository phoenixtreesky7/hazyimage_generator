# hazyimage_generator

Thank you very much for your comment.
The motivations behind the proposed PGC block are as follows:
First, it has been proved that the global context was beneficial to most image processing tasks; the same was to dehazing (as illustrated in Fig. 1. Corresponding discussions are given in the fourth paragraph in Section I, on page 2 of the manuscript). Thus, we use a light-weight network, namely Global Context (GC) block \cite{cao2019gcnet}, to achieve the global context modeling. Second, the distribution of haze is constant in a local patch. Thus patch-wise context dependencies should be more appreciated in image dehazing.
From the above two facts, we propose a Pyramid Global Context (PGC) block, which is derived from the GC block undergoing a spatial pyramid pooling \cite{he2015spatial, zhao2017pspnet, lazebnik2006beyond}, which can thereby exploit long-range dependencies among both points and patches.

This is Matlab code for hazy image generating.
This code has two functions compared with other hazy image generating method.
Firstly, it can generate a hazy image no matter you have a depth map or transmission map, just by setting "trans = 0" (depth) or "trans = 1" (transmission).
Additionally, it can generate one hazy image with a pair of haze-free image and depth/transmission map by setting "total_number = 1". Also, if you want to generate several hazy images with different depth/transmission maps while under the same haze-free image, you can set "total_number = n".
