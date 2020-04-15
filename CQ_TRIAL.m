%This code is to generate preliminary results using the first draft of QN equations. 
%This will be used as a proof of concept.

%Layout: 
%(1) declare necessary parameters/dosing/timeframe/patient weight
%(2) initiate the simulation (*include mass balance)
*(3) plot concentration across different compartments + mass balance


%%List all parameters:

%Patient
Weight = 50;  %units = kg

% Dosing
Tablet = 250; %units = mg
DoseC  = 25;  %units - mg/kg
Dose = 25*Weight; %units = mg


%25mg/kg body weight chloroquine phosphate over 3 days
%250 mg chloroquine phosphate per tablet
%10 and 5 mg/kg at 0 and 6-12 hr at day 0**
%6 mg/kg on each day 1 and day 2
%Primaquine, 15 mg base per table
%daily doses of 15mg base/kg body weight daily for 14 days
%*starting from the second day (day 1) of chloroquine treatment

%Volume of Distributions

V1 = 468;     % units = L, central compartment of chloroquine
V2 = 1600;    % units - L, peripheral compartment of chloroquine
V3 = 2.27;    % units = L, central compartment of DCQ
V4 = 566257;  % units = L, peripheral compartment of DCQ

%clearence rates
k12 = 37.7;   % units = L/h, Chloroquine from central to peripheral
k21 = 37.7;   % units - L/h, chloroquine from peripheral to central
k34 = 31.46;  % units = L/h, DCQ from central to peripheral
k43 = 31.46;  % units = L/h, DCQ from peripheral to central
%CCL = 6.13;   % units = L/h, clearance of CQ for transformation into desethlychloroqine?
DCL = 2.04;   % units = L/h, peripheral compartment of DCQ

CHF = 10.7; %units = days, half-life CQ
DHF = 8.74; %units = days, half-life DCQ


%%Set initial conditions
%Set intial concentration in central compartment to 0
%Set innitial concentration of the gut to the dose
%set time framre


%%Create parameter array
p = [];

%%Run Smiulation
%options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% [T, Y] = ode45(@Acet_eqns,[0 TimeLen],y0,options,p);

%% Calculate Mass balance


%% Plot


