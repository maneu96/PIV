load calib_asus.mat
I1= imread('rgb_0000.jpg');
I2= imread('rgb_0001.jpg');

%H_12=estimate_homografy(single(rgb2gray(I1)),single(rgb2gray(I2)));
%print_Homografy(H_12,single(rgb2gray(I1)),single(rgb2gray(I2)));
load depth_0000.mat
pc1=point_cloud(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_array);
pc1.Color=reshape(I1,[],3);
showPointCloud(pc1);
figure
load depth_0001.mat
pc2=point_cloud(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_array);
pc2.Color=reshape(I2,[],3);
showPointCloud(pc2);