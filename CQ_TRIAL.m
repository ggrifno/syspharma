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
NumberOfDoses = 3;
TimeBetweenDoses = 0;


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
V5 = 0;       % is there a volume for the gut? absportion?

%clearence rates
k12 = 37.7;   % units = L/h, Chloroquine from central to peripheral
k21 = 37.7;   % units - L/h, chloroquine from peripheral to central
k23 = 6.13;      % units = , CQ transforming to DCQ
k34 = 31.46;  % units = L/h, DCQ from central to peripheral
k43 = 31.46;  % units = L/h, DCQ from peripheral to central
k10 = 0;      % units, clearance of CQ
k30 = 2.04;   % units = L/h, peripheral compartment of DCQ

CHF = 10.7; %units = days, half-life CQ
DHF = 8.74; %units = days, half-life DCQ


%%Set initial conditions
%Set intial concentration in central compartment to 0
%Set innitial concentration of the gut to the dose
%set time framre

y0 = [Dose/V5 0 0 0 0 0]
% (1) Concentration of CQ in the gut  (2) concentration of CQ in the central compartment
% (3) Concentration of CQ in the peripheral compartment
% (4) Concentration of DCQ in the central compartment
% (5) Concentration of DCQ in the peripheral compartment
% (6) Drug Cleared


%%Create parameter array
p = [];

%%Run Smiulation
%options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
[T1, Y1] = ode45(@Acet_eqns,[0 TimeLen],y0,options,p);

T = [T; T1];
Y = [Y, Y1];
%update initial conditions for next simulation
y00 = [];
for i = 2:NumberOfDoses
  [t,y] = ode45(@CQ_eqns,[0 TimeBetweenDoses],y00,options,p);
  
  %update time and concentration values for entire simulation
  T = [T; t];
  Y = [Y; y];
  
  %include mass balance
  
  %last concentration values become new initial conditions for next
  %dosing simulation
  y00 = y(end,:);
end

%% Calculate Mass balance


%% Plot


