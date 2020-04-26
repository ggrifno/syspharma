function [out, out2] = Chloroquine_sim(weight, ptemp, DosingRegimen, MissedDose)

%Patient
Weight = weight;

%Dosing
%Could make an if statement: like if dosing =1 malaria dosing
%if dosing = 2 covid dosing or just make a whole different simulation
%for covid
%% Set Dosing Regimen
% Dosing Malaria
if DosingRegimen == 1
    NumberOfDoses = 4;
    FirstDosing  = 10;  %units - mg/kg
    OtherDosing = 5;    %units - mg/kg
    FirstDose = FirstDosing*Weight; %units = mg
    OtherDose = OtherDosing*Weight;
    TotalDrug = 0;
    if MissedDose == 1
        FirstDose = 0;
    end
    SecondDoseTime = 6;  %units: hr, time after first dose, between 6-12 hrs after first
    TimeBetweenDoses = 24; %units: hr, time after second, and third dose,
 
else
    %5 UPDATE TO COVID DOSING
    NumberOfDoses = 4;
    FirstDosing  = 10;  %units - mg/kg
    OtherDosing = 5;    %units - mg/kg
    FirstDose = FirstDosing*Weight; %units = mg
    if MissedDose == 1
        FirstDose = 0;
    end
    OtherDose = OtherDosing*Weight;
    SecondDoseTime = 6;  %units: hr, time after first dose, between 6-12 hrs after first
    TimeBetweenDoses = 24; %units: hr, time after second, and third dose,

end

%% Set Patient Parameters
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

%% Set Initial Conditions for the simulation, First dose
y0 = [0 0 FirstDose 0 0 0 0];
% (1) Concentration of CQ in the central compartment
% (2) Concentration of CQ in the peripheral compartment
% (3) Amount of Drug in Virtual Gut Compartment
% (4) Concentration of DCQ in the central compartment
% (5) Concentration of DCQ in the peripheral compartment
% (6) Amount of CQ Drug in Virtual Clearance Compartment
% (7) Amount of DCQ in Virtual Clearance Compartment
TotalDrug = TotalDrug + FirstDose;
%%Create parameter array
p = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka];

%%Run Smiulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
tspan1 = 0:.06:SecondDoseTime;
[T, Y] = ode45(@Chloroquine_eqns,tspan1,y0,options,p);

MB(:,1) = Y(:,1)*v1; %CQ, CENTRAL
MB(:,2) = Y(:,2)*v2; %CQ, PERIPHERAL
MB(:,3) = Y(:,3);    %AMOUNT GUT
MB(:,4) = Y(:,4)*v3; %DCQ, CENTRAL
MB(:,5) = Y(:,5)*v4; %DCQ, PERIPHERAL
MB(:,6) = Y(:,6);    %CQ CLEARED
MB(:,7) = Y(:,7);    %DCQ CLEARED

%mass Balance for first dose over first time interval
MassBalance = MB(:,1) + MB(:,2) + MB(:,3) + MB(:,5) + MB(:,4) + MB(:,6)+  MB(:,7) - TotalDrug;
TMB = T;

%update initial conditions for next simulation
y00 = Y(end,:);
%add next dose if its not missed
if MissedDose ~= 2
    y00(3) = y00(3) + OtherDose;
    TotalDrug = TotalDrug + OtherDose;
end

 for i =  1:10
  options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
  tspan = 0:.06:TimeBetweenDoses;
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
   
  m = mb(:,1) + mb(:,2) + mb(:,3) + mb(:,5) + mb(:,4) + mb(:,6)+  mb(:,7) - TotalDrug;
  MassBalance = [MassBalance;m];
  mb = [];
   %last concentration values become new initial conditions for next
  %dosing simulation
  
  y00 = y(end,:);
  if (MissedDose ~= (i + 2)) && (i < (NumberOfDoses-1))
        y00(3) = y00(3) + OtherDose;
        TotalDrug = TotalDrug + OtherDose;
  end
  
 end
out = [Y(:,1),Y(:,4)];
out2 = T;

end