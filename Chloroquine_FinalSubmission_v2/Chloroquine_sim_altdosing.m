function [Yout, Tout] = Chloroquine_sim_altdosing(weight, p, DosingRegimen, FirstDosing, OtherDosing, MissedDose, LateDose, DeltaTime)

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
%     FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
%     OtherDosing = 5;    %units - mg/kg, now listed in function inputs
    FirstDose = FirstDosing*Weight; %units = mg
    OtherDose = OtherDosing*Weight;
    TotalDrug = 0;
    if MissedDose == 1
        FirstDose = 0;
    end
    SecondDoseTime = 6;  %units: hr, time after first dose, between 6-12 hrs after first
    TimeBetweenDoses = 24; %units: hr, time after second, and third dose,
 
else
    % UPDATE TO COVID DOSING
    NumberOfDoses = 10;
    FirstDose = FirstDosing; %units = mg fIXED DOSE
    if MissedDose == 1
        FirstDose = 0;
    end
    OtherDose = OtherDosing; %units = mg fIXED DOSE
    TotalDrug=0;
    SecondDoseTime = 12;  %units: hr, time after first dose
    TimeBetweenDoses = 12; %units: hr, time after second, and third dose,
end

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
%%Extract values from parameter vector that is inputted
% p = [q v1 v2 v3 v4 k10 k30 k12 k21 k23 k34 k43 ka];
q = p(1);
v1 = p(2);
v2 = p(3);
v3 = p(4);
v4 = p(5);
k10 = p(6);
k30 = p(7);
k12 = p(8);
k21 = p(9);
k23 = p(10);
k34 = p(11);
k43 = p(12);
ka = p(13);

%%Run Smiulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);

% if the second dose is late, run the simulation for the late period,
% otherwise run to the schedule time of the second dose
if LateDose == 2
SecondDoseTime = SecondDoseTime + DeltaTime*SecondDoseTime;
end
tspan1 = 0:.2:SecondDoseTime; %set time frame
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

%  for i =  1:21 %observe over 21 days for full timecourse
for i =  1:7 %observe over only 7 days for global sensitivity
  options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
  
  tspan = 0:.2:(TimeBetweenDoses);
  LateDoseAdded = 0;
  if i == 1 && LateDose == 2
  tspan = 0:.2:(TimeBetweenDoses-SecondDoseTime); %set time frame
  end

%   if i == 1 && LateDose == 3
  if (LateDose - i) == 2
     Change = TimeBetweenDoses*DeltaTime;
     tspan = 0:.2:(TimeBetweenDoses+Change);
  end
  
  if i == 2 && LateDose == 3
    Change = TimeBetweenDoses*DeltaTime;
    tspan = 0:.2:(TimeBetweenDoses-Change);
    if (TimeBetweenDoses-Change) == 0
        LateDoseAdded = 1;
        y00(3) = y00(3) + OtherDose;
        tspan = 0:.2:(TimeBetweenDoses*2);
        i = i+1;
    end
  end

  if i == 3 && LateDose == 4
    Change = TimeBetweenDoses*DeltaTime;
    tspan = 0:.2:(TimeBetweenDoses-Change);
     if (TimeBetweenDoses-Change) == 0
         LateDoseAdded = 1;
         tspan = 0:.2:(TimeBetweenDoses*2);
         i = i+1;
   end
  end
  

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

  if (MissedDose ~= (i + 2)) && (i < (NumberOfDoses-1) && LateDoseAdded == 0)
        y00(3) = y00(3) + OtherDose;
        TotalDrug = TotalDrug + OtherDose;
 
  end
  
 end
Yout = [Y(:,1),Y(:,4)];
Tout = T;

end