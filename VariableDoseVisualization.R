#ggrifno systems pharma FINAL PROJECT



#call libraries that will be needed
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly)

#MALARIA variable dose plots -------------------------
#Plot 1: variable dose timecourse for central compartment [CQ]

Data_MalariaCQ <- readMat('varDose_CQ_Malaria.mat',header=T)
df_MalariaCQ <- as.data.frame(Data_MalariaCQ)# Convert from list to data frame
df1a_values <- select(df1a, 'peakCQ.mean.Malaria.10','peakCQ.mean.Malaria.9', 'peakCQ.mean.Malaria.8', 'peakCQ.mean.Malaria.7', 'peakCQ.mean.Malaria.6', 'peakCQ.mean.Malaria.5','peakCQ.mean.Malaria.4', 'peakCQ.mean.Malaria.3', 'peakCQ.mean.Malaria.2', 'peakCQ.mean.Malaria.1')

#format matrix for heatmap
MP1 <- ggplot(df_MalariaCQ, aes(x = Timeday))+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.1, ymax = varDose.CQ.iqr.upper.1, color = 'color1'), fill = "pink")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.2, ymax = varDose.CQ.iqr.upper.2, color = 'color2'), fill = "peachpuff")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.3, ymax = varDose.CQ.iqr.upper.3, color = 'color3'), fill = "wheat1")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.4, ymax = varDose.CQ.iqr.upper.4, color = 'color4'), fill = "palegreen")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.5, ymax = varDose.CQ.iqr.upper.5, color = 'color5'), fill = "paleturquoise1")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.6, ymax = varDose.CQ.iqr.upper.6, color = 'color6'), fill = "lightblue1")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.7, ymax = varDose.CQ.iqr.upper.7, color = 'color7'), fill = "thistle1")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.8, ymax = varDose.CQ.iqr.upper.8, color = 'color8'), fill = "skyblue")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.9, ymax = varDose.CQ.iqr.upper.9, color = 'color9'), fill = "slategray")+
  # geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.10, ymax = varDose.CQ.iqr.upper.10, color = 'color10'), fill = "snow2")+
  
  # geom_line(aes(y = varDose.CQmedian.1, color = 'color'), color="red")+
  geom_line(aes(y = varDose.CQmedian.1, color = '25'))+
  geom_line(aes(y = varDose.CQmedian.2, color = '27'))+
  geom_line(aes(y = varDose.CQmedian.3, color = '30' ))+
  geom_line(aes(y = varDose.CQmedian.4, color = '33' ))+
  geom_line(aes(y = varDose.CQmedian.5, color = '36' ))+
  geom_line(aes(y = varDose.CQmedian.6, color = '38' ))+
  geom_line(aes(y = varDose.CQmedian.7, color = '41' ))+
  geom_line(aes(y = varDose.CQmedian.8, color = '44' ))+
  geom_line(aes(y = varDose.CQmedian.9, color = '47' ))+
  geom_line(aes(y = varDose.CQmedian.10, color ='50' ))+
  # scale_color_discrete(name = "Y series", labels = c("Y2", "Y1"))+
  
  # geom_line(aes(y = varDose.CQmedian.2, color = '27.7' ), color="darkorange1")+
  # geom_line(aes(y = varDose.CQmedian.3), color="goldenrod1")+
  # geom_line(aes(y = varDose.CQmedian.4), color="green")+
  # geom_line(aes(y = varDose.CQmedian.5), color="turquoise")+
  # geom_line(aes(y = varDose.CQmedian.6), color="blue")+
  # geom_line(aes(y = varDose.CQmedian.7), color="purple")+
  # geom_line(aes(y = varDose.CQmedian.8), color="navyblue")+
  # geom_line(aes(y = varDose.CQmedian.9), color="black")+
  # geom_line(aes(y = varDose.CQmedian.10), color="snow4")+
  # scale_color_discrete(name = "Y series", labels = c("Y2", "Y1"))+
  theme_bw()
print(Malaria_P1)
Malaria_P1 <- ggplotly(MP1)
plotA

# Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line( color="#69b3a2", size=2, alpha=0.9, linetype=2) +
  theme_ipsum() +
  ggtitle("Evolution of something")

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


