function [Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_LocalSensi(WeightVal, v1cq, v2cq, v1dcq, v2dcq, K10, K30,kabs, DosingRegimen, FirstDosing, OtherDosing, MissedDose, sensiVar, PercentChange)
%function for running chloroquine simulation

% p is the vector holding all the inputted values for parameters except for
% volumes and clearances
% p = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka];


%% Simulation
YCQCentral = []; YDQCentral= []; Time = [];
for i = 1:length(WeightVal) %iterates through both male and female, since WeightVal melts them into one vector
    W = WeightVal(i); %current patient you're looking at
    %patient's volumes of distribution
    v1 = v1cq(i); v2 = v2cq(i);
    v3 = v1dcq(i); v4 = v2dcq(i);
    %set patient's infusion and intercompartmental conversion rates (CONSTANT FOR ALL PATIENTS, apart from volume correction)
    q = 0;           % infusion rate is always 0 because CQ is administered orally
    k12 = 37.7/v1;   % units = L/h, Chloroquine from central to peripheral
    k21 = 37.7/v2;   % units = L/h, chloroquine from peripheral to central
    k23 = 6.13/v1;   % units = L/H , CQ transforming to DCQ
    k34 = 31.46/v3;  % units = L/h, DCQ from central to peripheral
    k43 = 31.46/v4;  % units = L/h, DCQ from peripheral to central
    %patient's clearance rates
    k10 = K10(i); k30 = K30(i);
    %patient's absorption
    ka = kabs(i);

    ptemp = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka]; %we have all our parameters for the current patient!
    ptemp(sensiVar) = ptemp(sensiVar)*PercentChange; % now that all the parameters are set, vary ONE in the list by a set percentage
    %input the CHANGED PTEMP SLIGHTLY TO REFLECT SENSITIVITY ANALYSIS FOR EACH PARAMETER, FOR EACH PATIENT
    [ytemp, time] = Chloroquine_sim(W, ptemp, DosingRegimen, FirstDosing, OtherDosing, MissedDose);
    Time = time;
    YCQCentral = [YCQCentral, ytemp(:,1)];
    YDQCentral = [YDQCentral, ytemp(:,2)];
end

AUCCQ = trapz(Time,YCQCentral);
AUCDCQ = trapz(Time,YDQCentral);

end
