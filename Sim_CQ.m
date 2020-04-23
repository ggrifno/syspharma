function [out, out2] = Sim_CQ(weight, ptemp)

%Patient
Weight = weight;

%Dosing
%Could make an if statement: like if dosing =1 malaria dosing
%if dosing = 2 covid dosing or just make a whole different simulation
%for covid

% Dosing Malr
FirstDosing  = 10;  %units - mg/kg
OtherDosing = 5;    %units - mg/kg
FirstDose = FirstDosing*Weight; %units = mg
OtherDose = OtherDosing*Weight;
NumberOfDoses = 4;
SecondDoseTime = 6;  %units: hr, time after first dose, between 6-12 hrs after first
TimeBetween5mgDoses = 24; %units: hr, time after second, and third dose,

%Volume of Distributions

v1 = ptemp(1);     % units = L, central compartment of chloroquine
v2 = ptemp(2);    % units - L, peripheral compartment of chloroquine
v3 = ptemp(3);    % units = L, central compartment of DCQ
v4 = ptemp(4);  % units = L, peripheral compartment of DCQ

%rates (intercompartmental, clearnce, half lives)
CHF = 10.7; %units = days, half-life CQ
DHF = 8.74; %units = days, half-life DCQ

q = 0;
ka = ptemp(7);
k12 = 37.7/v1;   % units = L/h, Chloroquine from central to peripheral
k21 = 37.7/v2;   % units - L/h, chloroquine from peripheral to central
k23 = 6.13/v1;   % units = L/H , CQ transforming to DCQ
k34 = 31.46/v3;  % units = L/h, DCQ from central to peripheral
k43 = 31.46/v4;  % units = L/h, DCQ from peripheral to central
%k10 = log(2)/(CHF*24);      % units, clearance of CQ
k10 = ptemp(5);
%k30 = log(2)/(DHF*24);      %2.04/V3;   % units = 1/h, peripheral compartment of DCQ
k30 = ptemp(6);
%%Set initial conditions
%Set intial concentration in central compartment to 0
%Set innitial concentration of the gut to the dose
%set time framre

y0 = [0 0 FirstDose 0 0 0 0];
% (1) Concentration of CQ in the central compartment
% (2) Concentration of CQ in the peripheral compartment
% (3) Amount of Drug in Virtual Clearance Compartment
% (4) Amount of Drug in Virtual Gut Compartment
% (5) Concentration of DCQ in the central compartment (i.e converstion of
% CQ to DCQ)
% (6) Concentration of DCQ in the peripheral compartment
% (7) Drug Cleared

%%Create parameter array
p = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka];

%%Run Smiulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
tspan1 = 0:.06:6;
[T, Y] = ode45(@Chloroquine_eqns,tspan1,y0,options,p);

MB(:,1) = Y(:,1)*v1; %CQ, CENTRAL
MB(:,2) = Y(:,2)*v2; %CQ, PERIPHERAL
MB(:,3) = Y(:,3);    %AMOUNT GUT
MB(:,4) = Y(:,4)*v3; %DCQ, CENTRAL
MB(:,5) = Y(:,5)*v4; %DCQ, PERIPHERAL
MB(:,6) = Y(:,6);    %CQ CLEARED
MB(:,7) = Y(:,7);    %DCQ CLEARED

%mass Balance for first dose over first time interval
TotalDose = FirstDose;
MassBalance = MB(:,1) + MB(:,2) + MB(:,3) + MB(:,5) + MB(:,4) + MB(:,6)+  MB(:,7) - TotalDose;
TMB = T;

%update initial conditions for next simulation
y00 = Y(end,:);
%add next dose
y00(3) = y00(3) + OtherDose;
TotalDose = TotalDose + OtherDose;
 for i =  1:10
  options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
  tspan = 0:.06:24;
  [t,y] = ode45(@Chloroquine_eqns,tspan,y00,options,p);
  
  %update time and concentration values for entire simulation
  Y  = [Y; y];
  T  = [T;bsxfun(@plus,T(end,:),t)];
  
  %mb = [0 0 0 0 0 0 0];
%   %include mass balance
    mb(:,1) = y(:,1)*v1; %CQ, CENTRAL
    mb(:,2) = y(:,2)*v2; %CQ, PERIPHERAL
    mb(:,3) = y(:,3);    %AMOUNT GUT
    mb(:,4) = y(:,4)*v3; %DCQ, CENTRAL
    mb(:,5) = y(:,5)*v4; %DCQ, PERIPHERAL
    mb(:,6) = y(:,6);    %CQ CLEARED
    mb(:,7) = y(:,7);    %DCQ CLEARED
   
  m = mb(:,1) + mb(:,2) + mb(:,3) + mb(:,5) + mb(:,4) + mb(:,6)+  mb(:,7) - TotalDose;
  MassBalance = [MassBalance;m];
  mb = [];
   %last concentration values become new initial conditions for next
  %dosing simulation
  
  y00 = y(end,:);
  if i < 3
        y00(3) = y00(3) + OtherDose;
        TotalDose = TotalDose + OtherDose;
  end
   
end
out = [Y(:,1),Y(:,4)];
out2 = T;
end