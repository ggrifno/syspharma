# syspharma
Respository for final project for Systems Pharmacology at JHU.

This Github respository is for sharing and updating files
using Github for the Systems Pharmacology Final Project
Spring 2020.

Group members:
Gabrielle Grifno
Alanna Farrel
SJ Burris

Chloroquine_Driver

Uses:
Chloroquine_Main
Chloroquine_sim

NormalD_Malaria_PK_parameters.mat
NormalD_Malaria_PK_DQCentral.mat
NormalD_Malaria_PK_CQCentral.mat
NormalD_Malaria_PK_AUCDCQ.mat
NormalD_Malaria_PK_AUCCQ.mat
NormalD_COVID_PK_parameters.mat
NormalD_COVID_PK_DQCentral.mat
NormalD_COVID_PK_CQCentral.mat
NormalD_COVID_PK_AUCDCQ.mat
NormalD_COVID_PK_AUCCQ.mat
*Files used in PKPlots.R for plotting.

Produces:

Chloroquine_Driver_MissedDose

Uses:
Chloroquine_Main_MissedDose
Chloroquine_sim_altdosing

Produces:
RunCase 1 -
MissedDose_Malaria_PK_CQCentral.mat
MissedDose_Malaria_PK_DQCentral.mat
Runcase 2 - 
LateDose2_Malaria_PK_CQCentral.mat
LateDose2_Malaria_PK_DQCentral.mat
Runcase 3 -
LateDose3_Malaria_PK_CQCentral.mat
LateDose3_Malaria_PK_DQCentral.mat
LateDose4_Malaria_PK_CQCentral.mat
LateDose4_Malaria_PK_DQCentral.mat
Runcase 4 -

*Files are used for R script Missed_LateDosing.R for plotting.
*Files used for appMalariaVsCovid.R

To run appMalariaVsCovid.R:
1) Run the file Chloroquine_Driver.m in MATLAB so necessary data files are produced
2) Run the file Chloroquine_Driver_MissedDose.m in MATLAB so necessary data files are produced
3) Run the file appMalariaVsCovid.R in R. All necessary data should exist within the folden