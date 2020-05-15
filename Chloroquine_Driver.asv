%% Systems Pharmacology Final Project FINAL SUBMISSION
% Authors: Alanna Farrell, Gabrielle Grifno, Sarah Jane Burris

%NOTES:
%SIZE OF VECTORS INDICATE NUMBER OF CONDITIONS TO TEST FOR GLOBAL
%SENSITIVITY AND MALARIA PHARMACODYNAMICS.THIS IS GREATLY REDUCED FOR THE PROJECT DRAFT FOR CODE SPEED (WOULD TAKE ~25 MINUTES OTHERWISE)

%ALSO, WE REDUCED THE TIME OVER WHICH THE PK SIMULATION RUNS (to get chloroquine and desethylcholoroquine concentrations in all compartments
%over time) FROM 21 DAYS (normal observation time reported in our paper) TO 7 DAYS, TO REDUCE TIME NEEDED FOR THE CODE TO RUN

% --> as a result, THIS CODE WILL NOT OUTPUT THE EXACT SAME FIGURES AND
% DATA IN OUR WRITTEN REPORT, because replicating all
% figures exactly as they are present in the report would take several hours of run time.
%% Run simulations for different disease and dosing cases
clear all;
RunCase = 1;

% 1. Malaria    Normal Dosing
% 2. COVID-19   Normal Dosing
MissedDose = 0;

switch RunCase
  
    case 1
% 1. Malaria    Normal Dosing
%========================

        DosingRegimen = 1;
        MissedDose = 0;
        FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
        OtherDosing = 5;    %units - mg/kg, now listed in function inputs
%         DisplayPlots = 1;   %turns plot display of weight distributions ON for Chloroquine_Main
        DisplayPlots = 2; %turns plot display of weight distributions OFF for Chloroquine_Main
        [PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DisplayPlots); 

        MedianYCQ = [];
        MedianYDQ = [];

        P25YCQ = []; P25YDQ = [];
        P75YCQ = []; P75YDQ = []; 

        D = size(Time);
         for i = 1:D(1)
             MedianYCQ = [MedianYCQ;median(YCQCentral(i,:))];
             MedianYDQ = [MedianYDQ;median(YDQCentral(i,:))];
             P25YCQ = [P25YCQ;prctile(YCQCentral(i,:),25)];
             P75YCQ = [P75YCQ;prctile(YCQCentral(i,:),75)];
             P25YDQ = [P25YDQ;prctile(YDQCentral(i,:),25)];
             P75YDQ = [P75YDQ;prctile(YDQCentral(i,:),75)];

             
         end
         
        
         TitleP ='NormalD_Malaria_PK_parameters';
         save(TitleP, 'PatientsData')
         TitleCQ ='NormalD_Malaria_PK_CQCentral';
         save(TitleCQ, 'YCQCentral', 'Time', 'MedianYCQ', 'P25YCQ', 'P75YCQ')
         TitleDQ ='NormalD_Malaria_PK_DQCentral';
         save(TitleDQ, 'YDQCentral', 'Time', 'MedianYDQ', 'P25YDQ', 'P75YDQ')
         TitleA ='NormalD_Malaria_PK_AUCCQ';
         save(TitleA, 'AUCCQ')
         TitleA ='NormalD_Malaria_PK_AUCDCQ';
         save(TitleA, 'AUCDCQ')
         
    case 2
% 2. COVID-19   Normal Dosing
%========================
     
        DosingRegimen = 2;
        MissedDose = 0; 
        FirstDosing  = 500;  %units - mg/kg, now listed in function inputs
        OtherDosing = 500;    %units - mg/kg, now listed in function inputs
        %         DisplayPlots = 1;   %turns plot display of weight distributions ON for Chloroquine_Main
        DisplayPlots = 2; %turns plot display of weight distributions OFF for Chloroquine_Main
        [PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DisplayPlots); 

