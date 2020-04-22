function [V1, V2, CL_DCQ, CL_DCQ, KA] = Chloroquine_popPK(Weights, CaseFlag)

[row, col] = size(Weights); %takes in the size of the weights matrix, which should be the 
%number of patients (listed by weight) for each sex (M versus F)

switch CaseFlag %use the passed-in case flag to decide which scenario to run
    
case 1 %MALARIA
        %generate a matrix of random variable 
    nV1 = normrnd(0,0.17,[row,col]);
    nCL_CQ = normrnd(0,0.38,[row,col]);
    nCL_DCQ = normrnd(0,0.38,[row,col]);
    V1 = zeros(row, col);
    V2 = zeros(row, col);
    CL_CQ = zeros(row, col);
    CL_DCQ = zeros(row, col);
    for i = 1:2
        for j = 1:row
               patient = Weights(j,i);
               v1 = 24.2 * ((patient / 70)^0.45) * exp (nV1(j,i));
               v2 = 32.3 *  patient / 70;
               kcl_cq = 0.117 * exp (nCL_CQ(j,i)); 
               kcl_dcq = 0.117 * exp (nCL_DCQ(j,i));
               ka = 0.117 * exp (nCL_DCQ(j,i));
               %add on the new volumes and clearances to the matrix
               V1(j,i) = v1;
               V2(j,i) = v2;
               CL_CQ(j,i) = kcl_cq; 
               CL_DCQ(j,i) = kcl_dcq;
               KA(j,i) = ka;
        end

    end

    
    
case 2 %COVID-19
    %TBD...
    
end
end
