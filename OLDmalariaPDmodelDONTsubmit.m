% %% FIGURE 1 - PD: therapeutic effect of (1)dosing variance, (2) varying parasite clearance
% 
% %part 1: PK simulation to get drug concentrations for the time course
% doseRange = 10; %number of doses to try within the dose limits (defined below)
% FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% 
% 
% %initialize matrices for storing simulation outputs across different doses
% CQconc = zeros(length(Time),patients,doseRange);% define zeros that will hold all time points (row), for all patients (column), for each dose choice (depth)
% DCQconc = zeros(length(Time),patients,doseRange);
% AUCCQ_doses = zeros(patients, doseRange);
% AUCDCQ_doses = zeros(patients, doseRange);
% 
% for z = 1:doseRange %run simulations for ALL the doses (currently we have 10 dose conditions) 
%     [~, Time, YCQCentral, YDQCentral, AUCCQ, AUCDCQ] = Chloroquine_Main(DosingRegimen,FirstDoseRange(z),SecondDoseRange(z), MissedDose); 
%     CQconc(:,:,z) = YCQCentral; %extract the central compartment concentration 
%     DCQconc(:,:,z) = YDQCentral; %extract the peripheral compartment concentration
%     AUCCQ_doses(:, z) = AUCCQ;
%     AUCDCQ_doses(:,z) = AUCDCQ;
% end
% 
% %% FIGURE 1 Part 2: get parasite values from parasite eqn using CQ concentration
% %approach: 
% %1 get timestamps for when concentration of CQ falls below the MIC
% %(original MIC)
% CQconcBelow_MIC1 = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
% Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
% for dose = 1:doseRange
%     for patient = 1: patients
%         sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
%         if size(find(sample < MIC1, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
%         CQconcBelow_MIC1(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
%         else
%         CQconcBelow_MIC1(dose,patient) = Hour_100 + find(sample < MIC1, 1); 
%         %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
%         end
%     end
% end
% 
% %(doubled MIC)
% CQconcBelow_MIC2 = zeros(doseRange, patients); %contains the indicies in each timecourse, for each patient, for each dosage, where [CQ] drops below MIC  
% Hour_100 = 1672; %the index of the time vector that is approximately 100 hours into the 500 total hour simulation
% for dose = 1:doseRange
%     for patient = 1: patients
%         sample = CQconc(Hour_100:end,patient,dose); %select the patient's concentration timecourse for each dosage, after about the first 100 hours (after time index is 1672)
%         if size(find(sample < MIC2, 1)) == [0,1] %"find" will return an empty vector sometimes which cannot be added to CQconcBelow
%         CQconcBelow_MIC2(dose,patient) = 0; %add a zero here as a placeholder, this will mean that the patient never dropped below MIC1
%         else
%         CQconcBelow_MIC2(dose,patient) = Hour_100 + find(sample < MIC2, 1); 
%         %collect the index of the FIRST location in the patient's total timecourse where conentration drops below MIC, AFTER the first 50 hours when dose fluxates wildly
%         end
%     end
% end
% 
% %% 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% %decide what the kP testing range is:
% rangekP = 10; %test across 10 possible kPs
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% 
% %decide what the tspan is for the first half of the simulation and simulate
% %parasite counts
% Parasites_at_end = ones(rangekP, doseRange,patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for clearanceCounter = 1:rangekP
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:.5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(clearanceCounter); %run model using one of the kPs to indicate parasite sensitivity to CQ
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_end(clearanceCounter,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:0.5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(clearanceCounter); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan1 with new initial conditions and new (lower) kP
% %     tspan2 = tspan1(end):.06:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     tspan2 = tspan1(end):0.5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_end(clearanceCounter,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with kP testing number:')
% disp(clearanceCounter)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured = zeros(doseRange, kP_Range); %index position 2 will eventually be filled in by kP value
% for clearanceCounter = 1:rangekP
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_end(clearanceCounter,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured(dose,clearanceCounter) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save figA1.mat percentCured kP totalDose;
% 
% %% 2.2 MIC2: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% %decide what the kP testing range is:
% rangekP = 10; %test across 10 possible kPs
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% 
% %decide what the tspan is for the first half of the simulation and simulate
% %parasite counts
% Parasites_at_end2 = ones(rangekP, doseRange,patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for clearanceCounter = 1:rangekP
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC2(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:.5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(clearanceCounter); %run model using one of the kPs to indicate parasite sensitivity to CQ
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_end2(clearanceCounter,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC2(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:0.5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(clearanceCounter); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan1 with new initial conditions and new (lower) kP
% %     tspan2 = tspan1(end):.06:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     tspan2 = tspan1(end):0.5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_end2(clearanceCounter,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with kP testing number:')
% disp(clearanceCounter)
% end
% 
% %% 4.2 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured2 = zeros(doseRange, kP_Range); %index position 2 will eventually be filled in by kP value
% for clearanceCounter = 1:rangekP
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_end2(clearanceCounter,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured2(dose,clearanceCounter) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.2 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save figA2.mat percentCured kP totalDose;
% 
% %% FIGURE 2A: DOSE V. STARTING PARASITE BURDEN, MIC = 1
% 
% % 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig2a = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP_median; %run model using the median kP for ALL patients
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP_median; %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured2a = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig2a(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured2a(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig2A.mat percentCured2a  P0_vector totalDose;
% 
% %% FIGURE 2B: DOSE V. STARTING BURDEN USING MIC 2
% %USE MIC 2
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig2B = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC2(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP_median; %run model using the median kP for ALL patients
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig2B(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC2(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP_median; %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig2B(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured2B = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig2B(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured2B(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig2B.mat percentCured2B  P0_vector totalDose;
% 
% %% FIGURE 3A: DOSE V. STARTING PARASITE BURDEN WITH DECREASING KP, MIC = 1
% 
% % 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig2a = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC1(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(burden); %run model using decreasing kP for increasing parasite burden
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC1(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(burden); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig2a(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured3a = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig2a(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured3a(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig3A.mat percentCured3a  P0_vector totalDose;
% 
% %% FIGURE 3B: DOSE V. STARTING PARASITE BURDEN WITH DECREASING KP, MIC = 2
% 
% % 2.1 MIC1: break the parasite dynamics simulation into two parts, above MIC and %below MIC. 
% %for below MIC, set the kP to one order of manitude lower than the
% %patient's original kP, which we pick from a range for each of the patients
% %(not dependent on popPK information or bodyweight)
% 
% % Part 1 of Simulation, regular kP
% options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
% 
% kP = linspace(1/25,1/110,rangekP)'; %hr-1, test across 10 possible kPs in the range reported in the literature
% kP_median = median(kP); %we will use the median for all the parasite burden simulations
% %decide what the parasite burden testing range is:
% rangeBurden = 10; %test across 10 possible initial burdens
% P0_vector1 = logspace(8,17,rangeBurden)'; %test 10 different initial parasite that increase by orders of magnitude
% 
% %parasite counts
% Parasites_at_endfig3b = ones(rangeBurden, doseRange, patients); %hold the final parasite number for each patient, for each dosing condition
% 
% for burden = 1:rangeBurden %iterate through all the starting parasite burdens
% for dose = 1:doseRange %iterate through all the CQ dose settings (ten total)
% for patient =1:patients %iterate through all 100 patients
%     if CQconcBelow_MIC2(dose,patient) ==0 %just looking at all 100 patients for the first dose condition (dose conditions 1/10)
%     tspan = 0:5:500; %if the patient never drops below MIC, simulate ALL observation time (500 hours)
%     kP_val = kP(burden); %run model using decreasing kP for increasing parasite burden
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     %let the parasite burden for all be the same (10^12 starting parasites)
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T, P] = ode45(@Parasite_eqns,tspan,initial_P0,options,a); %parasite diffeq model
%     
%     %collect information from this simulation into matrix for storage
%     Parasites_at_endfig3b(burden,dose,patient) = P(end,1); %only grab the value from the first column
%     
%     else %this means that the patient DOES drop below MIC
%     %first half of simulation
%     droppoint = CQconcBelow_MIC2(dose,patient); %time point at which the patient's [CQ] drops below MIC
%     tspan1 = 0:5:Time(droppoint,1); %index the Time vector get the TIME (in hrs) where the conc falls below 0 
%     kP_val = kP(burden); %demonstrate model using median kP AT FIRST
%     r = 0.009625;   %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r]; %input vector for ODE solver
%     initial_P0 = [P0_vector1(burden) 0 0]; %take in the starting # of parasites, and let number in cleared and growth "compartments" be zero
%     [T1, P1] = ode45(@Parasite_eqns,tspan1,initial_P0,options,a); %parasite diffeq model
%     
%     %second half of simulation
%     %new tspan with new initial conditions and new (lower) kP
%     tspan2 = tspan1(end):5:Time(end)+10; %new tspan goes from end of first tspan to end of simulation PLUS an additional 10 hours (520 total hours, 10 hours longer than CQ simulation, which goes to 510 hours)
%     p00 = P1(end,:);   %get initial conditions vector from first half of simulation
%     kP_val = kP_val/10;%kP for the simulation will drops by 1 order of magnitude as CQ is no longer effective in reducing parasites
%     r = 0.009625;      %hr-1; let the growth rate of the parasite be double every 3 days = .693/72hr
%     a = [kP_val r];    %input vector for ODE solver
%     [T2, P2] = ode45(@Parasite_eqns,tspan2,p00,options,a); %parasite diffeq model
%     
%     %sum up total simualation values (both Ttot and Ptot should have same dimensions
%     T_tot = [T1; T2];
%     P_tot = [P1(:,1); P2(:,1)]; %only grab the TOTAL parasites, which are stored in first colume of ODE parasite output
%     
%     %collect information into matrix for storage
%     Parasites_at_endfig3b(burden,dose,patient) = P_tot(end);
%     
%     end
% end
% disp('done with dose number:')
% disp(dose)
% end
% disp('done with BURDEN testing number:')
% disp(burden)
% end
% 
% %% 4.1 calculate the number of patients cured using parasite counts at end of simulation
% detect_limit = 10^9; %set the detection limit high at first for proof-of-concept
% %try for just the first dose (dose 1)
% kP_Range = 10; %number of kP's we will try
% percentCured3b = zeros(doseRange, rangeBurden); %index position 2 will eventually be filled in by kP value
% for burden = 1:rangeBurden
%     for dose = 1:doseRange
%     below_limit_indexes = find(Parasites_at_endfig3b(burden,dose,:) < detect_limit);
%     [row,col] = size(below_limit_indexes);
%     percentCured3b(dose,burden) = 100*row/patients; %find the percentage of total patients that were cured
%     end
% end
% 
% %% 5.1 export data to a .mat file for visualization as a heatmap in R
% % FirstDoseRange = linspace(15,30, doseRange); %choose a range of first doses to explore
% % SecondDoseRange = linspace(5,10, doseRange);%choose a range of second doses to explore
% totalDose = FirstDoseRange' + 3.*SecondDoseRange'; %mg/kg 
% save fig3B.mat percentCured3b  P0_vector totalDose;
