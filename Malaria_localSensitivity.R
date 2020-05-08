# Systems Pharamcology Final Project Spring 2020
# Gabrielle Grifno

#LOCAL SENSITIVIY ANALYSIS
#load packages
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly) #for plotly graphing

# MALARIA: Univariate analysis local sensitivity bar graph -------------------------

#load in data for univariate analysis
DataAUCCQ = readMat('LocalSensiAUCCQ.mat', header = T)
DataAUCDCQ = readMat('LocalSensiAUCDCQ.mat', header = T)

#organize as dataframes from .mat files
df_AUCCQ = as.data.frame(DataAUCCQ)
df_AUCDCQ = as.data.frame(DataAUCDCQ)