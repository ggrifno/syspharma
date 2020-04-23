function [V1CQ, V2CQ, V1DCQ, V2DCQ, CL_CQ, CL_DCQ, KA] = Chloroquine_popPK(Weights)

[row, col] = size(Weights); %takes in the size of the weights matrix, which should be the 
%number of patients (listed by weight) for each sex (M versus F)
med = median(Weights); %we will need this for the 

%initialize matricies to hold calculated values
V1CQ   = zeros(row, col);
V2CQ   = zeros(row, col);
V1DCQ  = zeros(row, col);
V2DCQ  = zeros(row, col);
CL_CQ  = zeros(row, col);
CL_DCQ = zeros(row, col);
KA     = zeros(row, col);

%typical reported values for population
f0    = 1; % bioavailability, from Hoglund et al. Malar J (2016)
f     = (1.14-0.67).*rand(row,col) + 0.67; %randomly select a bioavailablility of CQ from the range 67% to 114% (drugbank)
v1_cq = 468; %L, from Hoglund et al. Malar J (2016)
v2_cq = 1600;%L, from Hoglund et al. Malar J (2016)

v1_dcq = 2.27;   %L, from Hoglund et al. Malar J (2016)
v2_dcq = 566257; %L, from Hoglund et al. Malar J (2016)

CHF = 10.7; %units = days, half-life CQ
DHF = 8.74; %units = days, half-life DCQ

kcl_cq = log(2)/(CHF*24); % units hr-1? also written as k10, in L/hr
kcl_dcq= log(2)/(DHF*24); % units hr-1? also written as k30, in L/hr

ka = 0.155; %units = hr-1? alanna, how did you calculate this?
theta1 = 1; % Volume, fractional change in this parameter with each kg change in BW from median BW
theta2 = 0.75; % Clearance, fractional change in this parameter with each kg change in BW from median BW

%generate matrices of random variables to add interindividual
%variability to parameters (ALL DUMMY FOR NOW, taken from HW4, scenario 4)
%this is to add "NOISE" to the data???? unsure...
nV1 = normrnd(0,0.1,[row,col]);
nV2 = normrnd(0,0.1,[row,col]);
nCL_CQ = normrnd(0,0.1,[row,col]);
nCL_DCQ = normrnd(0,0.1,[row,col]);

    for i = 1:2
        for j = 1:row %calculate each of the variables for each patient (patient number (j,i) in "Weights")
            %first conception of formulas (modeled after HW4 scenario 4)
                %we are using an allometric rule for compartment volumes
               V1CQ(j,i) = v1_cq * ((Weights(j,i) / med(i))^theta1) * exp (nV1(j,i));
               V2CQ(j,i) = v2_cq * ((Weights(j,i) / med(i))^theta2) * exp (nV2(j,i));
               
               V1DCQ(j,i)= v1_dcq* ((Weights(j,i) / med(i))^theta1) * exp (nV1(j,i));
               V2DCQ(j,i)= v2_dcq* ((Weights(j,i) / med(i))^theta2) * exp (nV2(j,i));
               
               %can we add noise to the clearance rates directly?
%                CL_CQ(j,i) =  kcl_cq* exp (nCL_CQ(j,i)); 
%                CL_DCQ(j,i) = kcl_dcq* exp (nCL_DCQ(j,i));

                %probably a better idea to add variance to the halflife?
                popCHF = 10.7* exp (nCL_CQ(j,i)); %units = days, half-life CQ
                popDHF = 8.74* exp (nCL_DCQ(j,i)); %units = days, half-life DCQ

               KA(j,i) = ka; %NEED TO FIND CONNECTION BETWEEN KA AND VARIABILITY

        end
    end
    
end
