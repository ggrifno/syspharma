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

# #melt the dataframe to put it in a format that can be used to make a heatmap
df1_melt <- melt(df1_values,id.vars='Dose')
names(df1_melt)[2]<- 'kCQ'
names(df1_melt)[3]<- 'ConcentrationCQ'

p1a <- ggplot(df1_melt, aes(x=kCQ,y=Dose,fill=ConcentrationCQ)) + geom_tile(color='black') +
  theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=1.75,limit=c(1,2.5),name='Peak [CQ] (mg/L)')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  # coord_fixed()+
  xlab('CQ Clearance Rate (hr-1)')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Malaria Global Sensitivity to Dose and CQ Clearance') # for the main title
print(p1a)

#FIGURE 1B--------------------------------------------------

#get the simulation data from MATLAB
Data_COVID19 <- readMat('global_sensi_COVID19.mat',header=T)
df1b <- as.data.frame(Data_COVID19)# Convert from list to data frame

#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df1b_values <- select(df1b, 'dose.total', 'peakCQ.mean.10','peakCQ.mean.9', 'peakCQ.mean.8', 'peakCQ.mean.7', 'peakCQ.mean.6', 'peakCQ.mean.5','peakCQ.mean.4', 'peakCQ.mean.3', 'peakCQ.mean.2', 'peakCQ.mean.1')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df1b_values)[1] <- 'Dose'
names(df1b_values)[2] <- '0.00048'
names(df1b_values)[3] <- '0.00052'
names(df1b_values)[4] <- '0.00057'
names(df1b_values)[5] <- '0.00062'
names(df1b_values)[6] <- '0.00068'
names(df1b_values)[7] <- '0.00076'
names(df1b_values)[8] <- '0.00087'
names(df1b_values)[9] <- '0.00100'
names(df1b_values)[10]<- '0.00118'
names(df1b_values)[11]<- '0.00144'

# #melt the dataframe to put it in a format that can be used to make a heatmap
df1b_melt <- melt(df1b_values,id.vars='Dose')
names(df1b_melt)[2]<- 'kCQ'
names(df1b_melt)[3]<- 'ConcentrationCQ'

p1b <- ggplot(df1b_melt, aes(x=kCQ,y=Dose,fill=ConcentrationCQ)) + geom_tile(color='black') +
  theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=1.75,limit=c(1,2.5),name='Peak [CQ] (mg/L)')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  # coord_fixed()+
  xlab('CQ Clearance Rate (hr-1)')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Malaria Global Sensitivity to Dose and CQ Clearance') # for the main title
print(p1b)
