%File for determining PD response of Malaria plasmodium infection to CQ
%administration

%numbers and mechanism specific to P. vivax
%given information
P0 = 1*10^12; %starting number of parasites
low_density = 50; % parasites/uL in bloodstream
med_density = 2*10^3 %parasites/uL in blood
high_density = 2*10^6; % parasites/uL in bloodstream
kP = ;
P_halflife = 0.693/kP ;
P_double = 24; %hrs, doubling rate for parasites can be anywhere from 1-3 days
P_detectlimit_microscope = 10^8; %detection limit for microscopy techniques, total # of parasites in body
P_detectlimit_PCR = 10^5; %detection limit for PCR, total # of parasites in body

%% Build model
%inputs: level of parasite to start, parasite clearance rate
%output: PRR, parasite reduction ratio, which is the fractional reduction
%in parasite numbers per axsexual cycle, or the reciprocal of ring-form kP
%per cycle

%FUNCTIONS
Pt = P0*exp(-kP*t); 
%Pt = paritemia level at any time after starting treatment
%P0 = starting parasite level
%kP = first-order parasite elmination rate constant
%t = time
k = kmax*(C^n/EC50^n + C^n); 
%k = parasite killing rate
%kmax = maximum parasite killing rate (i.e. max effect or Emax)
%C = concentration of CQ in the plasma
%EC50 is the plasma concentration resulting in 50% of the maximum effect
% n is a parameter defining the steepness of the dose-response relationship

%load in concentration data from choloroquine PK simulation

load("Chloroquine_PK", '-mat')
%we care about the time and the central compartment values 