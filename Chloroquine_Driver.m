%% Systems Pharmacology Final Project DRAFT
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
RunCase = 4; % DO NOT RUN CASES 2 AND 4 (missing covid dosing)

% 1. Malaria    Normal Dosing
% 2. COVID-19   Normal Dosing
% 3. Malaria    Missed Dose
% 4. COVID-19   Missed Dose
MissedDose = 1; %only applies to cases 3 and 4
%Dosing Schedule:
%  1 = miss first dose   4 = miss fourth dose
%  2 = miss second dose  3 = miss third dose

%%%Could add to change number of subjects?
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

        TitleP ='NormalD_Malaria_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_Malaria_PK_CQCentral';
        save(TitleCQ, 'YCQCentral', 'Time')
        TitleDQ ='NormalD_Malaria_PK_DQCentral';
        save(TitleDQ, 'YDQCentral', 'Time')
        TitleA ='NormalD_Malaria_PK_AUCCQ';
        save(TitleA, 'AUCCQ')
        TitleA ='NormalD_Malaria_PK_AUCDCQ';
        save(TitleA, 'AUCDCQ')
    case 2
% 2. COVID-19   Normal Dosing
%========================
     
        DosingRegimen = 2;
        MissedDose = 0; 
        FirstDosing  = 0;  %units - mg/kg, now listed in function inputs
        OtherDosing = 0;    %units - mg/kg, now listed in function inputs
        %         DisplayPlots = 1;   %turns plot display of weight distributions ON for Chloroquine_Main
        DisplayPlots = 2; %turns plot display of weight distributions OFF for Chloroquine_Main
        [PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DisplayPlots); 

%         [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
        
        
        
        TitleP ='NormalD_COVID_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_COVID_PK_CQCentral';
        save(TitleCQ, 'YCQCentral', 'Time')
        TitleDQ ='NormalD_COVID_PK_DQCentral';
        save(TitleDQ, 'YDQCentral', 'Time')
        TitleA ='NormalD_COVID_PK_AUCCQ';
        save(TitleA, 'AUCCQ')
        TitleA ='NormalD_COVID_PK_AUCDCQ';
        save(TitleA, 'AUCDCQ')

    case 3
% 3. Malaria    Missed Dose
%========================
     
        DosingRegimen = 1;
        FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
        OtherDosing = 5;    %units - mg/kg, now listed in function inputs
        DisplayPlots = 1; %turns plot display of weight distributions OFF for Chloroquine_Main

        [PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose, DisplayPlots); 

%         [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
        
        %UpdateToShowWhichDoseMissed
        i = MissedDose;
        
   
        TitleP = sprintf('MissedD%i_Malaria_PK_parameters',i);
        save(TitleP, 'PatientsData')
        TitleCQ = sprintf('MissedD%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'YCQCentral', 'Time')
        TitleDQ =sprintf('MissedD%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'YDQCentral', 'Time')
        TitleA =sprintf('MissedD%i_Malaria_PK_AUCCQ',i);
        save(TitleA, 'AUCCQ')
        TitleA =sprintf('MissedD%i_Malaria_PK_AUCDCQ',i);
        save(TitleA, 'AUCDCQ')
    
	case 4
% 4. oCOVID Missed Dosing
%========================
     
        DosingRegimen = 2;
        FirstDosing  = 500;  %units - mg/kg, now listed in function inputs
        OtherDosing = 500;    %units - mg/kg, now listed in function inputs
        %         DisplayPlots = 1;   %turns plot display of weight distributions ON for Chloroquine_Main
        DisplayPlots =1; %turns plot display of weight distributions OFF for Chloroquine_Main
        [PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DisplayPlots); 
        
%         [PatientsData, Time, YCQCentral, YDQCentral,AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
        %UpdateToShowWhichDoseMissed
        i = MissedDose;
        TitleP = sprintf('MissedD%i_COVID_PK_parameters', i);
        save(TitleP, 'PatientsData')
        TitleCQ = sprintf('MissedD%i_COVID_PK_CQCentral', i);
        save(TitleCQ, 'YCQCentral', 'Time')
        TitleDQ = sprintf('MissedD%i_COVID_PK_DQCentral', i);
        save(TitleDQ, 'YDQCentral', 'Time')
        TitleA =sprintf('MissedD%i_COVID_PK_AUCCQ',i);
        save(TitleA, 'AUCCQ')
        TitleA =sprintf('MissedD%i_COVID_PK_AUCDCQ',i);
        save(TitleA, 'AUCDCQ')
           

end

%% Generate Global Sensitivity Plots - MALARIA

%SIZE OF VECTORS INDICATE NUMBER OF CONDITIONS TO TEST. THIS IS GREATLY
%REDUCED FOR THE PROJECT DRAFT FOR CODE SPEED (WOULD TAKE ~25 MINUTES
%OTHERWISE)
dose_vector_Malaria = [linspace(10,20,2)', linspace(5,10,2)'];
HL_vector_Malaria = linspace(20, 60,2)';
CQclear_vector_Malaria = log(2)./(HL_vector_Malaria.*24);

% lobal_sensitivity(PatientsData, DosingRegimen, dose_vector, CQclear_vector);
[peakCQ_Malaria, peakCQ_mean_Malaria, timePeak_Malaria, timePeak_mean_Malaria] = Global_sensitivity(WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs,DosingRegimen, dose_vector_Malaria, CQclear_vector_Malaria);

%% save global sensitivity data - MALARIA
dose_total_Malaria = dose_vector_Malaria(:,1) + 3.*dose_vector_Malaria(:,2); %sum the columns of the dose vector
save global_sensi_Malaria.mat peakCQ_mean_Malaria dose_total_Malaria CQclear_vector_Malaria;

%% Generate Global Sensitivity Plots - COVID-19

dose_vector_C19 = [linspace(500,1000,2)', linspace(500,1000,2)'];
HL_vector_C19 = linspace(20, 60,2)';
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

doseRange = 2; %test 10 timepoints in the dose range
rangekP = 2;
rangeBurden = 2; %test across 10 possible initial burdens
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

