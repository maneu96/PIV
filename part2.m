function [ transforms, objects ] = part2( imglistdepth,imglistrgb,cam_params )
%PARTE2 Summary of this function goes here
%inputs : imglistdepth -> Cell array with strings indicating the path of each depth image
%         imglistrgb   -> Cell array with strings indicating the path of each rgb image
%         cam_params   -> Struct with instrinsic and extrinsic camera parameters.
%                         cam_params.Kdepth  - the 3x3 matrix for the intrinsic parameters for depth
%                         cam_params.Krgb - the 3x3 matrix for the intrinsic parameters for rgb
%                         cam_params.R - the Rotation matrix from depth to RGB (extrinsic params)
%                         cam_params.T - The translation from depth to RGB
%This is also like you did in the lab, except that everything is in one structure. For example,
%cam_params.R should be Rdtorgb that you use in the lab
%outputs : transforms  -> 
%                         transfomrs{i}.R - the 3x3  roation matrix between image i  and image 1
%                         transforms{i}.T - the 3x1 translation vector  between image i and image 1 mW.T

H=estimate_homografy(imglistrgb(1),imglistrgb(2));

end

