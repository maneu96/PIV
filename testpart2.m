%% Loads
load calib_asus.mat
I1= imread('rgb_0000.jpg');
I2= imread('rgb_0001.jpg');

%H_12=estimate_homografy(single(rgb2gray(I1)),single(rgb2gray(I2)));
%print_Homografy(H_12,single(rgb2gray(I1)),single(rgb2gray(I2)));

%% feature detection
%Feature 1 ID
[f1,d1] = vl_sift(single(rgb2gray(I1))) ;
%Feature 2 ID
[f2,d2] = vl_sift(single(rgb2gray(I2))) ;
[matches, scores] = vl_ubcmatch(d1, d2) ;

%% Calculate 3d coordinates of features
load depth_0000.mat
points_1= f1(1:2,matches(1,:)) ;
depth_array(isnan(depth_array))=0;
xyz_I1= position3(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_array,floor(points_1));

load depth_0001.mat
depth_array(isnan(depth_array))=0;
points_2=f2(1:2,matches(2,:));
xyz_I2= position3(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_array,floor(points_2));

%centroid calculations
c_1=nanmean(xyz_I1,2);
c_2=nanmean(xyz_I2,2);
%pushing the centroids to the origin
xyz_I1=bsxfun(@(a,b) a-b,xyz_I1,c_1);
xyz_I2=bsxfun(@(a,b) a-b,xyz_I2,c_2);
%remove nan from data
xyz_I1(:,~all(~isnan(xyz_I1)))=[];
xyz_I2(:,~all(~isnan(xyz_I2)))=[];


E=xyz_I2*(xyz_I1)';

[U,S,V]=svd(E);
R=V*U';
t=c_1-R*c_2;

H= [R t;0 0 0 1];
%% Show point clouds
load depth_0000.mat
depth_array(isnan(depth_array))=0;
 pc1=point_cloud(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_array);
 pc1.Color=reshape(I1,[],3);
 showPointCloud(pc1);
 figure;
 load depth_0001.mat
 depth_array(isnan(depth_array))=0;
 pc2=point_cloud(Depth_cam.K,RGB_cam.K,R_d_to_rgb,T_d_to_rgb,depth_array);
 pc2.Color=reshape(I2,[],3);
 showPointCloud(pc2);
% 
% %estimate 3d transformation between Point Clouds
% 
% %meanA=nanmean(pc1.Location);
% %meanB=nanmean(pc2.Location);
%   H_2=pcregrigid(pc2,pc1);
%   H_2=H_2.T';
