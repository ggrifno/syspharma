%% Systems Pharmacology Final Project Missed Dose
% Authors: Alanna Farrell, Gabrielle Grifno, Sarah Jane Burris

%% Run simulations for different disease and dosing cases
clear all;
RunCase = 4;
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

        
        D = size(T);
         for i = 1:D(1)
             MedianYCQCM0 = [MedianYCQCM0;median(YCQCentralM0(i,:))];
             MedianYCQCM1 = [MedianYCQCM1;median(YCQCentralM1(i,:))];
             MedianYCQCM2 = [MedianYCQCM2;median(YCQCentralM2(i,:))];
             MedianYCQCM3 = [MedianYCQCM3;median(YCQCentralM3(i,:))];
             MedianYCQCM4 = [MedianYDQCM4;median(YDQCentralM4(i,:))];
             MedianYDQCM0 = [MedianYDQCM0;median(YDQCentralM0(i,:))];
             MedianYDQCM1 = [MedianYDQCM1;median(YDQCentralM1(i,:))];
             MedianYDQCM2 = [MedianYDQCM2;median(YDQCentralM2(i,:))];
             MedianYDQCM3 = [MedianYDQCM3;median(YDQCentralM3(i,:))];
             MedianYDQCM4 = [MedianYDQCM4;median(YDQCentralM4(i,:))];
         end
         
        TitleCQ = 'MissedDose_Malaria_PK_CQCentral';
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4')
        TitleDQ ='MissedDose_Malaria_PK_DQCentral';
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4')
        
%                figure; 
% ax1=subplot(1,2,1);
%         plot(T,YCQCentralM0(:,1),'b',T,YCQCentralM1(:,1),'c',T,YCQCentralM2(:,1), 'r',T,YCQCentralM3(:,1), 'm', T, YCQCentralM4(:,1), 'k','linewidth',3)
%         % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
%         title('Chloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Missing the first dose', 'Missing the second dose', 'Missing the third dose', 'Missing the fourth dose')
% 
%          
%         ax1=subplot(1,2,2);
%         plot(T,YDQCentralM0(:,1),'b',T,YDQCentralM1(:,1),'c',T,YDQCentralM2(:,1), 'r',T,YDQCentralM3(:,1), 'm', T, YDQCentralM4(:,1), 'k','linewidth',3)
%         % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
%         title('Desethylchloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Missing the first dose', 'Missing the second dose', 'Missing the third dose', 'Missing the fourth dose')
%         

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
         end
         
        i = 2;
        TitleCQ = sprintf('LateDose%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','MedianYCQCM5')
        TitleDQ =sprintf('LateDose%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','MedianYDQCM5')
        
%         figure; 
%         YCQCentralM0 = YCQCM0(:,1);YCQCentralM1 = YCQCM1(:,1);YCQCentralM2 = YCQCM2(:,1);
%         YCQCentralM3 = YCQCM3(:,1);YCQCentralM4 = YCQCM4(:,1);YCQCentralM5 = YCQCM5(:,1);
%         YDQCentralM0 = YDQCM0(:,1);YDQCentralM1 = YDQCM1(:,1);YDQCentralM2 = YDQCM2(:,1);
%         YDQCentralM3 = YDQCM3(:,1);YDQCentralM4 = YDQCM4(:,1);YDQCentralM5 = YDQCM5(:,1);
% 
%         ax1=subplot(1,2,1);
%         plot(T,YCQCentralM0,'g',T,YCQCentralM1,'c',T,YCQCentralM2, 'r',T,YCQCentralM3, 'm', T, YCQCentralM4, 'b',T, YCQCentralM5, 'k', 'linewidth',2)
%         % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
%         title('Chloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Taking Second Dose 6*1/5 hrs after', 'Taking Second Dose 6*2/5 hrs after', 'Taking Second Dose 6*3/5 hrs after', 'Taking Second Dose 6*4/5 hrs after', 'Taking Second Dose 6 hrs after' )
%         ax1=subplot(1,2,2);
%         plot(T,YDQCentralM0,'g',T,YDQCentralM1,'c',T,YDQCentralM2, 'r',T,YDQCentralM3, 'm', T, YDQCentralM4, 'b',T, YDQCentralM5, 'k', 'linewidth',2)
%         % 'plot' draws lines - T1 as x-axis, Y1 as yYCQCentralM3-axis, 'k' refers to line color
%         title('Desethylchloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Taking Second Dose 6*1/5 hrs after', 'Taking Second Dose 6*2/5 hrs after', 'Taking Second Dose 6*3/5 hrs after', 'Taking Second Dose 6*4/5 hrs after', 'Taking Second Dose 6 hrs after' )
%         
 
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
         end
         
        i = 3;
        TitleCQ = sprintf('LateDose%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','MedianYCQCM5')
        TitleDQ =sprintf('LateDose%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','MedianYDQCM5')
        
