#ggrifno systems pharma FINAL PROJECT
#REVISED VERSION OF CODE TO MAKE MALARIA PD HEATMAPS
#plot heatmap of percent of patients who are "cured" of malaria
#cured = have parasites below detection limit (10^9) at the end of 3 weeks

#call libraries that will be needed
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly)
#FIGURE 1--------------------------------------------------
# VARIABLE DOSE PLUS DIFFERENT PARASITE CLEARANCE RATES
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
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=16))+
  coord_fixed()+
  xlab('Parasite Clearance Rate, kP (hr-1)')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Standard MIC (0.067 mg/L)') # for the main title
# print(p1a)
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
names(df2_melt)[3]<- 'Cured'

p2a <- ggplot(df2_melt, aes(x=kP,y=Dose,fill=Cured)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=16))+
  coord_fixed()+
  xlab('Parasite Clearance Rate, kP (hr-1)')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Doubled MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Doubled MIC (0.134 mg/L)')
# print(p2a)
# ggplotly(p2a)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)

#Print/save layout--------------------------------------------------
outfig1 <- ggarrange(p1a, p2a, nrow=1, ncol=2, common.legend = TRUE, legend = 'right')
print(outfig1)
ggsave(file="Fig1Results.png",plot=outfig1,width=12,height=6)


#FIGURE 2--------------------------------------------------

#MIC1 --------------------------------------------------

#get the simulation data from MATLAB
Data2a <- readMat('fig2A.mat',header=T)
df2a <- as.data.frame(Data2a)# Convert from list to data frame
#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df2a_values <- select(df2a, 'percentCured2a.1','percentCured2a.2', 'percentCured2a.3', 'percentCured2a.4', 'percentCured2a.5', 'percentCured2a.6','percentCured2a.7', 'percentCured2a.8', 'percentCured2a.9', 'percentCured2a.10')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df2a_values)[1] <- '10^8'
names(df2a_values)[2] <- "10^9"
names(df2a_values)[3] <- "10^10"
names(df2a_values)[4] <- "10^11"
names(df2a_values)[5] <- "10^12"
names(df2a_values)[6] <- "10^13"
names(df2a_values)[7] <- "10^14"
names(df2a_values)[8] <- "10^15"
names(df2a_values)[9] <- "10^16"
names(df2a_values)[10]<- "10^17"
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df2a_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df2a_melt <- melt(df2a_values,id.vars='Dose')
names(df2a_melt)[2]<- 'Parasites'
names(df2a_melt)[3]<- 'Cured'

pfig2a <- ggplot(df2a_melt, aes(x=Parasites,y=Dose,fill=Cured)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  coord_fixed()+
  xlab('Starting Parasite Burden')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Doubled MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Standard MIC (0.067 mg/L)')
print(pfig2a)
# ggplotly(p2a)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)


#MIC2 --------------------------------------------------

#get the simulation data from MATLAB
Data2b <- readMat('fig2B.mat',header=T)
df2b <- as.data.frame(Data2b)# Convert from list to data frame
#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly
df2b_values <- select(df2b, 'percentCured2B.1','percentCured2B.2', 'percentCured2B.3', 'percentCured2B.4', 'percentCured2B.5', 'percentCured2B.6','percentCured2B.7', 'percentCured2B.8', 'percentCured2B.9', 'percentCured2B.10')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df2b_values)[1] <- '10^8'
names(df2b_values)[2] <- "10^9"
names(df2b_values)[3] <- "10^10"
names(df2b_values)[4] <- "10^11"
names(df2b_values)[5] <- "10^12"
names(df2b_values)[6] <- "10^13"
names(df2b_values)[7] <- "10^14"
names(df2b_values)[8] <- "10^15"
names(df2b_values)[9] <- "10^16"
names(df2b_values)[10]<- "10^17"
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df2b_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df2b_melt <- melt(df2b_values,id.vars='Dose')
names(df2b_melt)[2]<- 'Parasites'
names(df2b_melt)[3]<- 'Cured'

