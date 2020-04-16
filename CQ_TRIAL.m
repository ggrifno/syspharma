%This code is to generate preliminary results using the first draft of QN equations. 
%This will be used as a proof of concept.

%Layout: 
%(1) declare necessary parameters/dosing/timeframe/patient weight
%(2) initiate the simulation (*include mass balance)
%(3) plot concentration across different compartments + mass balance


%%List all parameters:

%Patient
Weight = 50;  %units = kg

% Dosing
Tablet = 250; %units = mg
FirstDose  = 25;  %units - mg/kg
OtherDose = 5;    %units - mg/kg
FDose = FirstDose*Weight; %units = mg
ODose = OtherDose*Weight;
NumberOfDoses = 3;
TimeBetweenDoses = 0;

CHF = 10.7; %units = days, half-life CQ
DHF = 8.74; %units = days, half-life DCQ

q = 0;
ka = 2;


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
k12 = 37.7/V1;   % units = L/h, Chloroquine from central to peripheral
k21 = 37.7/V2;   % units - L/h, chloroquine from peripheral to central
k23 = 6.13/V1;   % units = L/H , CQ transforming to DCQ
k34 = 31.46/V3;  % units = L/h, DCQ from central to peripheral
k43 = 31.46/V4;  % units = L/h, DCQ from peripheral to central
k10 = log(2)/(CHF*V1);      % units, clearance of CQ
k30 = 2.04/V3;   % units = L/h, peripheral compartment of DCQ
kon = 0;
koff = 0;

%%Set initial conditions
%Set intial concentration in central compartment to 0
%Set innitial concentration of the gut to the dose
%set time framre

y0 = [0 0 FDose 0 0 0 0]
% (1) Concentration of CQ in the central compartment
% (2) Concentration of CQ in the peripheral compartment
% (3) Amount of Drug in Virtual Clearance Compartment
% (4) Amount of Drug in Virtual Gut Compartment
% (5) Concentration of DCQ in the central compartment (i.e converstion of
% CQ to DCQ)
% (6) Concentration of DCQ in the peripheral compartment
% (7) Drug Cleared


%%Create parameter array
p = [q V1 V2 V3 V4 k10 k30 k12 k21 k23 k34 k43 ka koff kon];

%%Run Smiulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
[T, Y] = ode45(@Chloroquine_eqns,[0 6],y0,options,p);

%update initial conditions for next simulation
y00 = Y(end,:);
y00(3) = y00(3) + ODose;
 for i =  1:500
  [t,y] = ode45(@Chloroquine_eqns,[0 24],y00,options,p);
  
  %update time and concentration values for entire simulation
  Y  = [Y; y];
  T  = [T;bsxfun(@plus,T(end,:),t)];
  
  %include mass balance
  
  %last concentration values become new initial conditions for next
  %dosing simulation
  y00 = y(end,:);
  y00(3) = y00(3) + ODose;
  if i > 3
        y00(3) = y00(3) - ODose;
  end
end

%% Calculate Mass balance


%% Plot

figure; 
ax1=subplot(4,2,1);
plot(ax1, T, Y(:,1))
title('CQ, Central Compartment')
ylabel('C (nM)')
xlabel('time (hrs)')

ax1=subplot(4,2,2);
plot(ax1,T,Y(:,2))
title(ax1,'CQ, Peripheral Compartment')
ylabel(ax1,'C (nM)')
xlabel(ax1,'time (hrs)')

ax1=subplot(4,2,3);
plot(ax1,T,Y(:,3))
title(ax1,'CQ, gut')
ylabel(ax1,'Amount (nM)')
xlabel(ax1,'time (hrs)')

ax1=subplot(4,2,4);
plot(ax1,T,Y(:,4))
title(ax1,'DCQ, Central Compartment')
ylabel(ax1,'C (nM)')
xlabel(ax1,'time (hrs)')

ax1=subplot(4,2,5);
plot(ax1,T,Y(:,5))
title(ax1,'DCQ, Peripheral Compartment')
ylabel(ax1,'C (nM)')
xlabel(ax1,'time (hrs)')

ax1=subplot(4,2,6);
plot(ax1,T,Y(:,6))
title(ax1,'CQ Cleared')
ylabel(ax1,'[D] (nM)')
xlabel(ax1,'time (hrs)')

ax1=subplot(4,2,7);
plot(ax1,T,Y(:,7))
title(ax1,'DCQ Cleared')
ylabel(ax1,'[D] (nM)')
xlabel(ax1,'time (hrs)')
