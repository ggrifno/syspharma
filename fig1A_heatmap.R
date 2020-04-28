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
#8 hours --------------------------------------------------

#get the simulation data from MATLAB
Data <- readMat('figA1.mat',header=T)
df <- as.data.frame(Data)# Convert from list to data frame
# df_values <- select(df, 'percentCured.1','percentCured.2', 'percentCured.3', 'percentCured.4', 'percentCured.5', 'percentCured.6','percentCured.7', 'percentCured.8', 'percentCured.9', 'percentCured.10')
df_values <- select(df, 'percentCured.10','percentCured.9', 'percentCured.8', 'percentCured.7', 'percentCured.6', 'percentCured.5','percentCured.4', 'percentCured.3', 'percentCured.2', 'percentCured.1')
#rename the column headers from default names that were passed in from MATLAB to patients

# names(df_values)[1] <- '0.040'
# names(df_values)[2] <- '0.036'
# names(df_values)[3] <- '0.033'
# names(df_values)[4] <- '0.029'
# names(df_values)[5] <- '0.026'
# names(df_values)[6] <- '0.023'
# names(df_values)[7] <- '0.019'
# names(df_values)[8] <- '0.016'
# names(df_values)[9] <- '0.013'
# names(df_values)[10]<- '0.009'
names(df_values)[1] <- '0.009'
names(df_values)[2] <- '0.013'
names(df_values)[3] <- '0.016'
names(df_values)[4] <- '0.019'
names(df_values)[5] <- '0.023'
names(df_values)[6] <- '0.026'
names(df_values)[7] <- '0.029'
names(df_values)[8] <- '0.033'
names(df_values)[9] <- '0.036'
names(df_values)[10]<- '0.040'
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df_melt <- melt(df_values,id.vars='Dose')
names(df_melt)[2]<-

p <- ggplot(df_melt, aes(x=variable,y=Dose,fill=value)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=80,limit=c(70,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  coord_fixed()+
  xlab('Parasite Clearance Rate, kP (hr-1)')+
  ylab('Dose (mg/kg)')+
  ggtitle('Figure 1A: Efficacy Across Variable CQ Dose and kP') # for the main title
print(p)
ggplotly(p)
# ggsave(file="Q3_8hr.png",plot=p8hr,width=12,height=6)
