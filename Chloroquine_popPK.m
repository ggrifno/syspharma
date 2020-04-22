function [V1, V2, CL_CQ, CL_DCQ, KA] = Chloroquine_popPK(Weights, CaseFlag)

[row, col] = size(Weights); %takes in the size of the weights matrix, which should be the 
%number of patients (listed by weight) for each sex (M versus F)

switch CaseFlag %use the passed-in case flag to decide which scenario to run
    
case 1 %MALARIA
    %generate matrices of random variables to add interindividual
    %variability to parameters (ALL DUMMY FOR NOW, taken from HW4, scenario 4)
    nV1 = normrnd(0,0.17,[row,col]);
    nCL_CQ = normrnd(0,0.38,[row,col]);
    nCL_DCQ = normrnd(0,0.38,[row,col]);
    %generate a matrices of random variables 
    V1 = zeros(row, col);
    V2 = zeros(row, col);
    CL_CQ = zeros(row, col);
    CL_DCQ = zeros(row, col);
    KA = zeros(row, col);
    for i = 1:2
        for j = 1:row %calculate each of the variables for each patient (patient number (j,i) in "Weights")
            %formulas are ALL DUMMY FOR NOW, taken from HW4, scenario 4
               V1(j,i) = 24.2 * ((Weights(j,i) / 70)^0.45) * exp (nV1(j,i));
               V2(j,i) = 32.3 *  Weights(j,i) / 70;
               CL_CQ(j,i) = 0.117 * exp (nCL_CQ(j,i)); 
               CL_DCQ(j,i) = 0.117 * exp (nCL_DCQ(j,i));
               KA(j,i) = 0.117 * exp (nCL_DCQ(j,i));

        end
    end
    
case 2 %COVID-19
    %TBD...
    
end
end
