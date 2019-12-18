function [ index ] = ransac_3dtransformation(xyz_1,xyz_2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
inliers= zeros(100,length(xyz_1));
threshold=0.5;
for n=1:100
    i_randpoints=randi(length(xyz_1),[1,4])
    A= [];
    Y=[];
    b=1;
    %build the A and Y matrices
    for i = i_randpoints
        A= [A; (xyz_2(:,i))' 1 0 0 0 0 0 0 0 0;
               0 0 0 0 (xyz_2(:,i))' 1 0 0 0 0;
               0 0 0 0 0 0 0 0 (xyz_2(:,i))' 1];
        Y= [Y;(xyz_1(:,i))];
        
    end
    %solve AH=Y
    H= (A^-1)*Y; 
    H = reshape( H,[3,4]); 
    %Calculate this iteration's transformation predicted points in matrix form 
    xyz_H = H(1:3,1:3)*xyz_2 + repmat(H(:,4),[1, length(xyz_1)]);
    
   %Calculate the error matrix
   Error= abs(xyz_H-xyz_1);
   error_norm=sqrt(vec_sqr_sum(Error));
   
   [~,column]=find(error_norm < threshold);
   inliers(n,column)=1
end
pause
%falta descobrir a iteracao mais votada. depois disso � tirar os indices
%dos pontos que votaram para essa iteracao e mand�-los para fora da funcao
votes = sum(inliers,2);
[~,row]=max(votes);

index=find(inliers(row, :));%inliers = index?? not sure if that's what we want

end