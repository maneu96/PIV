function [ pc ] = point_cloud( K_Depth,K_rgb,R,T,Depth)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Depth= double(Depth);%/1000;
U = 640;
V = 480;
%U_V_Depth=[1:U; ones(1,U); Depth*ones(1,U)];
% U_V_Depth=[];
% for v=1:V
%     U_V_Depth = [U_V_Depth [(1:U) ; v*ones(1,U); Depth(v,:)]];
% end
aux=1;
for u=1:U
    for v=1:V
        xyz_depth(:,aux) = (Depth(v,u)/1000).*((K_Depth)^-1 *[u ; v ; 1]);
        xyz_rgb(:,aux)   = R*xyz_depth(:,aux) + T;
        aux=aux+1;
    end
end
%C_rgb = K_rgb*[R T];
%xyz_rgb = C_rgb(:,1:3)*xyz + C_rgb(:,4)*ones(1,U*V);
pc=pointCloud(xyz_rgb');

end

