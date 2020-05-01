%% Run simulations for different disease and dosing cases
clear all;
RunCase = 1; % DO NOT RUN CASES 2 AND 4 (missing covid dosing)

% 1. Malaria    Normal Dosing
% 2. COVID-19   Normal Dosing
% 3. Malaria    Missed Dose
% 4. COVID-19   Missed Dose

MissedDose = 3; %only applies to cases 3 and 4
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

%         TitleP ='NormalD_Malaria_PK_parameters';
%         save(TitleP, 'PatientsData')
%         TitleCQ ='NormalD_Malaria_PK_CQCentral';
%         save(TitleCQ, 'YCQCentral', 'Time')
%         TitleDQ ='NormalD_Malaria_PK_DQCentral';
%         save(TitleDQ, 'YDQCentral', 'Time')
%         TitleA ='NormalD_Malaria_PK_AUCCQ';
%         save(TitleA, 'AUCCQ')
%         TitleA ='NormalD_Malaria_PK_AUCDCQ';
%         save(TitleA, 'AUCDCQ')
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

        [PatientsData, WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose); 

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
% 4. optimization with bounds 
%========================
     
        DosingRegimen = 2;
        FirstDosing  = 0;  %units - mg/kg, now listed in function inputs
        OtherDosing = 0;    %units - mg/kg, now listed in function inputs
        %         DisplayPlots = 1;   %turns plot display of weight distributions ON for Chloroquine_Main
        DisplayPlots = 2; %turns plot display of weight distributions OFF for Chloroquine_Main
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

dose_vector_Malaria = [linspace(10,20,10)', linspace(5,10,10)'];
HL_vector_Malaria = linspace(20, 60,10)';
CQclear_vector_Malaria = log(2)./(HL_vector_Malaria.*24);

% lobal_sensitivity(PatientsData, DosingRegimen, dose_vector, CQclear_vector);
[peakCQ_Malaria, peakCQ_mean_Malaria, timePeak_Malaria, timePeak_mean_Malaria] = Global_sensitivity(WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs,DosingRegimen, dose_vector_Malaria, CQclear_vector_Malaria);

%% save global sensitivity data - MALARIA
dose_total_Malaria = dose_vector_Malaria(:,1) + 3.*dose_vector_Malaria(:,2); %sum the columns of the dose vector
save global_sensi_Malaria.mat peakCQ_mean_Malaria dose_total_Malaria CQclear_vector_Malaria;

%% Generate Global Sensitivity Plots - COVID-19

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

%% Pharmacodynamics: determining PD response of Malaria plasmodium infection to CQ administration with variable dose, kP and inital parasite burden
[timepoints, patients] = size(YCQCentral); %get the size to determine sizes of matrices inside Malaria simulation
doseRange = 10; %test 10 timepoints in the dose range
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

