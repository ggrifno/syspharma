function [Parasites_at_end, percentCured, kP, FirstDoseRange, SecondDoseRange] = Chloroquine_Malaria(DosingRegimen, doseRange,rangekP, FirstDosing,OtherDosing,timepoints, patients, MIC,MissedDose)
%File for determining PD response of Malaria plasmodium infection to CQ %administration

%Parameters
MIC1 = MIC; %mg/L, minimum inhibitory concentration (MIC), NEED TO FIND LITERATURE SUPPORT
MIC2 = 2*MIC1; %mg/L, twice the minimum inhibitory concentration for testing another MIC condition

%% PART 1 - PD: therapeutic effect of (1)dosing variance, (2) varying parasite clearance

%part 1: PK simulation to get drug concentrations for the time course
% doseRange = 10; %number of doses to try within the dose limits (defined below)
FirstDoseRange = linspace(FirstDosing,2*FirstDosing, doseRange); %choose a range of first doses to explore, where upper bound is DOUBLE the lower bound
SecondDoseRange = linspace(OtherDosing,2*OtherDosing, doseRange);%choose a range of second doses to explore

%initialize matrices for storing simulation outputs across different doses
CQconc = zeros(length(timepoints),patients,doseRange);% define zeros that will hold all time points (row), for all patients (column), for each dose choice (depth)
% DCQconc = zeros(length(timepoitns),patients,doseRange);
AUCCQ_doses = zeros(patients, doseRange);
% AUCDCQ_doses = zeros(patients, doseRange);

for z = 1:doseRange %run simulations for ALL the doses (currently we have 10 dose conditions) 
    [~,~,~,~,~,~,~,~,~,~,Time,YCQCentral,~,AUCCQ,~] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose);
    CQconc(:,:,z) = YCQCentral; %extract the central compartment concentration 
    AUCCQ_doses(:, z) = AUCCQ;
end

%% PART 2: get parasite values from parasite eqn using CQ concentration
%approach: get timestamps for when concentration of CQ falls below the MIC 
%1. Original MIC
CQconcBelow_MIC1 = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
for dose = 1:doseRange
    for patient = 1: patients
        sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
        if size(find(sample < MIC1, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
        CQconcBelow_MIC1(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
        else
        CQconcBelow_MIC1(dose,patient) = Hour_100 + find(sample < MIC1, 1); 
        %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
        end
    end
end

%(doubled MIC)
CQconcBelow_MIC2 = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
for dose = 1:doseRange
    for patient = 1: patients
        sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
        if size(find(sample < MIC2, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
        CQconcBelow_MIC2(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
        else
        CQconcBelow_MIC2(dose,patient) = Hour_100 + find(sample < MIC2, 1); 
        %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
        end
    end
end

%% 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
%for below MIC, set the kP to one order of manitude lower than the
%patient's original kP, which we pick from a range for each of the patients
%(not dependent on popPK information or bodyweight)

% Part 1 of Simulation, regular kP
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);

%decide what the kP testing range is:
% rangekP = 10; %test across 10 possible kPs
kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature

%decide what the tspan is for the first half of the simulation and simulate
%parasite counts
Parasites_at_end = ones(rangekP, doseRange,patients); %hold the final parasite number for each patient, for each dosing condition

for clearanceCounter = 1:rangekP
for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
for patient =1:patients %iterate through all 100 patients
    if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
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
    droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
    tspan1 = 0:0.5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
    kP_val = kP(clearanceCounter); %demonstrate model using median kP AT FIRST
    r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
    a = [kP_val r]; %input vector for ODE solver
    initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
    [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
    
    %second half of simulation
    %new tspan1 with new initial conditions and new (lower) kP

    tspan2 = tspan1(end):0.5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
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

%% 4.1 calculate the number of patients cured using parasite counts at end of simulation
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

end