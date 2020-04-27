clear all;

RunCase = 1; % DO NOT RUN CASES 2 AND 4 (missing covid dosing)

% 1. Malaria    Normal Dosing
% 2. COVID-19   Normal Dosing
% 3. Malaria    Missed Dose
% 4. COVID-19   Missed Dose

MissedDose = 0; %only applies to cases 3 and 4
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
        [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 

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
        
        [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
        
        TitleP ='NormalD_COVID_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_COVID_PK_CQCentral';
        save(TitleCQ, 'YCQCentral', 'Time')
        TitleDQ ='NormalD_COVID_PK_DQCentral';
        save(TitleDQ, 'YDQCentral', 'Time')
        TitleA ='NormalD_COVID_PK_AUCCQ';
        save(TitleA, 'AUCCQ')
        TitleA ='NormalD_COVID_PK_AUCCQ';
        save(TitleA, 'AUCDCQ')

    case 3
% 3. Malaria    Missed Dose
%========================
     
        DosingRegimen = 1;
        
        [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
        
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
        
        [PatientsData, Time, YCQCentral, YDQCentral,AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDosing,OtherDosing, MissedDose); 
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

%% Pharmacodynamics: P. vivax infection response to CQ administration

%numbers and mechanism specific to P. vivax
%given information
P0 = 1*10^12; %starting number of parasites
t = linspace(1,200);
low_density = 50; % parasites/uL in bloodstream
med_density = 2*10^3; %parasites/uL in blood
high_density = 2*10^6; % parasites/uL in bloodstream
kP = linspace(1/25,1/110,50)'; %hr-1, clearance rate for parasites treated with chloroquine
P_halflife = 0.693./kP ;
P_double = 24; %hrs, doubling rate for parasites can be anywhere from 1-3 days
P_detectlimit_microscope = 10^8; %detection limit for microscopy techniques, total # of parasites in body
P_detectlimit_PCR = 10^5; %detection limit for PCR, total # of parasites in body

%% Demonstrate variable parasite clearance in response to variable kP

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

%% Demonstration of diffeq model for quantifying number of parasites
[timepoints, patients] = size(YCQCentral); %get the number of timepoints the simulation runs for the patient
MIC1 = 0.067; %mg/L, minimum inhibitory concentration (MIC), NEED TO FIND LITERATURE SUPPORT
MIC2 = 2*MIC1; %mg/L, twice the minimum inhibitory concentration for testing another MIC condition

% kP_vector = zeros(timepoints, patients); %initialize a matrix to hold all the kPs for the simulation
% for j = 1:patients
%     for i = 1:timepoints %need to iterate through every concentration for each patient
%         if YCQCentral(i,j) > MIC1
%             kP_vector(i,j) = .01;
%         end
%     end
% end
% Run Smiulation
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

%% PD: therapeutic effect of (1)dosing variance, (2) varying parasite clearance

%part 1: PK simulation to get drug concentrations for the time course
doseRange = 10; %number of doses to try within the dose limits (defined below)
FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore

%initialize matrices for storing simulation outputs across different doses
CQconc = zeros(length(Time),patients,doseRange);% define zeros that will hold all time points (row), for all patients (column), for each dose choice (depth)
DCQconc = zeros(length(Time),patients,doseRange);
AUCCQ_doses = zeros(patients, doseRange);
AUCDCQ_doses = zeros(patients, doseRange);

for z = 1:doseRange %run simulations for ALL the doses (currently we have 10 dose conditions) 
    [~, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDoseRange(z),SecondDoseRange(z), MissedDose); 
    CQconc(:,:,z) = YCQCentral; %extract the central compartment concentration 
    DCQconc(:,:,z) = YDQCentral; %extract the peripheral compartment concentration
    AUCCQ_doses(:, z) = AUCCQ;
    AUCDCQ_doses(:,z) = AUCDCQ;
end

%% part 2: get parasite values from parasite eqn using CQ concentration
%information

%approach: 
%1. get timestamps for when concentration of CQ falls below the MIC
%(original MIC)
CQconcBelow = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
for dose = 1:doseRange
    for patient = 1: patients
        sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
        if size(find(sample < MIC1, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
        CQconcBelow(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
        else
        CQconcBelow(dose,patient) = Hour_100 + find(sample < MIC1, 1); 
        %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
        end
    end
end

%% 2. break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
%for below MIC, set the kP to one order of manitude lower than the
%patient's original kP, which we pick from a range for each of the patients
%(not dependent on popPK information or bodyweight)

% Part 1 of Simulation, regular kP
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);

%decide what the kP testing range is:
rangekP = 10; %test across 10 possible kPs
kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature

%decide what the tspan is for the first half of the simulation and simulate
%parasite counts
Parasites_at_end = ones(rangekP, doseRange,patients); %hold the final parasite number for each patient, for each dosing condition

for clearanceCounter = 1:rangekP
for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
for patient =1:patients %iterate through all 100 patients
    if CQconcBelow(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
    tspan = 0:.5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
    kP_val = kP(clearanceCounter); %run model using one of the kPs to indicate parasite sensitivity to CQ
    r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
    a = [kP_val r]; %input vector for ODE solver
    %let the parasite burden for all be the same (10^12 starting parasites)
    initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
    [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
    
    %collect information from this simulation into matrix for storage
    Parasites_at_end(clearanceCounter,dose,patient) = P(end,1); %only grab the value from the first column
    
    else %this means that the patient DOES drop below MIC
    %first half of simulation
    droppoint = CQconcBelow(dose,patient); %time point at which the patient's [CQ] drops below MIC
    tspan1 = 0:0.5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
    kP_val = kP(clearanceCounter); %demonstrate model using median kP AT FIRST
    r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
    a = [kP_val r]; %input vector for ODE solver
    initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
    [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
    
    %second half of simulation
    %new tspan1 with new initial conditions and new (lower) kP
    tspan2 = tspan1(end):.06:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
    p00 = P1(end,:);   %get initial conditions vector from first half of simulation
    kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
    r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
    a = [kP_val r];    %input vector for ODE solver
    [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
    
    %sum up total simualation values (both Ttot and Ptot should have same dimensions
    T_tot = [T1; T2];
    P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
    
    %collect information into matrix for storage
    Parasites_at_end(clearanceCounter,dose,patient) = P_tot(end);
    
    end
end
disp('done with dose number:')
disp(dose)
end
disp('done with kP testing number:')
disp(clearanceCounter)
end

%% 4. calculate the number of patients cured using parasite counts at end of simulation
detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
%try for just the first dose (dose 1)
kP_Range = 10; %number of kP's we will try
percentCured = zeros(doseRange, kP_Range); %index position 2 will eventually be filled in by kP value
for clearanceCounter = 1:rangekP
    for dose = 1:doseRange
    below_limit_indexes = find(Parasites_at_end(clearanceCounter,dose,:) < detect_limit);
    [row,col] = size(below_limit_indexes);
    percentCured(dose,clearanceCounter) = 100*row/patients; %find the percentage of total patients that were cured
    end
end

%5. export data to a .mat file for visualization as a heatmap in R


