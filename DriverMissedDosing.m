%% Systems Pharmacology Final Project DRAFT
% Authors: Alanna Farrell, Gabrielle Grifno, Sarah Jane Burris

%% Run simulations for different disease and dosing cases
clear all;
RunCase = 1;
% 1. Malaria    Missed Dosing
% 2. Malaria    Late Dose, 2
% 3. Malaria    Late Dose, 3


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
        [PatientsData0, T, YCQCentralM0, YDQCentralM0, AUCCQM0, AUCDCQM0] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, DeltaTime, LateDose, DisplayPlots); 
        MissedDose = 1;
        [PatientsData1, T, YCQCentralM1, YDQCentralM1, AUCCQM1, AUCDCQM1] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, DeltaTime, LateDose, DisplayPlots); 
       MissedDose = 2;
        [PatientsData2, T, YCQCentralM2, YDQCentralM2, AUCCQM2, AUCDCQM2] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, DeltaTime, LateDose, DisplayPlots); 
        MissedDose = 3;
        [PatientsData3, T, YCQCentralM3, YDQCentralM3, AUCCQM3, AUCDCQM3] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, DeltaTime, LateDose, DisplayPlots); 
        MissedDose = 4;
        [PatientsData4, T, YCQCentralM4, YDQCentralM4, AUCCQM4, AUCDCQM4] = Chloroquine_Main_MissedDose(DosingRegimen, FirstDosing,OtherDosing, DeltaTime, LateDose, DisplayPlots); 
        figure; 
         
        ax1=subplot(1,2,1);
        plot(T,YCQCentralM0(:,1),'b',T,YCQCentralM1(:,1),'c',T,YCQCentralM2(:,1), 'r',T,YCQCentralM3(:,1), 'm', T, YCQCentralM4(:,1), 'k','linewidth',3)
        % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
        title('Chloroquine Concentration (Central) Over Time')
        ylabel('Concentration (mg/L)')
        xlabel('time (hrs)')
        legend('Normal','Missing the first dose', 'Missing the second dose', 'Missing the third dose', 'Missing the fourth dose')

         
        ax1=subplot(1,2,2);
        plot(T,YDQCentralM0(:,1),'b',T,YDQCentralM1(:,1),'c',T,YDQCentralM2(:,1), 'r',T,YDQCentralM3(:,1), 'm', T, YDQCentralM4(:,1), 'k','linewidth',3)
        % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
        title('Desethylchloroquine Concentration (Central) Over Time')
        ylabel('Concentration (mg/L)')
        xlabel('time (hrs)')
        legend('Normal','Missing the first dose', 'Missing the second dose', 'Missing the third dose', 'Missing the fourth dose')

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

        figure; 
        YCQCentralM0 = YCQCM0(:,1);
        YCQCentralM1 = YCQCM1(:,1);
        YCQCentralM2 = YCQCM2(:,1);
        YCQCentralM3 = YCQCM3(:,1);
        YCQCentralM4 = YCQCM4(:,1);
        YCQCentralM5 = YCQCM5(:,1);

        YDQCentralM0 = YDQCM0(:,1);
        YDQCentralM1 = YDQCM1(:,1);
        YDQCentralM2 = YDQCM2(:,1);
        YDQCentralM3 = YDQCM3(:,1);
        YDQCentralM4 = YDQCM4(:,1);
        YDQCentralM5 = YDQCM5(:,1);


        ax1=subplot(1,2,1);
        plot(T,YCQCentralM0,'g',T,YCQCentralM1,'c',T,YCQCentralM2, 'r',T,YCQCentralM3, 'm', T, YCQCentralM4, 'b',T, YCQCentralM5, 'k', 'linewidth',2)
        % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
        title('Chloroquine Concentration (Central) Over Time')
        ylabel('Concentration (mg/L)')
        xlabel('time (hrs)')
        legend('Normal','Taking Second Dose 6*1/5 hrs after', 'Taking Second Dose 6*2/5 hrs after', 'Taking Second Dose 6*3/5 hrs after', 'Taking Second Dose 6*4/5 hrs after', 'Taking Second Dose 6 hrs after' )
        ax1=subplot(1,2,2);
        plot(T,YDQCentralM0,'g',T,YDQCentralM1,'c',T,YDQCentralM2, 'r',T,YDQCentralM3, 'm', T, YDQCentralM4, 'b',T, YDQCentralM5, 'k', 'linewidth',2)
        % 'plot' draws lines - T1 as x-axis, Y1 as yYCQCentralM3-axis, 'k' refers to line color
        title('Desethylchloroquine Concentration (Central) Over Time')
        ylabel('Concentration (mg/L)')
        xlabel('time (hrs)')
        legend('Normal','Taking Second Dose 6*1/5 hrs after', 'Taking Second Dose 6*2/5 hrs after', 'Taking Second Dose 6*3/5 hrs after', 'Taking Second Dose 6*4/5 hrs after', 'Taking Second Dose 6 hrs after' )
    
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

        figure; 
        YCQCentralM0 = YCQCM0(1:877,1);
        YCQCentralM1 = YCQCM1(1:877,1);
        YCQCentralM2 = YCQCM2(1:877,1);
        YCQCentralM3 = YCQCM3(1:877,1);
        YCQCentralM4 = YCQCM4(1:877,1);
        YCQCentralM5 = YCQCM5(1:877,1);
        YDQCentralM0 = YDQCM0(1:877,1);
        YDQCentralM1 = YDQCM1(1:877,1);
        YDQCentralM2 = YDQCM2(1:877,1);
        YDQCentralM3 = YDQCM3(1:877,1);
        YDQCentralM4 = YDQCM4(1:877,1);
        YDQCentralM5 = YDQCM5(1:877,1);

        ax1=subplot(1,2,1);
        plot(T,YCQCentralM0,'g',T,YCQCentralM1,'c',T,YCQCentralM2, 'r',T,YCQCentralM3, 'm', T, YCQCentralM4, 'b',T, YCQCentralM5, 'k', 'linewidth',2)
        % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
        title('Chloroquine Concentration (Central) Over Time')
        ylabel('Concentration (mg/L)')
        xlabel('time (hrs)')
        legend('Normal','Taking Third Dose 24*1/5 hrs after', 'Taking Third Dose 24*2/5 hrs after', 'Taking Third Dose 24*3/5 hrs after', 'Taking Third Dose 24*4/5 hrs after', 'Taking Third Dose 24 hrs after' )
        ax1=subplot(1,2,2);
        plot(T,YDQCentralM0,'g',T,YDQCentralM1,'c',T,YDQCentralM2, 'r',T,YDQCentralM3, 'm', T, YDQCentralM4, 'b',T, YDQCentralM5, 'k','linewidth',2)
        % 'plot' draws lines - T1 as x-axis, Y1 as yYCQCentralM3-axis, 'k' refers to line color
        title('Desethylchloroquine Concentration (Central) Over Time')
        ylabel('Concentration (mg/L)')
        xlabel('time (hrs)')
        legend('Normal','Taking Third Dose 24*1/5 hrs after', 'Taking Third Dose 24*2/5 hrs after', 'Taking Third Dose 24*3/5 hrs after', 'Taking Third Dose 24*4/5 hrs after', 'Taking Third Dose 24 hrs after' )
    
end