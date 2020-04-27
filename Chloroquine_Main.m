function [PatientsData, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen, FirstDosing,OtherDosing, MissedDose); 


% Systems Pharmacology Final Project Main Driver
% Alanna Farrell, SJ Burris, Gabrielle Grifno
% Spring 2020

% This file creates simulated patients and includes all the parameters for
% running Chlorquine simulations for treatment of Malaria and COVID-19

%%
%This main file will probably become a function that inputs
%a switchcase from the driver file to determine the following:
%(1)if malaria OR COVID is being model
%(2)if there is a missed dose

%so total of four cases?
%% Creating virtual patients: Distribution parameters 

NumberOfSubjects = 50;
% Size of the populations - by making this a parameter, we can easily test 
% the code with small numbers that run quickly, and then run it with 
% larger populations once we're satisfied that it's working.

weightCutOff = 50;  %lbs
% Minumum weight; set to 0 to only remove nonpositives

Male = 1;
Female = 2; % indexing for matrices

%NEED TO JUSTIFY WHY WE CHOSE THESE, these should all be in lbs
means(Male) = 191;
means(Female) = 164.3;
SD(Male) = 61.57;
SD(Female) = 67.32;

ls = {'-b';'-r'}; % linestyles for male, female distributions
GroupName = {'Male','Female'};

%% PART ONE - NORMAL DISTRIBUTIONS 
    
% Generate Normal Distribution lines
x = [1:1:300]; % x = weight, y = density
for i=Male:Female
    y(i,:) = 1/(SD(i)*sqrt(2*pi()))*exp((-(x(:)-means(i)).^2)/(2*SD(i)^2));
end

% Plotting the normal distributions by themselves
figure;
title('Distribution of weights');    
xlabel('weight (lb)');
ylabel('density');
hold on;
for i=Male:Female
	plot (x,y(i,:),ls{i},'LineWidth',3); 
end


%% PART TWO - GENERATE 2 SUBPOPULATIONS USING RANDOM NUMBERS

% Initiate Random Numbers (helpful to make results reproducible)
rng(0,'twister');

% Generate Subpopulations
for i=Male:Female % 2 subpops 
	xtemp = SD(i).*randn(NumberOfSubjects,1)+means(i); 
    % This gives us a first attempt; next we must identify weights below 
    % the cutoff and replace them
    a=length(xtemp(xtemp<=weightCutOff)); % count people below x lb
    cycle = 1;
    while a>0 % if there are any nonpositives, replace them
        fprintf ('series %i, cycle %i, negs %i\n',i,1,a);
        xtemp(xtemp<=50)=SD(i).*randn(a,1)+means(i);        
        a=length(xtemp(xtemp<=weightCutOff)); 
        cycle = cycle + 1;
    end % check again for nonpositives and loop if nec.
    xdist(i,:) = xtemp; % This is the final weight distribution
end

% Output the means, SDs of the simulated populations
simmeans = mean(xdist,2);
simSDs = std(xdist,0,2);
fprintf('Male population, input mean %4.1f, simulated mean %4.1f; input SD %4.1f, simulated SD %4.1f \n',means(Male),simmeans(Male),SD(Male),simSDs(Male))
fprintf('Female population, input mean %4.1f, simulated mean %4.1f; input SD %4.1f, simulated SD %4.1f \n',means(Female),simmeans(Female),SD(Female),simSDs(Female))

for i = Male:Female
	xtemp = round(xdist(i,:)); % xdist here is the list of patient weights for subpopulation i
    for j = 1:length(x)
    	ysamp(i,j) = length(xtemp(xtemp==x(j)))/NumberOfSubjects;
    end
end

% Overlaying normal distributions and the sample distributions
% three panels
figure;
title('Distribution of weights');    
ylabel('density');
xlabel('weight (lb)'); % note how we only need one x-axis label
hold on;
% Note how we generate different linestyles using conditional statements
for i=Male:Female
    plot (x,ysamp(i,:),ls{i},'LineWidth',2);
end
for i=Male:Female
    plot (x,y(i,:),ls{i},'LineWidth',1.5); 
	% did this separately so that these lines come to the front
end

% Boxplots
% Another way of visualizing the sample populations on one panel.
figure;
hold on;
title('Weight distribution - sample subpopulations')
ylabel('Weight (lb)')
boxplot (xdist','Labels',GroupName);

patientID = (1:NumberOfSubjects)';
Weights = xdist'./2.205; %CONVERT WEIGHTS FROM LBS TO KG. SAVE WEIGHTS AS KG AND USE WEIGHTS IN KG FOR SIMULATIONS
save('WeightDistribs.mat','patientID','Weights');

%% Population Pharmacokinetics

%run the popPK sim function to obtain the following for ALL patients,
%inputting only bodyweight
% 1. volume of distribution in compartment 1 (V1)
% 2. volume of distribution in compartment 2 (V2)
% 3. clearance of chloroquine and desethylchloroquine
% 4. absorption of chloroquine from the gut (oral delivery)

%get parameters for patients
[V1CQ, V2CQ, V1DCQ, V2DCQ, CL_CQ, CL_DCQ, KA] = Chloroquine_popPK(Weights);

%%% add array for sex labels
%Create Label Arrays for saving Data files and R Visualization
SexM = []; SexF = [];
%Fill up long arrays with a number of labels equal to the total number of
%subjects in each subpopulation (i.e. equal to NumberOfSubjects)
    for z = 1:NumberOfSubjects
    SexM = [SexM; 'M']; SexF = [SexF; 'F'];
    end
SexLabels = [SexM; SexF];  % Combine both sex labels in one general sex label array
WeightVal = [Weights(:,1);Weights(:,2)]; % store weight values in 1 row, optimal for R visualization 
v1cq = [V1CQ(:,1); V1CQ(:,2);]; 
v2cq = [V2CQ(:,1); V2CQ(:,2);]; 
v1dcq = [V1DCQ(:,1); V1DCQ(:,2);]; 
v2dcq = [V2DCQ(:,1); V2DCQ(:,2);];
K10 = [CL_CQ(:,1); CL_CQ(:,2);]; 
K30 = [CL_DCQ(:,1); CL_DCQ(:,2);]; 
kabs = [KA(:,1); KA(:,2);];
%% Save Data
%Save datafiles for each parameters, with respective labels
PatientsData = [WeightVal, SexLabels, v1cq, v2cq, v1dcq, v2dcq, K10, K30, kabs];

%% Simulation
YCQCentral = []; YDQCentral= []; Time = [];
for i = 1:length(WeightVal) %iterate through both male and female, since WeightVal melts them into one vector
    W = WeightVal(i); %current patient you're looking at
    v1 = v1cq(i); v2 = v2cq(i);
    v3 = v1dcq(i); v4 = v2dcq(i);
    k10 = K10(i); k30 = K30(i);
    ka = kabs(i);
    ptemp = [v1 v2 v3 v4 k10 k30 ka];
    [ytemp, time] = Chloroquine_sim(W, ptemp, DosingRegimen, FirstDosing, OtherDosing, MissedDose);
    Time = time;
    YCQCentral = [YCQCentral, ytemp(:,1)];
    YDQCentral = [YDQCentral, ytemp(:,2)];
    ytemp = [];
end

AUCCQ = trapz(Time,YCQCentral);
AUCDCQ = trapz(Time,YDQCentral);
%% plot statements to visualize popPK simulation
figure; 
for i = 1:NumberOfSubjects
plot(Time(:,1),YCQCentral(:,i),'k')
hold on
end
hold off
