function [ H ] = estimate_homografy( I1,I2 )
%estimate_homografy Estimate transformation matrix between image 1 and 2
%   Detailed explanation goes here
%Feature 1 ID
[f1,d1] = vl_sift(I1) ;
%Feature 2 ID
[f2,d2] = vl_sift(I2) ;

%% feature matching
[matches, scores] = vl_ubcmatch(d1, d2) ;
% matches (1, :)  == vector de indices dos matches na imagem 1
% matches (2, :)  == vector de indices dos matches na imagem 2
% f1 ou f2 (1, :) == vector de posicoes U das features nas imagens
% f1 ou f2 (1, :) == vector de posicoes V das features nas imagens
%showMatchedFeatures(I1,I2,f1(1:2,matches(1,end/2:2:end))',f2(1:2,matches(2,end/2:2:end))','montage');
matchedpoints1= f1(1:2,matches(1,:));
matchedpoints2= f2(1:2,matches(2,:));
[H,~,~]=estimateGeometricTransform(matchedpoints1',matchedpoints2','projective');
H=H.T';
end

