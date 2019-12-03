function print_Homografy(H,I1,I2)
%print_Homografy 
%   Prints 2D homografy from I1 to I2
%   Inputs :  H  = Transformation matrix 1->2
%             I1 = Image 1
%             I2 = Image 2
figure
imagesc(I2);
U_max = length(I2(1,:));
V_max = length(I2(:,1));
I2_H = zeros(V_max,U_max);
%I2_H=I2;
for V = 1:V_max
    for U = 1:U_max
        omega =H*[U;V;1];
        U_l=omega(1)/omega(3);
        V_l=omega(2)/omega(3);
        if (U_l> 0 && V_l>0 && V_l< V_max && U_l< U_max )   
           I2_H(round(V_l) + 1,round(U_l) + 1)=I1(V,U);
%         else
%            I2_H(round(omega(2)/omega(3)) + 1,round(omega(1)/omega(3)) + 1)= I2(V,U);
        end
    end
end
figure
imagesc(I2_H);
end

