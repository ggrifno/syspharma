#ggrifno systems pharma FINAL PROJECT



#call libraries that will be needed
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly)

#COVID-19 variable dose plots -------------------------
#Plot 1: variable dose timecourse for central compartment [CQ]
Data_COVID19CQ <- readMat('varDose_CQ_COVID19.mat',header=T)
df_COVID19CQ <- as.data.frame(Data_COVID19CQ)# Convert from list to data frame
df_COVID19CQmedian <- select(df_COVID19CQ, 'varDose.CQmedian.1', 'varDose.CQmedian.2', 'varDose.CQmedian.3', 'varDose.CQmedian.4', 'varDose.CQmedian.5', 'varDose.CQmedian.6', 'varDose.CQmedian.7', 'varDose.CQmedian.8', 'varDose.CQmedian.9', 'varDose.CQmedian.10')
df_COVID19CQiqrupper <-select(df_COVID19CQ, 'varDose.CQ.iqr.upper.1', 'varDose.CQ.iqr.upper.2', 'varDose.CQ.iqr.upper.3', 'varDose.CQ.iqr.upper.4', 'varDose.CQ.iqr.upper.5', 'varDose.CQ.iqr.upper.6', 'varDose.CQ.iqr.upper.7', 'varDose.CQ.iqr.upper.8', 'varDose.CQ.iqr.upper.9', 'varDose.CQ.iqr.upper.10')
df_COVID19CQiqrlower <-select(df_COVID19CQ, 'varDose.CQ.iqr.lower.1', 'varDose.CQ.iqr.lower.2', 'varDose.CQ.iqr.lower.3', 'varDose.CQ.iqr.lower.4', 'varDose.CQ.iqr.lower.5', 'varDose.CQ.iqr.lower.6', 'varDose.CQ.iqr.lower.7', 'varDose.CQ.iqr.lower.8', 'varDose.CQ.iqr.lower.9', 'varDose.CQ.iqr.lower.10')

COVID_P1 <- ggplot(data=df_COVID19CQ, aes(x=dose, y=len, group=supp)) +
  geom_line(linetype="dashed", color="blue", size=1.2)+
  geom_point(color="red", size=3)

print(COVID_P1)


#MALARIA variable dose plots -------------------------
#Plot 1: variable dose timecourse for central compartment [CQ]

Data_MalariaCQ <- readMat('varDose_CQ_Malaria.mat',header=T)
df_MalariaCQ <- as.data.frame(Data_MalariaCQ)# Convert from list to data frame
df1a_values <- select(df1a, 'peakCQ.mean.Malaria.10','peakCQ.mean.Malaria.9', 'peakCQ.mean.Malaria.8', 'peakCQ.mean.Malaria.7', 'peakCQ.mean.Malaria.6', 'peakCQ.mean.Malaria.5','peakCQ.mean.Malaria.4', 'peakCQ.mean.Malaria.3', 'peakCQ.mean.Malaria.2', 'peakCQ.mean.Malaria.1')
mat_1a <- as.matrix(df1a_values, rownames.force = NA)
#format matrix for heatmap
