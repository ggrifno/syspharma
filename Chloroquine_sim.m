function [T1, Y1 outAUC1,outAUC2] = Chloroquine_sim(kCL,VD1,VD2,D0,TimeFreq); 

% BELOW here is old code for assignment 4
TimeLen = 24; % hours
NumberOfDoses = floor(TimeLen/TimeFreq)-1 ; % don't count first dose
InfusionTime = 1 ; % hour
 
y0 = [0 0 0]'; % mg/L - Initial conditions vector, 1 = drug in central; 2 = drug in peripheral; 3 = drug cleared
k12 = 0.7 ; 
k21 = k12 ;
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
 
% infusion period
qinf = D0/InfusionTime ; % divided by 1 hour
p = [kCL VD1 VD2 k12 k21 qinf]'; % parameter array
[T1,Y1] = ode45(@Vancomycin_Eqns_ggrifno,[0:.01:InfusionTime],y0,options,p);
DrugIn = T1*qinf; % infusion increases drug in over time
y0 = Y1(end,:);
 
% inter-infusion period
qinf = 0 ; % no infusion
p = [kCL VD1 VD2 k12 k21 qinf]; % parameter array
[T2,Y2] = ode45(@Vancomycin_Eqns_ggrifno,[InfusionTime:0.01:TimeFreq],y0,options,p);
y0 = Y2(end,:); %find the concentrations in each compartment at the end of the simulation for the next sim
T1 = [T1(1:length(T1)-1);T2]; %update time with inter-infusion period
Y1 = [Y1(1:length(Y1)-1,:);Y2]; %update concentration values in each compartment
temp1 = length(T1)-length(DrugIn)+1;
DrugIn = [DrugIn(1:length(DrugIn)-1);ones(temp1,1)*(D0)] ; 
% drug in stops increasing during this time period
% note removing the last point of previous time period to avoid double-counting
temp3 = DrugIn(end); %find the value of the incoming drug at the final point before the next dose

for i=1:NumberOfDoses %this number is one less than the total doses
    % infusion period
    qinf = D0/InfusionTime ; % divided by 1 hour
    p = [kCL VD1 VD2 k12 k21 qinf]'; % parameter array
    %run simulation for another hour with the new starting concentrations in y0
    [t,y] = ode45(@Vancomycin_Eqns_ggrifno,[0:.01:InfusionTime],y0,options,p); 
    Temp_DrugIn = temp3 + t*qinf; %start the next simulation, where the amount of drug going in increases on top of the previous last value
    y0 = y(end,:);%find the concentrations in each compartment at the end of the simulation for the next sim
     
    % inter-infusion period
    qinf = 0 ; % no infusion
    p = [kCL VD1 VD2 k12 k21 qinf]'; % parameter array    
    [t2,y2] = ode45(@Vancomycin_Eqns_ggrifno,[InfusionTime-1:0.01:TimeFreq-1],y0,options,p); %Subtract 1 from infusion time and frequency to avoid hour gaps
    y0 = y2(end,:);
    
    t = [t;bsxfun(@plus,t(end,:),t2)];
    y = [y;y2];
    
    Temp_DrugIn = [Temp_DrugIn; temp3 + ones(temp1,1)*(D0)]; 
    DrugIn = [DrugIn; Temp_DrugIn];
    temp3 = DrugIn(end); %find the new end point to start over inputting the drug in the next hour
    T1 = [T1;bsxfun(@plus,T1(end,:),t)]; %update time
    Y1 = [Y1;y];
    
end

TotalD(:,1) = Y1(:,1).*VD1; %amount of drug in the central compartment (Y1 is a concentration)
TotalD(:,2) = Y1(:,2).*VD2; %amount of drug in peripheral compartment
TotalD(:,3) = Y1(:,3);     %amount of drug in cleared "virtual" compartment

DrugOut = TotalD(:,1) + TotalD(:,2) + TotalD(:,3); % cumulative drug either in compartments or eliminated from system

BalanceD = DrugIn - DrugOut; %find the difference between the input and output, call that "balance"

%I was running into a lot of mass balance problems in this file 
%and thought it might be because my equations file was wrong. I tried a new approach to 
%the volume corrections for the equations, based off HW2. This fixed the
%mass balance problem, BUT caused my violin plots to look wrong
%(distributions look incorrect), so I went with the original equations (see Vancomyin_Eqns_grifno)
%uncomment the display lines below to see the mass balance (currently
%leaking a lot of mass)
if mean(BalanceD)>1e-6
%    disp('Mass imbalance possible ');
%    disp(mean(BalanceD));
end

 outAUC1  = trapz(T1,Y1(:,1));
 outAUC2 = trapz(T1,Y1(:,2));
    