%         [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
        
        
        MedianYCQ = [];
        MedianYDQ = [];

        P25YCQ = []; P25YDQ = [];
        P75YCQ = []; P75YDQ = []; 

        D = size(Time);
         for i = 1:D(1)
             MedianYCQ = [MedianYCQ;median(YCQCentral(i,:))];
             MedianYDQ = [MedianYDQ;median(YDQCentral(i,:))];
             P25YCQ = [P25YCQ;prctile(YCQCentral(i,:),25)];
             P75YCQ = [P75YCQ;prctile(YCQCentral(i,:),75)];
             P25YDQ = [P25YDQ;prctile(YDQCentral(i,:),25)];
             P75YDQ = [P75YDQ;prctile(YDQCentral(i,:),75)];

             
         end
        TitleP ='NormalD_COVID_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_COVID_PK_CQCentral';
        save(TitleCQ, 'YCQCentral', 'Time', 'MedianYCQ', 'P25YCQ', 'P75YCQ')
        TitleDQ ='NormalD_COVID_PK_DQCentral';
        save(TitleDQ, 'YDQCentral', 'Time', 'MedianYDQ', 'P25YDQ', 'P75YDQ')
        TitleA ='NormalD_COVID_PK_AUCCQ';
        save(TitleA, 'AUCCQ')
        TitleA ='NormalD_COVID_PK_AUCDCQ';
        save(TitleA, 'AUCDCQ')

end

%% Local sensitivity analysis - central compartment AUC
% MAKE SURE TO SET THE TIME DISTANCE IN "CHLOROQUINE_SIM" TO CALCUATE OVER ONLY THE FIRST 3 DAYS FOR MALARIA SIMULATION
% run baseline case using the DRIVER section defined above, which creates patients and runs the simulation
% now perturb only ONE of the variables in the parameter vector at a time and return the AUC for both CQ and DCQ
numSensi = 13;%number of variables in need of local sensitivity testing
%initialize matrix of sensitivity values
[patients, ~] = size(WeightVal);
[timepoints, col] = size(Time);
sensiAUCCQall = ones(patients, numSensi); %hold the sensitivity values for each of the patients  
sensiAUCDCQall= ones(patients, numSensi); %hold the sensitivity values for each of the patients
sensiCQall = ones(timepoints, patients, numSensi); %hold the concentration of CQ in the central compartment for each timepoint over 3 days
sensiDCQall= ones(timepoints, patients, numSensi); %hold the concentration of DCQ in the central compartment for each timepoint over 3 days

PercentChange = 1.05; %model a 5% increase

for sensiVar = 1: numSensi
    [Time,sensiCQall(:,:,sensiVar), sensiDCQall(:,:,sensiVar), sensiAUCCQall(:, sensiVar),sensiAUCDCQall(:, sensiVar)] = Chloroquine_LocalSensi(WeightVal, v1cq, v2cq, v1dcq, v2dcq, K10, K30,kabs, DosingRegimen, FirstDosing, OtherDosing, MissedDose, sensiVar, PercentChange);
    disp('done with variable number:')
    disp(sensiVar)
end
% output the MEAN of the NORMALIZED AUC sensitivity with standard dev for visualization in Rstudio

sensiAUCCQnorm = ones(patients, numSensi);
sensiAUCDCQnorm= ones(patients, numSensi);

sensiAUCCQmean = zeros(numSensi,1);
sensiAUCDCQmean= zeros(numSensi,1);

sensiAUCCQstdev = zeros(numSensi,1);
sensiAUCDCQstdev= zeros(numSensi,1);

% for each patient, calculate the normalized sensitivity, (dY/y)/(dP/p)
for j = 1: numSensi
    for i = 1:patients
        sensiAUCCQnorm(i,j) = ((sensiAUCCQall(i,j) - AUCCQ(i))/AUCCQ(i))/(1-PercentChange);
        sensiAUCDCQnorm(i,j) = ((sensiAUCDCQall(i,j) - AUCDCQ(i))/AUCDCQ(i))/(1-PercentChange);
    end
    %take the MEAN across all 100 patients for each variable
    sensiAUCCQmean(j,1) = mean(sensiAUCCQnorm(:,j));
    sensiAUCDCQmean(j,1)= mean(sensiAUCDCQnorm(:,j));
    
    %find the standard deviation across all patients
    sensiAUCCQstdev(j,1)= std(sensiAUCCQnorm(:,j));
    sensiAUCDCQstdev(j,1)= std(sensiAUCDCQnorm(:,j));
end

local_var = ["q" "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"]';

if RunCase ==1 %Malaria
    save LocalSensiAUC_Malaria.mat sensiAUCCQmean sensiAUCCQstdev sensiAUCDCQmean sensiAUCDCQstdev;
elseif RunCase ==2 %COVID-19
    save LocalSensiAUC-COVID-19.mat sensiAUCCQmean sensiAUCCQstdev sensiAUCDCQmean sensiAUCDCQstdev;
end

%% Time-dependent local sensitivity
sensiCQnorm = ones(timepoints, patients, numSensi);
sensiDCQnorm= ones(timepoints, patients, numSensi);

sensiCQmean = zeros(timepoints, numSensi);
sensiDCQmean= zeros(timepoints, numSensi);

sensiCQstdev = zeros(timepoints, numSensi);
sensiDCQstdev= zeros(timepoints, numSensi);

% SensT = ((y1-y0)./y0)/((p(i)-p0(i))/p0(i));
%calcuate the sensitivity of concentration for each timepoint
for k = 1:numSensi
    for j = 1:patients
        for i = 1:timepoints
            sensiCQnorm(i,j,k) = ((sensiCQall(i,j,k) - YCQCentral(i,j))/YCQCentral(i,j))/(1-PercentChange);
            sensiDCQnorm(i,j,k) = ((sensiDCQall(i,j,k) - YDQCentral(i,j))/YDQCentral(i,j))/(1-PercentChange);
        end
    end
end

%calcuate the mean sensitivity for each timepoint, and the stdev, across all 100 patients
for j = 1: numSensi
    for i = 1: timepoints
        %take the MEAN across all 100 patients for each timepoint
        sensiCQmean(i,j) = mean(sensiCQnorm(i,:,j));
        sensiDCQmean(i,j)= mean(sensiDCQnorm(i,:,j));

        %find the standard deviation across all patients
        sensiCQstdev(i,j)= std(sensiCQnorm(i,:,j));
        sensiDCQstdev(i,j)= std(sensiDCQnorm(i,:,j));
    end
end

%update sensitivity mean and stdev to get rid of NaN values

sensiCQmean = sensiCQmean(2:end,:);
sensiCQstdev = sensiCQstdev(2:end,:);

sensiDCQmean = sensiDCQmean(2:end,:);
sensiDCQstdev = sensiDCQstdev(2:end,:);
%cut time short by one timepoint to match up with sensitivity data AND convert from hours to days
Timenew = Time(2:end,:)./24;

if RunCase ==1
    save LocalSensiCQ_Malaria.mat Timenew sensiCQmean sensiCQstdev;
    save LocalSensiDCQ_Malaria.mat Timenew sensiDCQmean sensiDCQstdev;
elseif RunCase ==2
    save LocalSensiCQ-COVID19.mat Timenew sensiCQmean sensiCQstdev;
    save LocalSensiDCQ-COVID19.mat Timenew sensiDCQmean sensiDCQstdev
end

%% Sensitivity to concentrations changes with changing dose

%set the doses to be used
numDose = 10; %ten dose conditions
if RunCase ==1
    Firstdose_vector = linspace(10,20,numDose)';
    Seconddose_vector = linspace(5,10,numDose)';
    dose_total_malaria = Firstdose_vector + 3.*Seconddose_vector;
elseif RunCase ==2
    Firstdose_vector = linspace(500,1000,numDose)';
    Seconddose_vector = linspace(500,1000,numDose)';
    dose_total_C19 = Firstdose_vector + 9.*Seconddose_vector; %ten total doses
end

% initialize matrices to hold data
sensiCQall_dose = ones(timepoints, patients, numSensi, numDose); %hold the concentration of CQ in the central compartment for each timepoint over 3 days
sensiDCQall_dose= ones(timepoints, patients, numSensi, numDose); %hold the concentration of DCQ in the central compartment for each timepoint over 3 days

for dose = 1:numDose %iterate through 10 doses
    for sensiVar = 1: numSensi
    [Time,sensiCQall_dose(:,:,sensiVar,dose), sensiDCQall_dose(:,:,sensiVar,dose), ~,~] = Chloroquine_LocalSensi(WeightVal, v1cq, v2cq, v1dcq, v2dcq, K10, K30,kabs, DosingRegimen, Firstdose_vector(dose),Seconddose_vector(dose), MissedDose, sensiVar, PercentChange);
    end
    disp('done with dose number')
    disp(dose)
end

% find the mean across all patients for all sensitivity and dose conditions
sensiCQmean_dose = zeros(timepoints,numSensi, numDose); %hold the concentration of CQ in the central compartment for each timepoint over 3 days
sensiDCQmean_dose= zeros(timepoints,numSensi, numDose); %hold the concentration of DCQ in the central compartment for each timepoint over 3 days

for k = 1: numDose
    for j = 1: numSensi
        for i = 1: timepoints
            %take the MEAN across all 100 patients for each timepoint
            sensiCQmean_dose(i,j,k) = mean(sensiCQall_dose(i,:,j,k));
            sensiDCQmean_dose(i,j,k) = mean(sensiDCQall_dose(i,:,j,k));
            %find the standard deviation across all patients
                % don't need the stdev for this because it's going to be collapsed down
        end
    end
end

% find the peak sensitivity and time of peak sensitivity
sensiCQmax_dose = ones(numSensi, numDose); %hold the concentration of CQ in the central compartment for each timepoint over 3 days
sensiDCQmax_dose= ones(numSensi, numDose); %hold the concentration of DCQ in the central compartment for each timepoint over 3 days
sensiCQtime_dose = ones(numSensi, numDose); %hold the concentration of CQ in the central compartment for each timepoint over 3 days
sensiDCQtime_dose= ones(numSensi, numDose); %hold the concentration of DCQ in the central compartment for each timepoint over 3 days

for k = 1: numDose
    for j = 1: numSensi
         %find the max across all timepoints (i) and the INDEX of the max in the time vector
         %[CQ] in the central compartment
        [sensiCQmax_dose(j,k),CQmaxtime] = max(sensiCQmean_dose(:,j,k));
        sensiCQtime_dose(j,k) = Time(CQmaxtime); %return the timepoint where the max sensitivity occurs
         %[DCQ] in the central compartment       
        [sensiDCQmax_dose(j,k),DCQmaxtime] = max(sensiDCQmean_dose(:,j,k));
        sensiDCQtime_dose(j,k) = Time(DCQmaxtime); %return the timepoint where the max sensitivity occurs
    end
end

%save for R visualization

if RunCase ==1
    save HeatDataCQdose.mat sensiCQmax_dose
    save HeatDataCQtime.mat sensiCQtime_dose
    save HeatDataDCQdose.mat sensiDCQmax_dose
    save HeatDataDCQtime.mat sensiDCQtime_dose
elseif RunCase ==2
    save HeatDataCQdoseCOVID19.mat sensiCQmax_dose
    save HeatDataCQtimeCOVID19.mat sensiCQtime_dose
    save HeatDataDCQdoseCOVID19.mat sensiDCQmax_dose
    save HeatDataDCQtimeCOVID19.mat sensiDCQtime_dose
end

%% VARIABLE DOSE: Collect the changes in Concentration of CQ, DCQ and AUCCQ
%NEED TO SWITCH 'RUNCASE' TO VALUE '2' TO GET THE COVID-19 PATIENTS INFORMATION
if RunCase ==1
    Firstdose_vector = linspace(10,20,10)';
    Seconddose_vector = linspace(5,10,10)';
    dose_total_malaria = Firstdose_vector + 3.*Seconddose_vector;
elseif RunCase ==2
    Firstdose_vector = linspace(500,1000,10)';
    Seconddose_vector = linspace(500,1000,10)';
    dose_total_C19 = Firstdose_vector + 9.*Seconddose_vector; %ten total doses
end
[timepoints, patients] = size(YCQCentral);
%get all the traces for all the patients
varDose_CQ = zeros(timepoints, patients, 10); %output AVERAGE YCQcentral, YDQcentral, AUC
varDose_DCQ = zeros(timepoints, patients, 10); %output AVERAGE YCQcentral, YDQcentral, AUC
varDose_AUCCQ = zeros(1, patients, 10); %output AVERAGE YCQcentral, YDQcentral, AUC

for i = 1:10 %iterate througha all the doses
[PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, Firstdose_vector(i),Seconddose_vector(i), MissedDose, DisplayPlots); 
    varDose_CQ(:,:,i) = YCQCentral;
    varDose_DCQ(:,:,i) = YDQCentral;
    varDose_AUCCQ(:,:,i) = AUCCQ;
end

%% find the mean value ACROSS PATIENTS of the output for each dose condition, for each time point
varDose_CQmedian = zeros(timepoints, 10, 1);
varDose_DCQmedian = zeros(timepoints, 10, 1);
varDose_AUCCQmedian = zeros(10, 1);

varDose_CQ_iqr_upper = zeros(timepoints, 10, 1);
varDose_DCQ_iqr_upper = zeros(timepoints, 10, 1);
varDose_AUCCQ_iqr_upper = zeros(10, 1);

varDose_CQ_iqr_lower = zeros(timepoints, 10, 1);
varDose_DCQ_iqr_lower = zeros(timepoints, 10, 1);
varDose_AUCCQ_iqr_lower = zeros(10, 1);

for dose = 1:10
    for t = 1:timepoints
        % Find the median value across each patient for each timepoint, for each dose condition 
        varDose_CQmedian(t,dose,1) = median(varDose_CQ(t,:,dose));
        varDose_DCQmedian(t,dose,1) = median(varDose_DCQ(t,:,dose));
        varDose_AUCCQmedian(dose,1) = median(varDose_AUCCQ(1,:,dose));
        
        % Find the UPPER bounds of the interquartile range (IQR) that corresponds with each median above
        varDose_CQ_iqr_upper(t,dose,1) = median(varDose_CQ(t,:,dose)) + iqr(varDose_CQ(t,:,dose))./2;
        varDose_DCQ_iqr_upper(t,dose,1) = median(varDose_DCQ(t,:,dose)) + iqr(varDose_DCQ(t,:,dose))./2;
        varDose_AUCCQ_iqr_upper(dose,1) = median(varDose_AUCCQ(1,:,dose)) + iqr(varDose_AUCCQ(1,:,dose))./2;
        
        % Find the LOWER bounds of the interquartile range (IQR) that corresponds with each median above
        varDose_CQ_iqr_lower(t,dose,1) = median(varDose_CQ(t,:,dose)) - iqr(varDose_CQ(t,:,dose))./2;
        varDose_DCQ_iqr_lower(t,dose,1) = median(varDose_DCQ(t,:,dose)) - iqr(varDose_DCQ(t,:,dose))./2;
        varDose_AUCCQ_iqr_lower(dose,1) = median(varDose_AUCCQ(1,:,dose)) - iqr(varDose_AUCCQ(1,:,dose))./2;
    end
end

Timeday = Time./24;
%save data for later visualization in R
if RunCase ==1
    save varDose_CQ_Malaria.mat Timeday varDose_CQmedian varDose_CQ_iqr_upper varDose_CQ_iqr_lower;
    save varDose_DQ_Malaria.mat Timeday varDose_DCQmedian varDose_DCQ_iqr_upper varDose_DCQ_iqr_lower;
    save varDose_AUCCQ_Malaria.mat varDose_AUCCQmedian varDose_AUCCQ_iqr_upper varDose_AUCCQ_iqr_lower;
elseif RunCase ==2
    save dose_COVID19.mat dose_total_C19 
    save varDose_CQ_COVID19.mat Timeday varDose_CQmedian varDose_CQ_iqr_upper varDose_CQ_iqr_lower;
    save varDose_DQ_COVID19.mat Timeday varDose_DCQmedian varDose_DCQ_iqr_upper varDose_DCQ_iqr_lower;
    save varDose_AUCCQ_COVID19.mat varDose_AUCCQmedian varDose_AUCCQ_iqr_upper varDose_AUCCQ_iqr_lower;
end

%% Global Sensitivity Plots - MALARIA

%SIZE OF VECTORS INDICATE NUMBER OF CONDITIONS TO TEST. THIS IS GREATLY
%REDUCED FOR THE PROJECT DRAFT FOR CODE SPEED (WOULD TAKE ~25 MINUTES
%OTHERWISE)
dose_vector_Malaria = [linspace(10,20,10)', linspace(5,10,10)'];
HL_vector_Malaria = linspace(20, 60,10)';
CQclear_vector_Malaria = log(2)./(HL_vector_Malaria.*24);

% lobal_sensitivity(PatientsData, DosingRegimen, dose_vector, CQclear_vector);
[peakCQ_Malaria, peakCQ_mean_Malaria, timePeak_Malaria, timePeak_mean_Malaria] = Global_sensitivity(WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs,DosingRegimen, dose_vector_Malaria, CQclear_vector_Malaria);

% save global sensitivity data - MALARIA
dose_total_Malaria = dose_vector_Malaria(:,1) + 3.*dose_vector_Malaria(:,2); %sum the columns of the dose vector
save global_sensi_Malaria.mat peakCQ_mean_Malaria dose_total_Malaria CQclear_vector_Malaria;

%% Global Sensitivity Plots - COVID-19

dose_vector_C19 = [linspace(500,1000,10)', linspace(500,1000,10)'];
HL_vector_C19 = linspace(20, 60,10)';
CQclear_vector_C19 = log(2)./(HL_vector_C19.*24);

[peakCQ_C19, peakCQ_mean_C19, timePeak_C19, timePeak_mean_C19] = Global_sensitivity(WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs,DosingRegimen, dose_vector_C19, CQclear_vector_C19);

% save global sensitivity data - COVID-19
% dose_total = dose_vector(:,1) + 3.*dose_vector(:,2); %sum the columns of the dose vector
save global_sensi_COVID19.mat peakCQ_mean_C19 dose_vector_C19 CQclear_vector_C19;

%% PHARMACODYNAMICS: P. vivax infection response to CQ administration (DEFINE PARAMETERS)

%numbers and mechanism specific to P. vivax
%given information
P0 = 1*10^12; %starting number of parasites
t = linspace(1,200);
kP = linspace(1/25,1/110,50)'; %hr-1, clearance rate for parasites treated with chloroquine
P_halflife = 0.693./kP ;

%% Variable parasite clearance in response to variable kP (DEMO)

%FUNCTIONS
% Pt = P0*exp(-kP*t); 
    %Pt = paritemia level at any time after starting treatment
    %P0 = starting parasite level
    %kP = first-order parasite elmination rate constant
%t = time
%kP = parasite clearance rate (killing rate)
figure;
for i = 1:50
    hold on
    Pt = P0.*exp(-kP(i).*t);
    kP_median = median(kP);
    Pt_median = P0.*exp(-kP_median.*t);
    plot(t, Pt, 'k')
    ax = gca;
    ax.FontSize = 16; 
    
end
plot(t, Pt_median, 'b','LineWidth', 2)
title('Clearance of P. vivax Across Different Clearance Rates','FontSize', 18)
xlabel('Time (hrs)','FontSize', 16)
ylabel('Total Parasites','FontSize', 16)
hold off

%% Diffeq model for quantifying number of parasites at any time t based on [CQ] (DEMO)

[timepoints, patients] = size(YCQCentral); %get the number of timepoints the simulation runs for the patient
MIC1 = 0.067; %mg/L, minimum inhibitory concentration (MIC), NEED TO FIND LITERATURE SUPPORT
MIC2 = 2*MIC1; %mg/L, twice the minimum inhibitory concentration for testing another MIC condition

options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
tspan = 0:.06:500; %simulate 500 hours
kP = kP_median; %demonstrate model using median kP
r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
a = [kP_median r]; %input vector for ODE solver
initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
[T, Y] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model

%plot the resulting demonstration (need to manually save)
figure;
hold on
plot(T, Y(:,1),'LineWidth', 2)
plot(T, Y(:,2),'LineWidth', 2)
plot(T, Y(:,3),'LineWidth', 2)
ylim([-2*10^12 2*10^12])
ax = gca;
ax.FontSize = 16;
xlabel('Time (hrs)','FontSize', 16)
ylabel('Number of Parasites','FontSize', 16)
title('Demonstration of First-Order Model of Parasite Dynamics')
legend('total parasites', 'parasites cleared', 'parasite growth')

%% PHARMACODYNAMICS: determining PD response of Malaria P.vivax infection to CQ administration with variable dose, kP and inital parasite burden
[timepoints, patients] = size(YCQCentral); %get the size to determine sizes of matrices inside Malaria simulation
%SIZE OF VECTORS INDICATE NUMBER OF CONDITIONS TO TEST. THIS IS GREATLY
%REDUCED FOR THE PROJECT DRAFT FOR CODE SPEED (WOULD TAKE ~25 MINUTES
%OTHERWISE)

doseRange = 10; %test 10 points in the dose range
rangekP = 10;
rangeBurden = 10; %test across 10 possible initial burdens
MIC = 0.0067;   %literature reported value for MIC is 0.0067

%% Figure 1: vary dose and parasite clearance
kP_vector1 = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
P0_vector1 = (10^12).*ones(rangeBurden,1); %set the intial burden to be the same for all patients
FirstDoseRange = linspace(FirstDosing,2*FirstDosing, doseRange); %choose a range of first doses to explore, where upper bound is DOUBLE the lower bound
SecondDoseRange = linspace(OtherDosing,2*OtherDosing, doseRange);%choose a range of second doses to explore
totalDose = FirstDoseRange + 3.*SecondDoseRange;

[Parasites_at_end1, percentCured1] = Chloroquine_Malaria(DosingRegimen, doseRange,rangekP,rangeBurden, FirstDosing,OtherDosing,timepoints,kP_vector1, P0_vector1,FirstDoseRange, SecondDoseRange, patients, MIC, MissedDose,DisplayPlots);

save fig1Malaria.mat percentCured1 kP_vector1 totalDose;
save fig1ParasiteBurden.mat Parasites_at_end1 kP_vector1 totalDose;

%% Figure 2: vary dose and starting parasite burden
kP_vector2 = median(linspace(1/25,1/110,rangekP)).*ones(rangekP,1); %hr-1, use the median kP for all patients
P0_vector2 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
FirstDoseRange = linspace(FirstDosing,2*FirstDosing, doseRange); %choose a range of first doses to explore, where upper bound is DOUBLE the lower bound
SecondDoseRange = linspace(OtherDosing,2*OtherDosing, doseRange);%choose a range of second doses to explore
totalDose = FirstDoseRange + 3.*SecondDoseRange;

[Parasites_at_end2, percentCured2] = Chloroquine_Malaria(DosingRegimen, doseRange,rangekP,rangeBurden, FirstDosing,OtherDosing,timepoints,kP_vector2, P0_vector2,FirstDoseRange, SecondDoseRange, patients, MIC, MissedDose,DisplayPlots);

save fig2Malaria.mat percentCured2 P0_vector2 totalDose;
save fig2ParasiteBurden.mat Parasites_at_end2 P0_vector2 totalDose

%% Figure 3: vary dose and starting parasite burden, where kP decreases for  increasing starting parasite burden
kP_vector3 = linspace(1/25,1/110,rangekP)'; %hr-1, decrease the kP for increasing starting parasites
P0_vector3= logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
FirstDoseRange = linspace(FirstDosing,2*FirstDosing, doseRange); %choose a range of first doses to explore, where upper bound is DOUBLE the lower bound
SecondDoseRange = linspace(OtherDosing,2*OtherDosing, doseRange);%choose a range of second doses to explore
totalDose = FirstDoseRange + 3.*SecondDoseRange;

[Parasites_at_end1, percentCured1] = Chloroquine_Malaria(DosingRegimen, doseRange,rangekP,rangeBurden, FirstDosing,OtherDosing,timepoints,kP_vector1, P0_vector1,FirstDoseRange, SecondDoseRange, patients, MIC, MissedDose,DisplayPlots);

save fig3Malaria.mat percentCured1 kP_vector3 totalDose;
save fig3ParasiteBurden.mat Parasites_at_end1 kP_vector3 totalDose;

