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

#MIC1 --------------------------------------------------

#get the simulation data from MATLAB
Data1 <- readMat('figA1.mat',header=T)
df1 <- as.data.frame(Data1)# Convert from list to data frame
#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df1_values <- select(df1, 'percentCured.10','percentCured.9', 'percentCured.8', 'percentCured.7', 'percentCured.6', 'percentCured.5','percentCured.4', 'percentCured.3', 'percentCured.2', 'percentCured.1')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df1_values)[1] <- '0.009'
names(df1_values)[2] <- '0.013'
names(df1_values)[3] <- '0.016'
names(df1_values)[4] <- '0.019'
names(df1_values)[5] <- '0.023'
names(df1_values)[6] <- '0.026'
names(df1_values)[7] <- '0.029'
names(df1_values)[8] <- '0.033'
names(df1_values)[9] <- '0.036'
names(df1_values)[10]<- '0.040'
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df1_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df1_melt <- melt(df1_values,id.vars='Dose')
names(df1_melt)[2]<- 'kP'
names(df1_melt)[3]<- 'Cured'

p1a <- ggplot(df1_melt, aes(x=kP,y=Dose,fill=Cured)) + geom_tile(color='black') +
  theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=80,limit=c(70,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=16))+
  coord_fixed()+
  xlab('Parasite Clearance Rate, kP (hr-1)')+
  ylab('Dose (mg/kg)')+
  ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
print(p1a)
# ggplotly(p)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)

#MIC2 --------------------------------------------------

#get the simulation data from MATLAB
Data2 <- readMat('figA2.mat',header=T)
df2 <- as.data.frame(Data2)# Convert from list to data frame
#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df2_values <- select(df2, 'percentCured.10','percentCured.9', 'percentCured.8', 'percentCured.7', 'percentCured.6', 'percentCured.5','percentCured.4', 'percentCured.3', 'percentCured.2', 'percentCured.1')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df2_values)[1] <- '0.009'
names(df2_values)[2] <- '0.013'
names(df2_values)[3] <- '0.016'
names(df2_values)[4] <- '0.019'
names(df2_values)[5] <- '0.023'
names(df2_values)[6] <- '0.026'
names(df2_values)[7] <- '0.029'
names(df2_values)[8] <- '0.033'
names(df2_values)[9] <- '0.036'
names(df2_values)[10]<- '0.040'
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df2_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df2_melt <- melt(df2_values,id.vars='Dose')
names(df2_melt)[2]<- 'kP'
names(d2f_melt)[3]<- 'Cured'

p2a <- ggplot(df2_melt, aes(x=kP,y=Dose,fill=Cured)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=16))+
  coord_fixed()+
  xlab('Parasite Clearance Rate, kP (hr-1)')+
  ylab('Dose (mg/kg)')+
  ggtitle('Doubled MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
print(p2a)
# ggplotly(p2a)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)

#Print/save layout--------------------------------------------------
out <- ggarrange(p1a, p2a, nrow=1, ncol=2, common.legend = TRUE, legend = 'right')
print(out)
# ggsave(file="Fig1Results.png",plot=out2,width=12,height=6)


