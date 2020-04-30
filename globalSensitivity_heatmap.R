#ggrifno systems pharma FINAL PROJECT

#plot heatmap of percent of patients who are "cured" of malaria
#cured = have parasites below detection limit (10^9) at the end of 3 weeks

#call libraries that will be needed
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly)
#FIGURE 1A--------------------------------------------------

#get the simulation data from MATLAB
Data_Malaria <- readMat('global_sensi_Malaria.mat',header=T)
df1a <- as.data.frame(Data_Malaria)# Convert from list to data frame

#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df1_values <- select(df1a, 'dose.total', 'peakCQ.mean.10','peakCQ.mean.9', 'peakCQ.mean.8', 'peakCQ.mean.7', 'peakCQ.mean.6', 'peakCQ.mean.5','peakCQ.mean.4', 'peakCQ.mean.3', 'peakCQ.mean.2', 'peakCQ.mean.1')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df1_values)[1] <- 'Dose'
names(df1_values)[2] <- '0.00048'
names(df1_values)[3] <- '0.00052'
names(df1_values)[4] <- '0.00057'
names(df1_values)[5] <- '0.00062'
names(df1_values)[6] <- '0.00068'
names(df1_values)[7] <- '0.00076'
names(df1_values)[8] <- '0.00087'
names(df1_values)[9] <- '0.00100'
names(df1_values)[10] <- '0.00118'
names(df1_values)[11]<- '0.00144'
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df1_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df1_melt <- melt(df1_values,id.vars='Dose')
names(df1_melt)[2]<- 'kP'
names(df1_melt)[3]<- 'Cured'
