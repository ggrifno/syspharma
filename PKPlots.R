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

DataMCQ <- readMat("NormalD_Malaria_PK_CQCentral.mat",header=T) # from mat file
DMCQ <- as.data.frame(DataMCQ) # Convert .mat data into a data frame.
DataMDQ <- readMat("NormalD_Malaria_PK_DQCentral.mat",header=T) # from mat file
DMDQ <- as.data.frame(DataMDQ) # Convert .mat data into a data frame.

DataCCQ <- readMat("NormalD_COVID_PK_CQCentral.mat",header=T) # from mat file
DCCQ <- as.data.frame(DataCCQ) # Convert .mat data into a data frame.
DataCDQ <- readMat("NormalD_COVID_PK_DQCentral.mat",header=T) # from mat file
DCDQ <- as.data.frame(DataCDQ) # Convert .mat data into a data frame.


pMCQ <- ggplot(DMCQ, aes(x = Time/24, y = MedianYCQ)) + 
  geom_line(aes(color = 'Normal'),alpha = 1, size = 1) +
  geom_ribbon(aes(ymin=P25YCQ, ymax=P75YCQ, color = 'Normal'), fill = 'grey', alpha=0.3)+
  #formating lines
  ggtitle('A') + # for the main title
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
  scale_y_continuous(limits = c(0.0, 1.2))+
  scale_x_continuous(limits = c(0, 5))

pMDQ <- ggplot(DMDQ, aes(x = Time/24, y = MedianYDQ)) + 
  geom_line(aes(color = 'Normal'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQ, ymax=P75YDQ, color = 'Normal'), fill = 'grey', alpha=0.3)+
  #formating lines
  ggtitle('B') + # for the main title
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
  scale_y_continuous(limits = c(0.0, 1.2))+
  scale_x_continuous(limits = c(0, 5))

out <- grid.arrange(pMCQ,pMDQ,ncol=2) 

pCCQ <- ggplot(DCCQ, aes(x = Time/24, y = MedianYCQ)) + 
  geom_line(aes(color = 'Normal'),alpha = 1, size = 1) +
  geom_ribbon(aes(ymin=P25YCQ, ymax=P75YCQ, color = 'Normal'), fill = 'grey', alpha=0.1)+
  #formating lines
  ggtitle('A') + # for the main title
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
  scale_y_continuous(limits = c(0.0, 3))+
  scale_x_continuous(limits = c(0, 7))

pCDQ <- ggplot(DCDQ, aes(x = Time/24, y = MedianYDQ)) + 
  geom_line(aes(color = 'Normal'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQ, ymax=P75YDQ, color = 'Normal'), fill = 'grey', alpha=0.1)+
  #formating lines
  ggtitle('B') + # for the main title
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
  scale_y_continuous(limits = c(0.0, 3))+
  scale_x_continuous(limits = c(0, 7))

pCCQ2 <- ggplot(DCCQ, aes(x = Time/24, y = MedianYCQ)) + 
  geom_line(aes(color = 'Normal'),alpha = 1, size = 1) +
  geom_ribbon(aes(ymin=P25YCQ, ymax=P75YCQ, color = 'Normal'), fill = 'grey', alpha=0.1)+
  #formating lines
  ggtitle('C') + # for the main title
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
  scale_y_continuous(limits = c(0.0, 2))+
  scale_x_continuous(limits = c(0, 2))

pCDQ2 <- ggplot(DCDQ, aes(x = Time/24, y = MedianYDQ)) + 
  geom_line(aes(color = 'Normal'),alpha = 0.7, size = 1) +
  geom_ribbon(aes(ymin=P25YDQ, ymax=P75YDQ, color = 'Normal'), fill = 'grey', alpha=0.1)+
  #formating lines
  ggtitle('D') + # for the main title
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
  scale_y_continuous(limits = c(0.0, 2))+
  scale_x_continuous(limits = c(0, 2))


out <- grid.arrange(pCCQ,pCDQ, pCCQ2,pCDQ2,ncol=2) 