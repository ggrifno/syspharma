clear all;

RunCase = 1; % DO NOT RUN CASES 2 AND 4 (missing covid dosing)

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
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 

        TitleP ='NormalD_Malaria_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_Malaria_PK_CQCentral';
        save(TitleCQ, 'YCQCentral')
        TitleDQ ='NormalD_Malaria_PK_DQCentral';
        save(TitleDQ, 'YDQCentral')
    case 2
% 2. COVID-19   Normal Dosing
%========================
     
        DosingRegimen = 2;
        MissedDose = 0; 
        
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 
        
        TitleP ='NormalD_COVID_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_COVID_PK_CQCentral';
        save(TitleCQ, 'YCQCentral')
        TitleDQ ='NormalD_COVID_PK_DQCentral';
        save(TitleDQ, 'YDQCentral')

    case 3
% 3. Malaria    Missed Dose
%========================
     
        DosingRegimen = 1;
        
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 
        
        %UpdateToShowWhichDoseMissed
        i = MissedDose;
   
        TitleP = sprintf('MissedD%i_Malaria_PK_parameters',i);
        save(TitleP, 'PatientsData')
        TitleCQ = sprintf('MissedD%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'YCQCentral')
        TitleDQ =sprintf('MissedD%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'YDQCentral')
    
	case 4
% 4. optimization with bounds 
%========================
     
        DosingRegimen = 2;
        
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 
        %UpdateToShowWhichDoseMissed
        i = MissedDose;
        TitleP = sprintf('MissedD%i_COVID_PK_parameters', i);
        save(TitleP, 'PatientsData')
        TitleCQ = sprintf('MissedD%i_COVID_PK_CQCentral', i);
        save(TitleCQ, 'YCQCentral')
        TitleDQ = sprintf('MissedD%i_COVID_PK_DQCentral', i);
        save(TitleDQ, 'YDQCentral')
           

end

%% Pharmacodynamics: P. vivax infection response to CQ administration

%numbers and mechanism specific to P. vivax
%given information
P0 = 1*10^12; %starting number of parasites
t = linspace(1,100);
low_density = 50; % parasites/uL in bloodstream
med_density = 2*10^3; %parasites/uL in blood
high_density = 2*10^6; % parasites/uL in bloodstream
kP = linspace(1/25,1/110,100)'; %hr-1, clearance rate for parasites treated with chloroquine
P_halflife = 0.693./kP ;
P_double = 24; %hrs, doubling rate for parasites can be anywhere from 1-3 days
P_detectlimit_microscope = 10^8; %detection limit for microscopy techniques, total # of parasites in body
P_detectlimit_PCR = 10^5; %detection limit for PCR, total # of parasites in body

%%Create parameter array for clearance rates based on concentration
kP = zeros(1,NumberOfSubjects); %initialize a matrix to hold all the kPs for the simulation
[timepoints, ~] = size(YCQCentral); %get the number of timepoints the simulation runs for the patient
MIC = 67; %ug/L, minimum inhibitory concentration (MIC)
for i = 1:timepoints %need to iterate through every concentration for each patient
    while YCQ(i) > MIC
    
end
%%Run Smiulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
tspan = 0:.06:24; %simulate first 24 hours
[T, Y] = ode45(@Parasite_eqns,tspan,P0,options,a);

%% Build PD model
%inputs: level of parasite to start, parasite clearance rate
%output: PRR, parasite reduction ratio, which is the fractional reduction
%in parasite numbers per axsexual cycle, or the reciprocal of ring-form kP
%per cycle

%load in concentration data from choloroquine PK simulation
% load("Chloroquine_PK", '-mat')
%we care about the time and the central compartment values of CQ

%FUNCTIONS
% Pt = P0*exp(-kP*t); 
%Pt = paritemia level at any time after starting treatment
%P0 = starting parasite level
%kP = first-order parasite elmination rate constant
%t = time
% k = kmax*(C^n/EC50^n + C^n); 
%k = parasite killing rate
%kmax = maximum parasite killing rate (i.e. max effect or Emax)
%C = concentration of CQ in the plasma
%EC50 is the plasma concentration resulting in 50% of the maximum effect
% n is a parameter defining the steepness of the dose-response relationship
figure;
for i = 1:100
    hold on
    Pt = P0.*exp(-kP(i).*t);
    plot(t, Pt, 'k')
    legend('kP(i)')
end
hold off