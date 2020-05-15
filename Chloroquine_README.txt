# syspharma
Respository for final project for Systems Pharmacology at JHU.

This Github respository is for sharing and updating files
using Github for the Systems Pharmacology Final Project
Spring 2020.

Group members:
Gabrielle Grifno
Alanna Farrel
SJ Burris

INSTRUCTIONS AND NOTES

MATLAB AND REGULAR R FILES

1. Chloroquine_Driver.m

Uses these functions:
Chloroquine_Main
Chloroquine_sim

RUN INSTRUCTIONS:
- ALL PHARMACOKINETICS
- This is the driver that outputs the regular simulation, the variable dose data, the local sensitivity analysis and the global
sensitivity analysis
- You will need to run the driver TWICE. Once, for the malaria simulation with the variable RunCase = 1, and once with 
RunCase = 2 (for COVID-19 simulation). For the COVID-19 simulation, run everything except the sections marked "Pharmacodynamics" because these
are only designed to run for the malaria disease case.
- Please run the driver section-by-section. Some sections will take SEVERAL MINUTES to run because the simulation runs for several days (7 DAYS)
- We cut down the number of timepoints to reduce the computational burden, but the simulations still take a long time
- To further decrease the time needed to run the driver, go into the "Chloroquine_sim.m" file and on lines 89-91 change the
number of times the for-loop runs from i = 1: 7 (7 days in malaria simulation) to i = 1:3 (only three days). This will
make the code a lot faster, but as the resulting data files will NOT be correct. The R visualization files should still run, 
but the output graphs will look different from the complete results we present in our report.
- Currently, because the number of timepoints was reduced for speed, the graphs in the R visualization files will not look 
as smooth as the ones in our report, because to get a smooth appearance we had to increase the number of timepoints and
the code took 30-40 minutes to run for each graph, sometimes and hour for the local sensitivity graphs
- MALARIA PHARMACODYNAMICS
- these graphs take at least an hour to run each. To reduce this, we reduced the number of doses, parasite clearances, and starting
parasite burdens that the simulation tests to only 2 each, where in the report we show 10 each. 
- The MATLAB code will run and give .mat file outputs. However, the R visualziation will not run for these abbreviated .mat files
becuase the dimensions of the matrices are different (2x2) versus the required (10x10). 
- So, in a subfolder titled "Malara Pharmacodynamics" we included the correct .mat files with the correct dimensions, 
along with the R visualziation file used to create the PD heatmaps, titled: "fig1Aheatmap." Using the provided .mat files,
the R code will output the same figures seen in the PD section of our report document.

OUTPUTS THESE:
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
	All files for local sensitivity visualization
	All files for global sensitivity visualization
	All files for variable dose simulation


Chloroquine_Driver_MissedDose

Uses:
This is used for creating the missed dose simulation visualization files. This driver uses these files:
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


R VISUALIZATION and SHINY APPS

RUN INSTRUCTIONS
- You must run BOTH the malaria AND COVID-19 simulations using the MATLAB drivers before all the shiny apps will run
- You must run the Chloroquine Missed Dose Driver for ALL 4 CASES before appMalariaVsCovid will run
- You should be able to run all regular R files from Rstudio by highlighting all the lines of code and running them.
Some figures will look different than the figures in our report file because we had to reduce the number of timepoints used for speed (see above)
so that it doesn't take hours and hours to get all the needed data.
- Shiny apps should run correctly, again some figures may not look the same as in our report file.

To run appMalariaVsCovid.R:
1) Run the file Chloroquine_Driver.m in MATLAB so necessary data files are produced
2) Run the file Chloroquine_Driver_MissedDose.m in MATLAB so necessary data files are produced
3) Run the file appMalariaVsCovid.R in R. All necessary data should exist within the folden