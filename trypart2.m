for i=0:7
    imglistrgb{i+1}=sprintf('rgb_000%d.jpg',i);
    imglistdepth{i+1}=sprintf('depth_000%d.mat',i);
end
load calib_asus.mat
cam_params.Kdepth = Depth_cam.K;
cam_params.Krgb =RGB_cam.K ;
cam_params.R = R_d_to_rgb;
cam_params.T = T_d_to_rgb;
[H_i1,~]=part2(imglistdepth,imglistrgb,cam_params);


I1=imread(imglistrgb{1});
load(imglistdepth{1});
depth_1=depth_array;
depth_1(isnan(depth_1))=0;
pc=point_cloud(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_1);
pc.Color=reshape(I1,[],3);
for i =2:7
I2=imread(imglistrgb{i});
load(imglistdepth{i});
depth_2=depth_array;
depth_2(isnan(depth_2))=0;
Tform=affine3d(H_i1{i}');
pc2=point_cloud(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_2);
pc2.Color=reshape(I2,[],3);
pc2=pctransform(pc2,Tform);
pc=pcmerge(pc,pc2,0.000001);
end