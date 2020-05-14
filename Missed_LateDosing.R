library(shiny)
library(plotly)
library(ggplot2) 
library(R.matlab)
library(reshape2)
library(plyr)
library(gridExtra)
library(gtable)
library(Hmisc)
library(pracma)
library(ggthemes) 
library("viridis")

DataMD_CQ <- readMat("MissedDose_Malaria_PK_CQCentral.mat",header=T) # from mat file
DMD_CQ <- as.data.frame(DataMD_CQ) # Convert .mat data into a data frame.
Data2_CQ <- readMat("LateDose2_Malaria_PK_CQCentral.mat",header=T) # from mat file
D2_CQ <- as.data.frame(Data2_CQ) # Convert .mat data into a data frame.
Data3_CQ <- readMat("LateDose3_Malaria_PK_CQCentral.mat",header=T) # from mat file
D3_CQ <- as.data.frame(Data3_CQ) # Convert .mat data into a data frame.
Data4_CQ <- readMat("LateDose4_Malaria_PK_CQCentral.mat",header=T) # from mat file
D4_CQ <- as.data.frame(Data4_CQ) # Convert .mat data into a data frame.

DataMD_DQ <- readMat("MissedDose_Malaria_PK_DQCentral.mat",header=T) # from mat file
DMD_DQ <- as.data.frame(DataMD_DQ) # Convert .mat data into a data frame.
Data2_DQ <- readMat("LateDose2_Malaria_PK_DQCentral.mat",header=T) # from mat file
D2_DQ <- as.data.frame(Data2_DQ) # Convert .mat data into a data frame.
Data3_DQ <- readMat("LateDose3_Malaria_PK_DQCentral.mat",header=T) # from mat file
D3_DQ <- as.data.frame(Data3_DQ) # Convert .mat data into a data frame.
Data4_DQ <- readMat("LateDose4_Malaria_PK_DQCentral.mat",header=T) # from mat file
D4_DQ <- as.data.frame(Data4_DQ) # Convert .mat data into a data frame.

pMDCQ <- ggplot(DMD_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
  geom_line(aes(color = 'Normal'),alpha = 1, size = 1) +
  geom_ribbon(aes(ymin=P25YCQCM0, ymax=P75YCQCM0), fill = 'yellow', alpha=0.1) +
  geom_line(aes(y = MedianYCQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YCQCM1, ymax=P75YCQCM1), fill = 'grey',alpha=0.3) +
  geom_line(aes(y = MedianYCQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YCQCM2, ymax=P75YCQCM2), fill = 'violetred4',alpha=0.1) +
  geom_line(aes(y = MedianYCQCM3, color = 'Missed Third', ),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YCQCM3, ymax=P75YCQCM3), fill = 'orange',alpha=0.1) +
  geom_line(aes(y = MedianYCQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YCQCM4, ymax=P75YCQCM4), fill = 'purple4', alpha=0.1) +
  #formating lines
  ggtitle('Chloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        legend.position = "none",
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))+
  scale_y_continuous(limits = c(0.0, 1.2))
  

#print(pMDCQ)
pMDDQ <- ggplot(DMD_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
  geom_line(aes(color = 'Normal'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQCM0, ymax=P75YDQCM0), fill = 'yellow', alpha=0.1) +
  geom_line(aes(y = MedianYDQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQCM0, ymax=P75YDQCM0), fill = 'grey', alpha=0.3) +
  geom_line(aes(y = MedianYDQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2), fill = 'violetred4',alpha=0.1) +
  geom_line(aes(y = MedianYDQCM3, color = 'Missed Third'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2), fill = 'orange',alpha=0.1) +
  geom_line(aes(y = MedianYDQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2), fill = 'purple4',alpha=0.1) +
  
  #formating lines
  ggtitle('Desethylchloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))+
  scale_y_continuous(limits = c(0.0, 1.2))
  

out <- grid.arrange(pMDCQ,pMDDQ,ncol=2) 

pL2CQ <- ggplot(D2_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
  geom_line(aes(color = 'Normal'), size = 1) +
  geom_line(aes(y = MedianYCQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM3, color = 'Missed Third'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM5, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +

  #formating lines
  ggtitle('Chloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        legend.position = "none",
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))  +
  scale_y_continuous(limits = c(0.3, 1.1))+
  scale_x_continuous(limits = c(0, 6))
                     


pL2DQ <- ggplot(D2_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
  geom_line(aes(color = 'Normal'), size = 1) +
  geom_line(aes(y = MedianYDQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
  #formating lines
  ggtitle('Desethylchloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))  +
  scale_y_continuous(limits = c(0.06, 0.225))+
  scale_x_continuous(limits = c(0, 6))

pL3CQ <- ggplot(D3_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
  geom_line(aes(color = 'Normal'), size = 1) +
  geom_line(aes(y = MedianYCQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM3, color = 'Missed Third'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM5, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
  #formating lines
  ggtitle('Chloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        legend.position = "none",
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))  +
  scale_y_continuous(limits = c(0.3, 1.1))+
  scale_x_continuous(limits = c(0, 6))



pL3DQ <- ggplot(D3_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
  geom_line(aes(color = 'Normal'), size = 1) +
  geom_line(aes(y = MedianYDQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
  #formating lines
  ggtitle('Desethylchloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))  +
  scale_y_continuous(limits = c(0.06, 0.225))+
  scale_x_continuous(limits = c(0, 6))

pL4CQ <- ggplot(D4_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
  geom_line(aes(color = 'Normal'), size = 1) +
  geom_line(aes(y = MedianYCQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM3, color = 'Missed Third'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYCQCM5, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
  #formating lines
  ggtitle('Chloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        legend.position = "none",
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))  +
  scale_y_continuous(limits = c(0.3, 1.1))+
  scale_x_continuous(limits = c(0, 6))


pL4DQ <- ggplot(D4_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
  geom_line(aes(color = 'Normal'), size = 1) +
  geom_line(aes(y = MedianYDQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
  geom_line(aes(y = MedianYDQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
  #formating lines
  ggtitle('Desethylchloroquine') + # for the main title
  xlab('Time (days)') + # for the x axis label
  ylab('Concentration (mg/L)') + # for the y axis label
  theme_bw()+
  scale_color_viridis(discrete = TRUE, option = "B")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(size = 11, face = "bold"),
        axis.title = element_text(size = 10))  +
  scale_y_continuous(limits = c(0.06, 0.225))+
  scale_x_continuous(limits = c(0, 6))

#out <- grid.arrange(pL2CQ,pL2DQ,pL3CQ,pL3DQ,pL4CQ,pL4DQ,ncol=2) 




