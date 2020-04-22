function [V1CQ, V2CQ, V1DCQ, V2DCQ, CL_CQ, CL_DCQ, KA] = Chloroquine_popPK(Weights)

[row, col] = size(Weights); %takes in the size of the weights matrix, which should be the 
%number of patients (listed by weight) for each sex (M versus F)
med = median(Weights);

%initialize matricies to hold calculated values
V1CQ = zeros(row, col);
V2CQ = zeros(row, col);
V1DCQ = zeros(row, col);
V2DCQ = zeros(row, col);
CL_CQ = zeros(row, col);
CL_DCQ = zeros(row, col);
KA = zeros(row, col);

%typical reported values for population

v1_cq = 468; %L, from Hoglund et al. Malar J (2016)
v2_cq = 1600;%L, from Hoglund et al. Malar J (2016)

v1_dcq = 2.27;   %L, from Hoglund et al. Malar J (2016)
v2_dcq = 566257; %L, from Hoglund et al. Malar J (2016)

kcl_dcq = 0.0027; %hr-1
kcl_cq = ;

kcl_dcq = 0.0027; %hr-1
kcl_cq = ;

ka = ;

%generate matrices of random variables to add interindividual
%variability to parameters (ALL DUMMY FOR NOW, taken from HW4, scenario 4)
nV1 = normrnd(0,0.17,[row,col]);
nV2 = normrnd(0,0.17,[row,col]);
nCL_CQ = normrnd(0,0.38,[row,col]);
nCL_DCQ = normrnd(0,0.38,[row,col]);

    for i = 1:2
        for j = 1:row %calculate each of the variables for each patient (patient number (j,i) in "Weights")
            %first conception of formulas (modeled after HW4 scenario 4)
               V1CQ(j,i) = v1_cq * ((Weights(j,i) / med(i))^theta1) * exp (nV1(j,i));
               V2CQ(j,i) = v2_cq * ((Weights(j,i) / med(i))^theta2) * exp (nV2(j,i));
               
               V1DCQ(j,i)= v1_dcq* ((Weights(j,i) / med(i))^theta1) * exp (nV1(j,i));
               V2DCQ(j,i)= v2_dcq* ((Weights(j,i) / med(i))^theta2) * exp (nV2(j,i));
               
               CL_CQ(j,i) =  kcl_cq* exp (nCL_CQ(j,i)); 
               CL_DCQ(j,i) = kcl_dcq* exp (nCL_DCQ(j,i));
               KA(j,i) = normrnd(0,0.17,[row,col]);

        end
    end
    
end
