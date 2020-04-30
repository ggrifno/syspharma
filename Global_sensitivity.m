function [peakCQ, peakCQ_mean, timePeak, timePeak_mean] = Global_sensitivity(WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs,DosingRegimen, dose_vector, CQclear_vector)
%function for outputting data needed for global sensitivity analysis for both Malaria and COVID-19

%timeframe = look at the time when you would expect the peak concentration to occur
% p = parameters needed for cholorquine simulation, THESE WILL START OUT A LITTLE DIFFERENT FOR EACH PATIENT
% p = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka]; %JUST TO REMEMBER WHERE EVERYTHING IS
% ObservationTime = timeframe over which to run the CQ diffeq simulation
% dose vector = range of doses to check
% halflifevector = range of CQ halflives to check

%dose_vector has size (number of dose conditions you want to test, (First dose, other dose))
%dose_vector for malaria has 
    %rows: # of dose conditions you want to test (usually 10)
    %columns: first dose, other dose (which are different)
%dose_vector for COVID-19 has 
    %rows: # of dose conditions you want to test (usually 10)
    %columns: first dose, other dose (which are the same)
%CQclear_vector has size (# of clearances to test, 1)
%CQclear_vector has
    %rows: clearance conditions to test (10 conditions)
    %column: only 1 column

%% Simulation COPIED FROM MAIN FUNCTION
% get information for the population (100 patients: 50 males, 50 females)

%Patient-specific inputs are now in the inputs for the function
% PatientsData = [WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs];
% WeightVal = PatientsData(:,1);
% SexLabels = PatientsData(:,2); %this will likely go unused
% v1cq      = PatientsData(:,3);
% v2cq      = PatientsData(:,4);
% v1dcq     = PatientsData(:,5);
% v2dcq     = PatientsData(:,6);
% % K10       = PatientsData(:,7); %clearance of cholorquine will be REWRITTEN for the global sensitivity analysis
% K30       = PatientsData(:,8);
% kabs      = PatientsData(:,9);
FirstDosing = dose_vector(:,1); %should have size 10
OtherDosing = dose_vector(:,2);%should have size 10
MissedDose = 0; %we are not concerned with missing doses for global sensitivity

%initilize variables and matricies
numPatients = length(WeightVal);     %should be 100 patients
numDoses = length(dose_vector(:,1)); %should be 10
numCL = length(CQclear_vector);      %should be 10
numDoses = 10; %should be 10
numCL = 10;      %should be 10

%initialize simulations
YCQCentral = [];
YDQCentral = [];
Time = []; %time vector will always be the same for every simulation

peakCQ = zeros(numDoses, numCL, numPatients); %10x10x100, collect the peak CQ matrix
timePeak = zeros(numDoses, numCL, numPatients); %10x10x100, collect the TIME at which [CQ] peaks

for dose = 1: numDoses %input the dose condition into the simulation
    for clearance = 1: numCL
        for patient = 1:numPatients %iterates through both male and female, since WeightVal melts them into one vector
            W = WeightVal(patient); %current patient you're looking at
            %patient's volumes of distribution
            v1 = v1cq(patient); v2 = v2cq(patient);
            v3 = v1dcq(patient); v4 = v2dcq(patient);
            %set patient's infusion and intercompartmental conversion rates (CONSTANT FOR ALL PATIENTS, apart from volume correction)
            q = 0;           % infusion rate is always 0 because CQ is administered orally
            k12 = 37.7/v1;   % units = L/h, Chloroquine from central to peripheral
            k21 = 37.7/v2;   % units = L/h, chloroquine from peripheral to central
            k23 = 6.13/v1;   % units = L/H , CQ transforming to DCQ
            k34 = 31.46/v3;  % units = L/h, DCQ from central to peripheral
            k43 = 31.46/v4;  % units = L/h, DCQ from peripheral to central
            %patient's clearance rates
            k10 = CQclear_vector(clearance); %CLEARANCE OF CQ that you're testing
            k30 = K30(patient);
            %patient's absorption
            ka = kabs(patient);
            ptemp = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka];
            [ytemp, time] = Chloroquine_sim(W, ptemp, DosingRegimen, FirstDosing(dose), OtherDosing(dose), MissedDose);
            Time = time;
            YCQCentral = [YCQCentral, ytemp(:,1)];
            YDQCentral = [YDQCentral, ytemp(:,2)];
            
            %2. find the maximum (peak) concentration for EACH patient over each ondition. save that concentrationin peakCQ matrix
            [peakCQ(dose,clearance,patient), indT] = max(abs(ytemp(:,1))); %find the max in the timecourse for the CURRENT patient
            timePeak(dose,clearance,patient)= time(indT); %find the TIME at which the [CQ] peaks
            % ytemp = []; %keeping this but you shouldn't need to "clear" ytemp each time. It'll get redefined in the next cycle when you call the simulation
        end
        
    end
    disp('done with dose number')
    disp(dose)
end

%3. find and report the MEAN peak [CQ] and the MEAN time to peak

peakCQ_mean = zeros(numDoses, numCL);
timePeak_mean = zeros(numDoses, numCL);
%get the mean across all 100 patients
for dose = 1: numDoses 
    for clearance = 1: numCL
        peakCQ_mean(dose,clearance) = mean(peakCQ(dose,clearance,:));
        timePeak_mean(dose,clearance) = mean(timePeak(dose,clearance,:));

    end
end

end
