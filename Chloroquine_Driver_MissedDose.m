%% Systems Pharmacology Final Project Missed Dose
% Authors: Alanna Farrell, Gabrielle Grifno, Sarah Jane Burris

%% Run simulations for different disease and dosing cases
clear all;
RunCase = 2;
% 1. Malaria    Missed Dosing
% 2. Malaria    Late Dose, 2
% 3. Malaria    Late Dose, 3
% 4. Malaria    Late Dose, 4


switch RunCase
  
    case 1
% 1. Malaria    Missed Dose
%========================
     
        DosingRegimen = 1;
        FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
        OtherDosing = 5;    %units - mg/kg, now listed in function inputs
        DisplayPlots = 2; %turns plot display of weight distributions OFF for Chloroquine_Main
        LateDose = 0;
        DeltaTime = 0;
        MissedDose = 0;
        [PatientsData0, T, YCQCentralM0, YDQCentralM0, AUCCQM0, AUCDCQM0] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, DeltaTime, LateDose); 
        MissedDose = 1;
        [PatientsData1, T, YCQCentralM1, YDQCentralM1, AUCCQM1, AUCDCQM1] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DeltaTime, LateDose); 
       MissedDose = 2;
        [PatientsData2, T, YCQCentralM2, YDQCentralM2, AUCCQM2, AUCDCQM2] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DeltaTime, LateDose); 
        MissedDose = 3;
        [PatientsData3, T, YCQCentralM3, YDQCentralM3, AUCCQM3, AUCDCQM3] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DeltaTime, LateDose); 
        MissedDose = 4;
        [PatientsData4, T, YCQCentralM4, YDQCentralM4, AUCCQM4, AUCDCQM4] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose,DeltaTime, LateDose); 

                
        MedianYCQCM0 = []; MedianYCQCM1 = []; MedianYCQCM2 = []; MedianYCQCM3 = []; MedianYCQCM4 = []; MedianYCQCM5 = [];
        MedianYDQCM0 = []; MedianYDQCM1 = []; MedianYDQCM2 = []; MedianYDQCM3 = []; MedianYDQCM4 = []; MedianYDQCM5 = [];

        P25YCQCM0 = [];   P25YCQCM1 = [];  P25YCQCM2 = [];  P25YCQCM3 = [];   P25YCQCM4 = [];   P25YCQCM5 = [];
        P25YDQCM0 = [];   P25YDQCM1 = [];  P25YDQCM2 = [];  P25YDQCM3 = [];   P25YDQCM4 = [];   P25YDQCM5 = [];
        P75YCQCM0 = []; P75YCQCM1 = []; P75YCQCM2 = []; P75YCQCM3 = []; P75YCQCM4 = []; P75YCQCM5 = [];
        P75YDQCM0 = []; P75YDQCM1 = []; P75YDQCM2 = []; P75YDQCM3 = []; P75YDQCM4 = []; P75YDQCM5 = [];

        D = size(T);
         for i = 1:D(1)
             MedianYCQCM0 = [MedianYCQCM0;median(YCQCentralM0(i,:))];
             MedianYCQCM1 = [MedianYCQCM1;median(YCQCentralM1(i,:))];
             MedianYCQCM2 = [MedianYCQCM2;median(YCQCentralM2(i,:))];
             MedianYCQCM3 = [MedianYCQCM3;median(YCQCentralM3(i,:))];
             MedianYCQCM4 = [MedianYCQCM4;median(YCQCentralM4(i,:))];
             MedianYDQCM0 = [MedianYDQCM0;median(YDQCentralM0(i,:))];
             MedianYDQCM1 = [MedianYDQCM1;median(YDQCentralM1(i,:))];
             MedianYDQCM2 = [MedianYDQCM2;median(YDQCentralM2(i,:))];
             MedianYDQCM3 = [MedianYDQCM3;median(YDQCentralM3(i,:))];
             MedianYDQCM4 = [MedianYDQCM4;median(YDQCentralM4(i,:))];
             
             P25YCQCM0 = [P25YCQCM0;prctile(YCQCentralM0(i,:),25)];
             P75YCQCM0 = [P75YCQCM0;prctile(YCQCentralM0(i,:),75)];
             P25YCQCM1 = [P25YCQCM1;prctile(YCQCentralM1(i,:),25)];
             P75YCQCM1 = [P75YCQCM1;prctile(YCQCentralM1(i,:),75)];
             P25YCQCM2 = [P25YCQCM2;prctile(YCQCentralM2(i,:),25)];
             P75YCQCM2 = [P75YCQCM2;prctile(YCQCentralM2(i,:),75)];
             P25YCQCM3 = [P25YCQCM3;prctile(YCQCentralM3(i,:),25)];
             P75YCQCM3 = [P75YCQCM3;prctile(YCQCentralM3(i,:),75)];
             P25YCQCM4 = [P25YCQCM4;prctile(YCQCentralM4(i,:),25)];
             P75YCQCM4 = [P75YCQCM4;prctile(YCQCentralM4(i,:),75)];

             
             P25YDQCM0 = [P25YDQCM0;prctile(YDQCentralM0(i,:),25)];
             P75YDQCM0 = [P75YDQCM0;prctile(YDQCentralM0(i,:),75)];
             P25YDQCM1 = [P25YDQCM1;prctile(YDQCentralM1(i,:),25)];
             P75YDQCM1 = [P75YDQCM1;prctile(YDQCentralM1(i,:),75)];
             P25YDQCM2 = [P25YDQCM2;prctile(YDQCentralM2(i,:),25)];
             P75YDQCM2 = [P75YDQCM2;prctile(YDQCentralM2(i,:),75)];
             P25YDQCM3 = [P25YDQCM3;prctile(YDQCentralM3(i,:),25)];
             P75YDQCM3 = [P75YDQCM3;prctile(YDQCentralM3(i,:),75)];
             P25YDQCM4 = [P25YDQCM4;prctile(YDQCentralM4(i,:),25)];
             P75YDQCM4 = [P75YDQCM4;prctile(YDQCentralM4(i,:),75)];

             
         end
         
        
        TitleCQ = 'MissedDose_Malaria_PK_CQCentral';
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','P25YCQCM0','P75YCQCM0','P25YCQCM1','P75YCQCM1','P25YCQCM2','P75YCQCM2','P25YCQCM3','P75YCQCM3', 'P25YCQCM4','P75YCQCM4')
        TitleDQ ='MissedDose_Malaria_PK_DQCentral';
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','P25YDQCM0','P75YDQCM0','P25YDQCM1','P75YDQCM1','P25YDQCM2','P75YDQCM2','P25YDQCM3' ,'P75YDQCM3','P25YDQCM4','P75YDQCM4')

	case 2

        DosingRegimen = 1;
        FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
        OtherDosing = 5;    %units - mg/kg, now listed in function inputs
        DeltaTime = 0;
        MissedDose = 0;
        LateDose = 2;
        %m/5, 2m/5, 3m/5, 4m/5, m hours after the scheduled time.
        [PatientsData0, T, YCQCM0, YDQCM0, AUCCQM0, AUCDCQM0] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.2;
        [PatientsData1, T, YCQCM1, YDQCM1, AUCCQM1, AUCDCQM1] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
       DeltaTime = 0.4;
        [PatientsData2, T, YCQCM2, YDQCM2, AUCCQM2, AUCDCQM2] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.6;
        [PatientsData3, T, YCQCM3, YDQCM3, AUCCQM3, AUCDCQM3] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.8;
        [PatientsData4, T, YCQCM4, YDQCM4, AUCCQM4, AUCDCQM4] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 1;
        [PatientsData5, T1, YCQCM5, YDQCM5, AUCCQM5, AUCDCQM5] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 

        MedianYCQCM0 = []; MedianYCQCM1 = []; MedianYCQCM2 = []; MedianYCQCM3 = []; MedianYCQCM4 = []; MedianYCQCM5 = [];
        MedianYDQCM0 = []; MedianYDQCM1 = []; MedianYDQCM2 = []; MedianYDQCM3 = []; MedianYDQCM4 = []; MedianYDQCM5 = [];

        P25YCQCM0 = [];   P25YCQCM1 = [];  P25YCQCM2 = [];  P25YCQCM3 = [];   P25YCQCM4 = [];   P25YCQCM5 = [];
        P25YDQCM0 = [];   P25YDQCM1 = [];  P25YDQCM2 = [];  P25YDQCM3 = [];   P25YDQCM4 = [];   P25YDQCM5 = [];
        P75YCQCM0 = []; P75YCQCM1 = []; P75YCQCM2 = []; P75YCQCM3 = []; P75YCQCM4 = []; P75YCQCM5 = [];
        P75YDQCM0 = []; P75YDQCM1 = []; P75YDQCM2 = []; P75YDQCM3 = []; P75YDQCM4 = []; P75YDQCM5 = [];
        
        D = size(T);
         for i = 1:D(1)
             MedianYCQCM0 = [MedianYCQCM0;median(YCQCM0(i,:))];
             MedianYCQCM1 = [MedianYCQCM1;median(YCQCM1(i,:))];
             MedianYCQCM2 = [MedianYCQCM2;median(YCQCM2(i,:))];
             MedianYCQCM3 = [MedianYCQCM3;median(YCQCM3(i,:))];
             MedianYCQCM4 = [MedianYCQCM4;median(YCQCM4(i,:))];
             MedianYCQCM5 = [MedianYCQCM5;median(YCQCM5(i,:))];
             MedianYDQCM0 = [MedianYDQCM0;median(YDQCM0(i,:))];
             MedianYDQCM1 = [MedianYDQCM1;median(YDQCM1(i,:))];
             MedianYDQCM2 = [MedianYDQCM2;median(YDQCM2(i,:))];
             MedianYDQCM3 = [MedianYDQCM3;median(YDQCM3(i,:))];
             MedianYDQCM4 = [MedianYDQCM4;median(YDQCM4(i,:))];
             MedianYDQCM5 = [MedianYDQCM5;median(YDQCM5(i,:))];
             
             P25YCQCM0 = [P25YCQCM0;prctile(YCQCM0(i,:),25)];
             P75YCQCM0 = [P75YCQCM0;prctile(YCQCM0(i,:),75)];
             P25YCQCM1 = [P25YCQCM1;prctile(YCQCM1(i,:),25)];
             P75YCQCM1 = [P75YCQCM1;prctile(YCQCM1(i,:),75)];
             P25YCQCM2 = [P25YCQCM2;prctile(YCQCM2(i,:),25)];
             P75YCQCM2 = [P75YCQCM2;prctile(YCQCM2(i,:),75)];
             P25YCQCM3 = [P25YCQCM3;prctile(YCQCM3(i,:),25)];
             P75YCQCM3 = [P75YCQCM3;prctile(YCQCM3(i,:),75)];
             P25YCQCM4 = [P25YCQCM4;prctile(YCQCM4(i,:),25)];
             P75YCQCM4 = [P75YCQCM4;prctile(YCQCM4(i,:),75)];
             P25YCQCM5 = [P25YDQCM5;prctile(YCQCM5(i,:),25)];
             P75YCQCM5 = [P75YDQCM5;prctile(YCQCM5(i,:),75)];

             
             P25YDQCM0 = [P25YDQCM0;prctile(YDQCM0(i,:),25)];
             P75YDQCM0 = [P75YDQCM0;prctile(YDQCM0(i,:),75)];
             P25YDQCM1 = [P25YDQCM1;prctile(YDQCM1(i,:),25)];
             P75YDQCM1 = [P75YDQCM1;prctile(YDQCM1(i,:),75)];
             P25YDQCM2 = [P25YDQCM2;prctile(YDQCM2(i,:),25)];
             P75YDQCM2 = [P75YDQCM2;prctile(YDQCM2(i,:),75)];
             P25YDQCM3 = [P25YDQCM3;prctile(YDQCM3(i,:),25)];
             P75YDQCM3 = [P75YDQCM3;prctile(YDQCM3(i,:),75)];
             P25YDQCM4 = [P25YDQCM4;prctile(YDQCM4(i,:),25)];
             P75YDQCM4 = [P75YDQCM4;prctile(YDQCM4(i,:),75)];
             P25YDQCM5 = [P25YDQCM5;prctile(YDQCM5(i,:),25)];
             P75YDQCM5 = [P75YDQCM5;prctile(YDQCM5(i,:),75)];


         end
         
        i = 2;
        TitleCQ = sprintf('LateDose%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','MedianYCQCM5', 'P25YCQCM0','P75YCQCM0','P25YCQCM1','P75YCQCM1','P25YCQCM2','P75YCQCM2','P25YCQCM3','P75YCQCM3', 'P25YCQCM4','P75YCQCM4','P25YCQCM5','P75YCQCM5')
        TitleDQ =sprintf('LateDose%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','MedianYDQCM5', 'P25YDQCM0','P75YDQCM0','P25YDQCM1','P75YDQCM1','P25YDQCM2','P75YDQCM2', 'P25YDQCM3' , 'P75YDQCM3', 'P25YDQCM4', 'P75YDQCM4','P25YDQCM5', 'P75YDQCM5' )
        
    case 3
        DosingRegimen = 1;
        FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
        OtherDosing = 5;    %units - mg/kg, now listed in function inputs
        DeltaTime = 0;
        MissedDose = 0;
        LateDose = 3;
        
        %m/5, 2m/5, 3m/5, 4m/5, m hours after the scheduled time.
        [PatientsData0, T, YCQCM0, YDQCM0, AUCCQM0, AUCDCQM0] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.2;
        [PatientsData1, T, YCQCM1, YDQCM1, AUCCQM1, AUCDCQM1] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
       DeltaTime = 0.4;
        [PatientsData2, T, YCQCM2, YDQCM2, AUCCQM2, AUCDCQM2] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.6;
        [PatientsData3, T, YCQCM3, YDQCM3, AUCCQM3, AUCDCQM3] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.8;
        [PatientsData4, T, YCQCM4, YDQCM4, AUCCQM4, AUCDCQM4] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
         DeltaTime = 1;
        [PatientsData5, T1, YCQCM5, YDQCM5, AUCCQM5, AUCDCQM5] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        
        MedianYCQCM0 = []; MedianYCQCM1 = []; MedianYCQCM2 = []; MedianYCQCM3 = []; MedianYCQCM4 = []; MedianYCQCM5 = [];
        MedianYDQCM0 = []; MedianYDQCM1 = []; MedianYDQCM2 = []; MedianYDQCM3 = []; MedianYDQCM4 = []; MedianYDQCM5 = [];

        
        P25YCQCM0 = [];   P25YCQCM1 = [];  P25YCQCM2 = [];  P25YCQCM3 = [];   P25YCQCM4 = [];   P25YCQCM5 = [];
        P25YDQCM0 = [];   P25YDQCM1 = [];  P25YDQCM2 = [];  P25YDQCM3 = [];   P25YDQCM4 = [];   P25YDQCM5 = [];
        P75YCQCM0 = []; P75YCQCM1 = []; P75YCQCM2 = []; P75YCQCM3 = []; P75YCQCM4 = []; P75YCQCM5 = [];
        P75YDQCM0 = []; P75YDQCM1 = []; P75YDQCM2 = []; P75YDQCM3 = []; P75YDQCM4 = []; P75YDQCM5 = [];
        
        D = size(T);
         for i = 1:D(1)
             MedianYCQCM0 = [MedianYCQCM0;median(YCQCM0(i,:))];
             MedianYCQCM1 = [MedianYCQCM1;median(YCQCM1(i,:))];
             MedianYCQCM2 = [MedianYCQCM2;median(YCQCM2(i,:))];
             MedianYCQCM3 = [MedianYCQCM3;median(YCQCM3(i,:))];
             MedianYCQCM4 = [MedianYCQCM4;median(YCQCM4(i,:))];
             MedianYCQCM5 = [MedianYCQCM5;median(YCQCM5(i,:))];
             MedianYDQCM0 = [MedianYDQCM0;median(YDQCM0(i,:))];
             MedianYDQCM1 = [MedianYDQCM1;median(YDQCM1(i,:))];
             MedianYDQCM2 = [MedianYDQCM2;median(YDQCM2(i,:))];
             MedianYDQCM3 = [MedianYDQCM3;median(YDQCM3(i,:))];
             MedianYDQCM4 = [MedianYDQCM4;median(YDQCM4(i,:))];
             MedianYDQCM5 = [MedianYDQCM5;median(YDQCM5(i,:))];
             
             P25YCQCM0 = [P25YCQCM0;prctile(YCQCM0(i,:),25)];
             P75YCQCM0 = [P75YCQCM0;prctile(YCQCM0(i,:),75)];
             P25YCQCM1 = [P25YCQCM1;prctile(YCQCM1(i,:),25)];
             P75YCQCM1 = [P75YCQCM1;prctile(YCQCM1(i,:),75)];
             P25YCQCM2 = [P25YCQCM2;prctile(YCQCM2(i,:),25)];
             P75YCQCM2 = [P75YCQCM2;prctile(YCQCM2(i,:),75)];
             P25YCQCM3 = [P25YCQCM3;prctile(YCQCM3(i,:),25)];
             P75YCQCM3 = [P75YCQCM3;prctile(YCQCM3(i,:),75)];
             P25YCQCM4 = [P25YCQCM4;prctile(YCQCM4(i,:),25)];
             P75YCQCM4 = [P75YCQCM4;prctile(YCQCM4(i,:),75)];
             P25YCQCM5 = [P25YDQCM5;prctile(YCQCM5(i,:),25)];
             P75YCQCM5 = [P75YDQCM5;prctile(YCQCM5(i,:),75)];

             
             P25YDQCM0 = [P25YDQCM0;prctile(YDQCM0(i,:),25)];
             P75YDQCM0 = [P75YDQCM0;prctile(YDQCM0(i,:),75)];
             P25YDQCM1 = [P25YDQCM1;prctile(YDQCM1(i,:),25)];
             P75YDQCM1 = [P75YDQCM1;prctile(YDQCM1(i,:),75)];
             P25YDQCM2 = [P25YDQCM2;prctile(YDQCM2(i,:),25)];
             P75YDQCM2 = [P75YDQCM2;prctile(YDQCM2(i,:),75)];
             P25YDQCM3 = [P25YDQCM3;prctile(YDQCM3(i,:),25)];
             P75YDQCM3 = [P75YDQCM3;prctile(YDQCM3(i,:),75)];
             P25YDQCM4 = [P25YDQCM4;prctile(YDQCM4(i,:),25)];
             P75YDQCM4 = [P75YDQCM4;prctile(YDQCM4(i,:),75)];
             P25YDQCM5 = [P25YDQCM5;prctile(YDQCM5(i,:),25)];
             P75YDQCM5 = [P75YDQCM5;prctile(YDQCM5(i,:),75)];



         end
         
        i = 3;
        TitleCQ = sprintf('LateDose%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','MedianYCQCM5')
        TitleDQ =sprintf('LateDose%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','MedianYDQCM5')

        
        TitleCQIQ = sprintf('LateDose%i_Malaria_PK_CQCentral_IQ',i);
        save(TitleCQIQ, 'T', 'P25YCQCM0','P75YCQCM0','P25YCQCM1','P75YCQCM1','P25YCQCM2','P75YCQCM2','P25YCQCM3','P75YCQCM3', 'P25YCQCM4','P75YCQCM4','P25YCQCM5','P75YCQCM5')
        TitleDQIQ =sprintf('LateDose%i_Malaria_PK_CQCentral_IQ',i);
        save(TitleDQIQ, 'T', 'P25YDQCM0','P75YDQCM0','P25YDQCM1','P25YDQCM1','P25YDQCM2','P75YDQCM2', 'P25YDQCM3' , 'P75YDQCM3', 'P25YDQCM4', 'P75YDQCM4','P25YDQCM5', 'P75YDQCM5' )
        
      case 4
        DosingRegimen = 1;
        FirstDosing  = 10;  %units - mg/kg, now listed in function inputs
        OtherDosing = 5;    %units - mg/kg, now listed in function inputs
        DeltaTime = 0;
        MissedDose = 0;
        LateDose = 4;
        
        %m/5, 2m/5, 3m/5, 4m/5, m hours after the scheduled time.
        [PatientsData0, T, YCQCM0, YDQCM0, AUCCQM0, AUCDCQM0] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.2;
        [PatientsData1, T, YCQCM1, YDQCM1, AUCCQM1, AUCDCQM1] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
       DeltaTime = 0.4;
        [PatientsData2, T, YCQCM2, YDQCM2, AUCCQM2, AUCDCQM2] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.6;
        [PatientsData3, T, YCQCM3, YDQCM3, AUCCQM3, AUCDCQM3] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        DeltaTime = 0.8;
        [PatientsData4, T, YCQCM4, YDQCM4, AUCCQM4, AUCDCQM4] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
         DeltaTime = 1;
        [PatientsData5, T1, YCQCM5, YDQCM5, AUCCQM5, AUCDCQM5] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, MissedDose, LateDose, DeltaTime); 
        
        MedianYCQCM0 = []; MedianYCQCM1 = []; MedianYCQCM2 = []; MedianYCQCM3 = []; MedianYCQCM4 = []; MedianYCQCM5 = [];
        MedianYDQCM0 = []; MedianYDQCM1 = []; MedianYDQCM2 = []; MedianYDQCM3 = []; MedianYDQCM4 = []; MedianYDQCM5 = [];
        
        P25YCQCM0 = [];   P25YCQCM1 = [];  P25YCQCM2 = [];  P25YCQCM3 = [];   P25YCQCM4 = [];   P25YCQCM5 = [];
        P25YDQCM0 = [];   P25YDQCM1 = [];  P25YDQCM2 = [];  P25YDQCM3 = [];   P25YDQCM4 = [];   P25YDQCM5 = [];
        P75YCQCM0 = []; P75YCQCM1 = []; P75YCQCM2 = []; P75YCQCM3 = []; P75YCQCM4 = []; P75YCQCM5 = [];
        P75YDQCM0 = []; P75YDQCM1 = []; P75YDQCM2 = []; P75YDQCM3 = []; P75YDQCM4 = []; P75YDQCM5 = [];
        
        D = size(T);
         for i = 1:D(1)
             MedianYCQCM0 = [MedianYCQCM0;median(YCQCM0(i,:))];
             MedianYCQCM1 = [MedianYCQCM1;median(YCQCM1(i,:))];
             MedianYCQCM2 = [MedianYCQCM2;median(YCQCM2(i,:))];
             MedianYCQCM3 = [MedianYCQCM3;median(YCQCM3(i,:))];
             MedianYCQCM4 = [MedianYCQCM4;median(YCQCM4(i,:))];
             MedianYCQCM5 = [MedianYCQCM5;median(YCQCM5(i,:))];
             MedianYDQCM0 = [MedianYDQCM0;median(YDQCM0(i,:))];
             MedianYDQCM1 = [MedianYDQCM1;median(YDQCM1(i,:))];
             MedianYDQCM2 = [MedianYDQCM2;median(YDQCM2(i,:))];
             MedianYDQCM3 = [MedianYDQCM3;median(YDQCM3(i,:))];
             MedianYDQCM4 = [MedianYDQCM4;median(YDQCM4(i,:))];
             MedianYDQCM5 = [MedianYDQCM5;median(YDQCM5(i,:))];
             
             P25YCQCM0 = [P25YCQCM0;prctile(YCQCM0(i,:),25)];
             P75YCQCM0 = [P75YCQCM0;prctile(YCQCM0(i,:),75)];
             P25YCQCM1 = [P25YCQCM1;prctile(YCQCM1(i,:),25)];
             P75YCQCM1 = [P75YCQCM1;prctile(YCQCM1(i,:),75)];
             P25YCQCM2 = [P25YCQCM2;prctile(YCQCM2(i,:),25)];
             P75YCQCM2 = [P75YCQCM2;prctile(YCQCM2(i,:),75)];
             P25YCQCM3 = [P25YCQCM3;prctile(YCQCM3(i,:),25)];
             P75YCQCM3 = [P75YCQCM3;prctile(YCQCM3(i,:),75)];
             P25YCQCM4 = [P25YCQCM4;prctile(YCQCM4(i,:),25)];
             P75YCQCM4 = [P75YCQCM4;prctile(YCQCM4(i,:),75)];
             P25YCQCM5 = [P25YDQCM5;prctile(YCQCM5(i,:),25)];
             P75YCQCM5 = [P75YDQCM5;prctile(YCQCM5(i,:),75)];

             
             P25YDQCM0 = [P25YDQCM0;prctile(YDQCM0(i,:),25)];
             P75YDQCM0 = [P75YDQCM0;prctile(YDQCM0(i,:),75)];
             P25YDQCM1 = [P25YDQCM1;prctile(YDQCM1(i,:),25)];
             P75YDQCM1 = [P75YDQCM1;prctile(YDQCM1(i,:),75)];
             P25YDQCM2 = [P25YDQCM2;prctile(YDQCM2(i,:),25)];
             P75YDQCM2 = [P75YDQCM2;prctile(YDQCM2(i,:),75)];
             P25YDQCM3 = [P25YDQCM3;prctile(YDQCM3(i,:),25)];
             P75YDQCM3 = [P75YDQCM3;prctile(YDQCM3(i,:),75)];
             P25YDQCM4 = [P25YDQCM4;prctile(YDQCM4(i,:),25)];
             P75YDQCM4 = [P75YDQCM4;prctile(YDQCM4(i,:),75)];
             P25YDQCM5 = [P25YDQCM5;prctile(YDQCM5(i,:),25)];
             P75YDQCM5 = [P75YDQCM5;prctile(YDQCM5(i,:),75)];

         end
         
         MedianYDQCM5 = MedianYDQCM5(1:877,:);
         
        i = 4;
        TitleCQ = sprintf('LateDose%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','MedianYCQCM5')
        TitleDQ =sprintf('LateDose%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','MedianYDQCM5')
        
        
        TitleCQIQ = sprintf('LateDose%i_Malaria_PK_CQCentral_IQ',i);
        save(TitleCQIQ, 'T', 'P25YCQCM0','P75YCQCM0','P25YCQCM1','P75YCQCM1','P25YCQCM2','P75YCQCM2','P25YCQCM3','P75YCQCM3', 'P25YCQCM4','P75YCQCM4','P25YCQCM5','P75YCQCM5')
        TitleDQIQ =sprintf('LateDose%i_Malaria_PK_CQCentral_IQ',i);
        save(TitleDQIQ, 'T', 'P25YDQCM0','P75YDQCM0','P25YDQCM1','P25YDQCM1','P25YDQCM2','P75YDQCM2', 'P25YDQCM3' , 'P75YDQCM3', 'P25YDQCM4', 'P75YDQCM4','P25YDQCM5', 'P75YDQCM5' )
        
end