%         figure; 
%         YCQCentralM0 = YCQCM0(1:877,1);YCQCentralM1 = YCQCM1(1:877,1);YCQCentralM2 = YCQCM2(1:877,1);
%         YCQCentralM3 = YCQCM3(1:877,1);YCQCentralM4 = YCQCM4(1:877,1);YCQCentralM5 = YCQCM5(1:877,1);
%         YDQCentralM0 = YDQCM0(1:877,1);YDQCentralM1 = YDQCM1(1:877,1);YDQCentralM2 = YDQCM2(1:877,1);
%         YDQCentralM3 = YDQCM3(1:877,1);YDQCentralM4 = YDQCM4(1:877,1);YDQCentralM5 = YDQCM5(1:877,1);
% 
%         ax1=subplot(1,2,1);
%         plot(T,YCQCentralM0,'g',T,YCQCentralM1,'c',T,YCQCentralM2, 'r',T,YCQCentralM3, 'm', T, YCQCentralM4, 'b',T, YCQCentralM5, 'k', 'linewidth',2)
%         % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
%         title('Chloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Taking Third Dose 24*1/5 hrs after', 'Taking Third Dose 24*2/5 hrs after', 'Taking Third Dose 24*3/5 hrs after', 'Taking Third Dose 24*4/5 hrs after', 'Taking Third Dose 24 hrs after' )
%         ax1=subplot(1,2,2);
%         plot(T,YDQCentralM0,'g',T,YDQCentralM1,'c',T,YDQCentralM2, 'r',T,YDQCentralM3, 'm', T, YDQCentralM4, 'b',T, YDQCentralM5, 'k','linewidth',2)
%         % 'plot' draws lines - T1 as x-axis, Y1 as yYCQCentralM3-axis, 'k' refers to line color
%         title('Desethylchloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Taking Third Dose 24*1/5 hrs after', 'Taking Third Dose 24*2/5 hrs after', 'Taking Third Dose 24*3/5 hrs after', 'Taking Third Dose 24*4/5 hrs after', 'Taking Third Dose 24 hrs after' )
%         
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
         end
         
         MedianYDQCM5 = MedianYDQCM5(1:877,:);
         
        i = 4;
        TitleCQ = sprintf('LateDose%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'T', 'MedianYCQCM0','MedianYCQCM1','MedianYCQCM2','MedianYCQCM3','MedianYCQCM4','MedianYCQCM5')
        TitleDQ =sprintf('LateDose%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'T', 'MedianYDQCM0','MedianYDQCM1','MedianYDQCM2','MedianYDQCM3','MedianYDQCM4','MedianYDQCM5')
        
%         figure; 
%         YCQCentralM0 = YCQCM0(1:877,1);
%         YCQCentralM1 = YCQCM1(1:877,1);
%         YCQCentralM2 = YCQCM2(1:877,1);
%         YCQCentralM3 = YCQCM3(1:877,1);
%         YCQCentralM4 = YCQCM4(1:877,1);
%         YCQCentralM5 = YCQCM5(1:877,1);
%         YDQCentralM0 = YDQCM0(1:877,1);
%         YDQCentralM1 = YDQCM1(1:877,1);
%         YDQCentralM2 = YDQCM2(1:877,1);
%         YDQCentralM3 = YDQCM3(1:877,1);
%         YDQCentralM4 = YDQCM4(1:877,1);
%         YDQCentralM5 = YDQCM5(1:877,1);
% 
%         ax1=subplot(1,2,1);
%         plot(T,YCQCentralM0,'g',T,YCQCentralM1,'c',T,YCQCentralM2, 'r',T,YCQCentralM3, 'm', T, YCQCentralM4, 'b',T, YCQCentralM5, 'k', 'linewidth',2)
%         % 'plot' draws lines - T1 as x-axis, Y1 as y-axis, 'k' refers to line color
%         title('Chloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Taking Fourth Dose 24*1/5 hrs after', 'Taking Fourth Dose 24*2/5 hrs after', 'Taking Fourth Dose 24*3/5 hrs after', 'Taking Fourth Dose 24*4/5 hrs after', 'Taking Fourth Dose 24 hrs after' )
%         ax1=subplot(1,2,2);
%         plot(T,YDQCentralM0,'g',T,YDQCentralM1,'c',T,YDQCentralM2, 'r',T,YDQCentralM3, 'm', T, YDQCentralM4, 'b',T, YDQCentralM5, 'k','linewidth',2)
%         % 'plot' draws lines - T1 as x-axis, Y1 as yYCQCentralM3-axis, 'k' refers to line color
%         title('Desethylchloroquine Concentration (Central) Over Time')
%         ylabel('Concentration (mg/L)')
%         xlabel('time (hrs)')
%         legend('Normal','Taking Fourth Dose 24*1/5 hrs after', 'Taking Fourth Dose 24*2/5 hrs after', 'Taking Fourth Dose 24*3/5 hrs after', 'Taking Fourth Dose 24*4/5 hrs after', 'Taking Fourth Dose 24 hrs after' )

end