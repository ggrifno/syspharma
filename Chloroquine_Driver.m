clear all;

RunCase = 1; % DO NOT RUN CASES 2 AND 4 (missing covid dosing)

% 1. Malaria    Normal Dosing
% 2. COVID-19   Normal Dosing
% 3. Malaria    Missed Dose
% 4. COVID-19   Missed Dose

MissedDose = 1; %only applies to cases 3 and 4
%Dosing Schedule:
%  1 = miss first dose   4 = miss fourth dose
%  2 = miss second dose  3 = miss third dose

%%%Could add to change number of subjects?
switch RunCase
  
    case 1
% 1. Malaria    Normal Dosing
%========================

        DosingRegimen = 1;
        MissedDose = 0;
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 

        TitleP ='NormalD_Malaria_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_Malaria_PK_CQCentral';
        save(TitleCQ, 'YCQCentral')
        TitleDQ ='NormalD_Malaria_PK_DQCentral';
        save(TitleDQ, 'YDQCentral')
    case 2
% 2. COVID-19   Normal Dosing
%========================
     
        DosingRegimen = 2;
        MissedDose = 0; 
        
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 
        
        TitleP ='NormalD_COVID_PK_parameters';
        save(TitleP, 'PatientsData')
        TitleCQ ='NormalD_COVID_PK_CQCentral';
        save(TitleCQ, 'YCQCentral')
        TitleDQ ='NormalD_COVID_PK_DQCentral';
        save(TitleDQ, 'YDQCentral')

    case 3
% 3. Malaria    Missed Dose
%========================
     
        DosingRegimen = 1;
        
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 
        
        %UpdateToShowWhichDoseMissed
        i = MissedDose;
   
        TitleP = sprintf('MissedD%i_Malaria_PK_parameters',i);
        save(TitleP, 'PatientsData')
        TitleCQ = sprintf('MissedD%i_Malaria_PK_CQCentral',i);
        save(TitleCQ, 'YCQCentral')
        TitleDQ =sprintf('MissedD%i_Malaria_PK_DQCentral',i);
        save(TitleDQ, 'YDQCentral')
    
	case 4
% 4. optimization with bounds 
%========================
     
        DosingRegimen = 2;
        
        [PatientsData, YCQCentral, YDQCentral] = Chloroquine_Main(DosingRegimen, MissedDose); 
        %UpdateToShowWhichDoseMissed
        i = MissedDose;
        TitleP = sprintf('MissedD%i_COVID_PK_parameters', i);
        save(TitleP, 'PatientsData')
        TitleCQ = sprintf('MissedD%i_COVID_PK_CQCentral', i);
        save(TitleCQ, 'YCQCentral')
        TitleDQ = sprintf('MissedD%i_COVID_PK_DQCentral', i);
        save(TitleDQ, 'YDQCentral')
           

end
