#ggrifno systems pharma FINAL PROJECT

#plot heatmap of percent of patients who are "cured" of malaria
#cured = have parasites below detection limit (10^9) at the end of 3 weeks

#call libraries that will be needed
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
#8 hours --------------------------------------------------

#get the simulation data from MATLAB
Data <- readMat('figA1.mat',header=T)
df <- as.data.frame(Data)# Convert from list to data frame
#rename the column headers from default names that were passed in from MATLAB to patients


# names(df1)[1] <- 'Patient 1'
# names(df1)[2] <- 'Patient 2'
# names(df1)[3] <- 'Patient 3'
# names(df1)[4] <- 'Patient 4'
# names(df1)[5] <- 'Patient 5'
# #create an extra column to hold the names of the variables across each row
# df1$Outputs <- c('Dose','ka','kcl','Vd')
# 
# #melt the dataframe to put it in a format that can be used to make a heatmap
# df1_melt <- melt(df1,id.vars='Outputs')
# 
# p8hr <- ggplot(df1_melt, aes(x=Outputs,y=variable,fill=value)) + geom_tile(color='black') +
#   xlab('') + ylab('') + theme_minimal() +
#   scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=0,limit=c(-0.1,0.1),name='Sensitivity')+
#   theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
#   coord_fixed()+
#   ggtitle('Q3: Local Sensitivity for AUC (8 hr)') # for the main title
# print(p8hr)
# ggsave(file="Q3_8hr.png",plot=p8hr,width=12,height=6)
