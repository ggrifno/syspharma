function [peakCQmat, AUCmat] = Global_sensitivity(PatientsData, ObservationTime, dose_vector, CQclear_vector)

%function for outputting data needed for global sensitivity analysis for
%both Malaria and COVID-19

%timeframe = look at the time when you would expect the peak concentration
%to occur

% p = parameters needed for cholorquine simulation, THESE WILL START OUT A
% LITTLE DIFFERENT FOR EACH PATIENT
% p = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka]; %JUST TO REMEMBER WHERE EVERYTHING IS
% ObservationTime = timeframe over which to run the CQ diffeq simulation
% dose vector = range of doses to check
% halflifevector = range of CQ halflives to check



%% Simulation COPIED FROM MAIN FUNCTION
% PatientsData = [WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs];

WeightVal = PatientsData(:,1);
SexLabels = PatientsData(:,2); %this will likely go unused
v1cq      = PatientsData(:,3);
v2cq      = PatientsData(:,4);
v1dcq     = PatientsData(:,5);
v2dcq     = PatientsData(:,6);
K10       = PatientsData(:,7); %clearance of cholorquine will be REWRITTEN for the global sensitivity analysis
K30       = PatientsData(:,8);
kabs      = PatientsData(:,9);

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
    ptemp = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka];
    [ytemp, time] = Chloroquine_sim(W, ptemp, DosingRegimen, FirstDosing, OtherDosing, MissedDose);
    Time = time;
    YCQCentral = [YCQCentral, ytemp(:,1)];
    YDQCentral = [YDQCentral, ytemp(:,2)];
    ytemp = []; %keeping this but you shouldn't need to "clear" ytemp each time. It'll get redefined in the next cycle when you call the simulation
end

AUCCQ = trapz(Time,YCQCentral);
AUCDCQ = trapz(Time,YDQCentral);

numDoses = length(dose_vector);
numHalflife = length(CQclear_vector);

peakCQmat = zeros(length(numDoses, numHalflife)); %collect the peak CQ matrix
AUCmat = zeros(length(numDoses, numHalflife)); 

for dose = 1: numDoses
    for halflife = 1: numHalflife
        [Yout, Tout] = Chloroquine_sim(weight, ptemp, DosingRegimen, FirstDosing, OtherDosing, MissedDose);
        
    end
end

%steps to get data

%1. get the CQ concentrations for EACH patient, for each of the dose and
%CQ clearance conditions

%2. find the maximum (peak) concentration for EACH patient over each
%condition. save that concentrationin peakCQ matrix

%3. collect the AUC for each patient (can do that in this function) under
%each dose condition and SAVE in AUCmat

