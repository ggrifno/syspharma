function [V1CQ, V2CQ, V1DCQ, V2DCQ, CL_CQ, CL_DCQ, KA] = Chloroquine_popPK(Weights)

[row, col] = size(Weights); %takes in the size of the weights matrix, which should be the 
%number of patients (listed by weight) for each sex (M versus F)
med = median(Weights); %we will need this for calculating individual compartment volumes with bodyweight allometric model

%initialize matricies to hold calculated values
V1CQ   = zeros(row, col);
V2CQ   = zeros(row, col);
V1DCQ  = zeros(row, col);
V2DCQ  = zeros(row, col);
CL_CQ  = zeros(row, col);
CL_DCQ = zeros(row, col);
KA     = zeros(row, col);

%typical value reported for the whole population (from paper)
f    = 1; % typical bioavailability is 100%, from Hoglund et al. Malar J (2016)
v1_cq = 468; %L, from Hoglund et al. Malar J (2016)
v2_cq = 1600;%L, from Hoglund et al. Malar J (2016)

v1_dcq = 2.27;   %L, from Hoglund et al. Malar J (2016)
v2_dcq = 566257; %L, from Hoglund et al. Malar J (2016)

CHF = 10.7; %units = days, half-life CQ
DHF = 8.74; %units = days, half-life DCQ

kcl_cq = log(2)/(CHF*24); % units hr-1? also written as k10, in L/hr
kcl_dcq= log(2)/(DHF*24); % units hr-1? also written as k30, in L/hr

ka = 0.155;    % units = hr-1?
theta1 = 1;    % fractional change in volume with each kg change in BW from median BW (from Hoglund et al. Malar J (2016))
theta2 = 0.75; % fractional change in clearance with each kg change in BW from median BW (from Hoglund et al. Malar J (2016))

%generate matrices of random variables to add interindividual variability
%to parameters that is NOT explained by bodyweight variability
%this is to add "NOISE" to the data???? Current "noise" levels are unjustified
nV1 = normrnd(0,0.1,[row,col]);
nV2 = normrnd(0,0.1,[row,col]);
nCL_CQ = normrnd(0,0.1,[row,col]);
nCL_DCQ = normrnd(0,0.1,[row,col]);
nka = normrnd(0,0.1,[row,col]);

%% Start the calculations for variables that have variability from person to person

for i = 1:2 %go through each of the 2 sexes in Weights matrix
    for j = 1:row %calculate each of the variables for each patient (patient number (j,i) in "Weights")
        %ADDING VARIABILITY TO WEIGHTS
        %we are using an allometric rule for compartment volumes
        V1CQ(j,i) = v1_cq * ((Weights(j,i) / med(i))^theta1) * exp (nV1(j,i));
        V2CQ(j,i) = v2_cq * ((Weights(j,i) / med(i))^theta2) * exp (nV2(j,i));

        V1DCQ(j,i)= v1_dcq* ((Weights(j,i) / med(i))^theta1) * exp (nV1(j,i));
        V2DCQ(j,i)= v2_dcq* ((Weights(j,i) / med(i))^theta2) * exp (nV2(j,i));

        %ADD VARIABILITY TO CQ AND DCQ HALFLIVES
        %Although uncertain if this method of adding variance is correct
        popCHF = CHF* exp (nCL_CQ(j,i)); %units = days, half-life CQ
        popDHF = DHF* exp (nCL_DCQ(j,i)); %units = days, half-life DCQ
        CL_CQ(j,i) =  log(2)/(popCHF*24); %converted units to h-1 by multiplying halflife in days by 24hr/day
        CL_DCQ(j,i) = log(2)/(popDHF*24); %converted units to h-1 by multiplying halflife in days by 24hr/day
        
        %ADD VARIABILITY TO CQ ABOSORPTION RATE FROM THE GUT
        %add variance to absorption rate, we're using gaussian noise
        KA(j,i) = ka*exp(nka(j,i));

    end
end
    
end