% %% FIGURE 1 - PD: therapeutic effect of (1)dosing variance, (2) varying parasite clearance
% 
% %part 1: PK simulation to get drug concentrations for the time course
% doseRange = 10; %number of doses to try within the dose limits (defined below)
% FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% 
% 
% %initialize matrices for storing simulation outputs across different doses
% CQconc = zeros(length(Time),patients,doseRange);% define zeros that will hold all time points (row), for all patients (column), for each dose choice (depth)
% DCQconc = zeros(length(Time),patients,doseRange);
% AUCCQ_doses = zeros(patients, doseRange);
% AUCDCQ_doses = zeros(patients, doseRange);
% 
% for z = 1:doseRange %run simulations for ALL the doses (currently we have 10 dose conditions) 
%     [~, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDoseRange(z),SecondDoseRange(z), MissedDose); 
%     CQconc(:,:,z) = YCQCentral; %extract the central compartment concentration 
%     DCQconc(:,:,z) = YDQCentral; %extract the peripheral compartment concentration
%     AUCCQ_doses(:, z) = AUCCQ;
%     AUCDCQ_doses(:,z) = AUCDCQ;
% end
% 
% %% FIGURE 1 Part 2: get parasite values from parasite eqn using CQ concentration
% %approach: 
% %1 get timestamps for when concentration of CQ falls below the MIC
% %(original MIC)
% CQconcBelow_MIC1 = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
% Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
% for dose = 1:doseRange
%     for patient = 1: patients
%         sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
%         if size(find(sample < MIC1, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
%         CQconcBelow_MIC1(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
%         else
%         CQconcBelow_MIC1(dose,patient) = Hour_100 + find(sample < MIC1, 1); 
%         %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
%         end
%     end
% end
% 
% %(doubled MIC)
% CQconcBelow_MIC2 = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
% Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
% for dose = 1:doseRange
%     for patient = 1: patients
%         sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
%         if size(find(sample < MIC2, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
%         CQconcBelow_MIC2(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
%         else
%         CQconcBelow_MIC2(dose,patient) = Hour_100 + find(sample < MIC2, 1); 
%         %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
%         end
%     end
% end
% 
% %% 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% %decide what the kP testing range is:
% rangekP = 10; %test across 10 possible kPs
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% 
% %decide what the tspan is for the first half of the simulation and simulate
% %parasite counts
% Parasites_at_end = ones(rangekP, doseRange,patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for clearanceCounter = 1:rangekP
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:.5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(clearanceCounter); %run model using one of the kPs to indicate parasite sensitivity to CQ
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_end(clearanceCounter,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:0.5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(clearanceCounter); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan1 with new initial conditions and new (lower) kP
% %     tspan2 = tspan1(end):.06:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     tspan2 = tspan1(end):0.5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_end(clearanceCounter,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with kP testing number:')
% disp(clearanceCounter)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured = zeros(doseRange, kP_Range); %index position 2 will eventually be filled in by kP value
% for clearanceCounter = 1:rangekP
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_end(clearanceCounter,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured(dose,clearanceCounter) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save figA1.mat percentCured kP totalDose;
% 
% %% 2.2 MIC2: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% %decide what the kP testing range is:
% rangekP = 10; %test across 10 possible kPs
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% 
% %decide what the tspan is for the first half of the simulation and simulate
% %parasite counts
% Parasites_at_end2 = ones(rangekP, doseRange,patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for clearanceCounter = 1:rangekP
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC2(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:.5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(clearanceCounter); %run model using one of the kPs to indicate parasite sensitivity to CQ
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_end2(clearanceCounter,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC2(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:0.5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(clearanceCounter); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan1 with new initial conditions and new (lower) kP
% %     tspan2 = tspan1(end):.06:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     tspan2 = tspan1(end):0.5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_end2(clearanceCounter,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with kP testing number:')
% disp(clearanceCounter)
% end
% 
% %% 4.2 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured2 = zeros(doseRange, kP_Range); %index position 2 will eventually be filled in by kP value
% for clearanceCounter = 1:rangekP
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_end2(clearanceCounter,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured2(dose,clearanceCounter) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.2 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save figA2.mat percentCured kP totalDose;
% 
% %% FIGURE 2A: DOSE V. STARTING PARASITE BURDEN, MIC = 1
% 
% % 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig2a = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP_median; %run model using the median kP for ALL patients
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP_median; %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured2a = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig2a(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured2a(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig2A.mat percentCured2a  P0_vector totalDose;
% 
% %% FIGURE 2B: DOSE V. STARTING BURDEN USING MIC 2
% %USE MIC 2
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig2B = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC2(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP_median; %run model using the median kP for ALL patients
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig2B(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC2(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP_median; %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig2B(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured2B = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig2B(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured2B(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig2B.mat percentCured2B  P0_vector totalDose;
% 
% %% FIGURE 3A: DOSE V. STARTING PARASITE BURDEN WITH DECREASING KP, MIC = 1
% 
% % 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig2a = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(burden); %run model using decreasing kP for increasing parasite burden
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(burden); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured3a = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig2a(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured3a(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig3A.mat percentCured3a  P0_vector totalDose;
% 
% %% FIGURE 3B: DOSE V. STARTING PARASITE BURDEN WITH DECREASING KP, MIC = 2
% 
% % 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig3b = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC2(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(burden); %run model using decreasing kP for increasing parasite burden
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig3b(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC2(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(burden); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig3b(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured3b = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig3b(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured3b(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig3B.mat percentCured3b  P0_vector totalDose;