pfig2b <- ggplot(df2b_melt, aes(x=Parasites,y=Dose,fill=Cured)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  coord_fixed()+
  xlab('Starting Parasite Burden')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Doubled MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Double MIC (0.134 mg/L)')
print(pfig2b)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)

#Print/save layout--------------------------------------------------
outfig2 <- ggarrange(pfig2a, pfig2b, nrow=1, ncol=2, common.legend = TRUE, legend = 'right')
print(outfig2)
ggsave(file="Fig2Results.png",plot=outfig2,width=12,height=6)

#FIGURE 3--------------------------------------------------

#MIC1 --------------------------------------------------

#get the simulation data from MATLAB
Data3a <- readMat('fig3A.mat',header=T)
df3a <- as.data.frame(Data3a)# Convert from list to data frame
#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df3a_values <- select(df3a, 'percentCured3a.1','percentCured3a.2', 'percentCured3a.3', 'percentCured3a.4', 'percentCured3a.5', 'percentCured3a.6','percentCured3a.7', 'percentCured3a.8', 'percentCured3a.9', 'percentCured3a.10')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df3a_values)[1] <- '10^8'
names(df3a_values)[2] <- "10^9"
names(df3a_values)[3] <- "10^10"
names(df3a_values)[4] <- "10^11"
names(df3a_values)[5] <- "10^12"
names(df3a_values)[6] <- "10^13"
names(df3a_values)[7] <- "10^14"
names(df3a_values)[8] <- "10^15"
names(df3a_values)[9] <- "10^16"
names(df3a_values)[10]<- "10^17"
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df3a_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df3a_melt <- melt(df3a_values,id.vars='Dose')
names(df3a_melt)[2]<- 'Parasites'
names(df3a_melt)[3]<- 'Cured'

pfig3a <- ggplot(df3a_melt, aes(x=Parasites,y=Dose,fill=Cured)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  coord_fixed()+
  xlab('Starting Parasite Burden')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Doubled MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Standard MIC (0.067 mg/L)')
print(pfig3a)
# ggplotly(p2a)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)

#MIC2 --------------------------------------------------

#get the simulation data from MATLAB
Data3b <- readMat('fig3B.mat',header=T)
df3b <- as.data.frame(Data3b)# Convert from list to data frame
#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly
df3b_values <- select(df3b, 'percentCured3b.1','percentCured3b.2', 'percentCured3b.3', 'percentCured3b.4', 'percentCured3b.5', 'percentCured3b.6','percentCured3b.7', 'percentCured3b.8', 'percentCured3b.9', 'percentCured3b.10')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df3b_values)[1] <- '10^8'
names(df3b_values)[2] <- "10^9"
names(df3b_values)[3] <- "10^10"
names(df3b_values)[4] <- "10^11"
names(df3b_values)[5] <- "10^12"
names(df3b_values)[6] <- "10^13"
names(df3b_values)[7] <- "10^14"
names(df3b_values)[8] <- "10^15"
names(df3b_values)[9] <- "10^16"
names(df3b_values)[10]<- "10^17"
#create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
df3b_values$Dose <- c('30.0', '33.3', '36.6', '40.0', '43.3', '46.7', '50.0', '53.3', '56.7', '60.0')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
df3b_melt <- melt(df3b_values,id.vars='Dose')
names(df3b_melt)[2]<- 'Parasites'
names(df3b_melt)[3]<- 'Cured'

pfig3b <- ggplot(df3b_melt, aes(x=Parasites,y=Dose,fill=Cured)) + geom_tile(color='black') +
  xlab('') + ylab('') + theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=50,limit=c(0,100),name='% Cured')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  coord_fixed()+
  xlab('Starting Parasite Burden')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Doubled MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Double MIC (0.134 mg/L)')
print(pfig3b)
# ggsave(file="fig1A.png",plot=p1a,width=12,height=6)

#Print/save layout--------------------------------------------------
outfig3 <- ggarrange(pfig3a, pfig3b, nrow=1, ncol=2, common.legend = TRUE, legend = 'right')
print(outfig3)
ggsave(file="Fig3Results.png",plot=outfig3,width=12,height=6)

