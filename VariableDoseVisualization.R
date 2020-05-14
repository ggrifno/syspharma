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
#define formating for plotly graph
f1 <- list(size = 25)
xformat1 <- list(title = "Time (days)", titlefont = f1,showticklabels = TRUE, tickfont = f1)
yformat1 <- list(title = "Central Compartment [CQ] mg/mL",titlefont = f1,showticklabels = TRUE, tickfont = f1)


#format matrix for heatmap
MP1 <- ggplot(df_MalariaCQ, aes(x = Timeday))+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.1, ymax = varDose.CQ.iqr.upper.1, color = '25 mg/kg'), fill = "pink")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.2, ymax = varDose.CQ.iqr.upper.2, color = '27 mg/kg'), fill = "peachpuff")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.3, ymax = varDose.CQ.iqr.upper.3, color = '30 mg/kg'), fill = "wheat1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.4, ymax = varDose.CQ.iqr.upper.4, color = '33 mg/kg'), fill = "palegreen")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.5, ymax = varDose.CQ.iqr.upper.5, color = '36 mg/kg'), fill = "paleturquoise1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.6, ymax = varDose.CQ.iqr.upper.6, color = '38 mg/kg'), fill = "lightblue1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.7, ymax = varDose.CQ.iqr.upper.7, color = '41 mg/kg'), fill = "thistle1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.8, ymax = varDose.CQ.iqr.upper.8, color = '44 mg/kg'), fill = "skyblue")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.9, ymax = varDose.CQ.iqr.upper.9, color = '47 mg/kg'), fill = "plum1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.10,ymax = varDose.CQ.iqr.upper.10,color = '50 mg/kg'), fill = "snow2")+

  geom_line(aes(y = varDose.CQmedian.1, color = '25 mg/kg'))+
  geom_line(aes(y = varDose.CQmedian.2, color = '27 mg/kg'))+
  geom_line(aes(y = varDose.CQmedian.3, color = '30 mg/kg'))+
  geom_line(aes(y = varDose.CQmedian.4, color = '33 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.5, color = '36 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.6, color = '38 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.7, color = '41 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.8, color = '44 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.9, color = '47 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.10, color ='50 mg/kg' ))+
  labs(color = "Total Dose") +
  theme_bw(base_size = 22)

Malaria_P1 <- ggplotly(MP1)
Malaria_P1 <- Malaria_P1 %>% layout(xaxis = xformat1, yaxis = yformat1, showlegend = TRUE)
Malaria_P1

# Plot variable dose timecourse for central compartment [DCQ]
Data_MalariaDCQ <- readMat('varDose_DQ_Malaria.mat',header=T)
df_MalariaDCQ <- as.data.frame(Data_MalariaDCQ)# Convert from list to data frame

#define formating for plotly graph
f1 <- list(size = 25)
xformat2 <- list(title = "Time (days)", titlefont = f1,showticklabels = TRUE, tickfont = f1)
yformat2 <- list(title = "Central Compartment [DCQ] mg/mL",titlefont = f1,showticklabels = TRUE, tickfont = f1)

#format matrix for heatmap
MP2 <- ggplot(df_MalariaDCQ, aes(x = Timeday))+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.1, ymax = varDose.DCQ.iqr.upper.1, color = '25 mg/kg'), fill = "pink")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.2, ymax = varDose.DCQ.iqr.upper.2, color = '27 mg/kg'), fill = "peachpuff")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.3, ymax = varDose.DCQ.iqr.upper.3, color = '30 mg/kg'), fill = "wheat1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.4, ymax = varDose.DCQ.iqr.upper.4, color = '33 mg/kg'), fill = "palegreen")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.5, ymax = varDose.DCQ.iqr.upper.5, color = '36 mg/kg'), fill = "paleturquoise1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.6, ymax = varDose.DCQ.iqr.upper.6, color = '38 mg/kg'), fill = "lightblue1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.7, ymax = varDose.DCQ.iqr.upper.7, color = '41 mg/kg'), fill = "thistle1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.8, ymax = varDose.DCQ.iqr.upper.8, color = '44 mg/kg'), fill = "skyblue")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.9, ymax = varDose.DCQ.iqr.upper.9, color = '47 mg/kg'), fill = "plum1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.10, ymax = varDose.DCQ.iqr.upper.10, color = '50 mg/kg'), fill = "snow2")+

  geom_line(aes(y = varDose.DCQmedian.1, color = '25 mg/kg'))+
  geom_line(aes(y = varDose.DCQmedian.2, color = '27 mg/kg'))+
  geom_line(aes(y = varDose.DCQmedian.3, color = '30 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.4, color = '33 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.5, color = '36 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.6, color = '38 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.7, color = '41 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.8, color = '44 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.9, color = '47 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.10, color ='50 mg/kg' ))+
  labs(color = "Total Dose") +
  theme_bw(base_size = 22)

Malaria_P2 <- ggplotly(MP2)
Malaria_P2 <- Malaria_P2 %>% layout(xaxis = xformat2, yaxis = yformat2, showlegend = TRUE)
Malaria_P2

#plot the AUC of the central compartment [CQ]

Data_MalariaAUCCQ = readMat('varDose_AUCCQ_Malaria.mat', header = T)
df_MalariaAUCCQ = as.data.frame(Data_MalariaAUCCQ)

#define formating for plotly graph
f1 <- list(size = 25)
xformat3 <- list(title = "Total Dose (mg/kg)", titlefont = f1,showticklabels = TRUE, tickfont = f1)
yformat3 <- list(title = "Central Compartment [CQ] AUC (mg x hr/L)",titlefont = f1,showticklabels = TRUE, tickfont = f1)

#create a vector that represents all the dose conditions that we're testing and add it to the dataframe
dose_vector <- c('25', '27', '30', '33', '36', '38', '41', '44', '47', '50')
df_MalariaAUCCQ$dose<- dose_vector
MP3 <- ggplot(df_MalariaAUCCQ, aes(x = dose, y = varDose.AUCCQmedian))+
  geom_bar(stat="identity", width=0.75)+
  geom_errorbar(aes(ymin=varDose.AUCCQ.iqr.lower, ymax=varDose.AUCCQ.iqr.upper), width=1, position=position_dodge(.9))+
  theme_bw()
  
print(MP3)
Malaria_P3 <- ggplotly(MP3)
Malaria_P3 <- Malaria_P3 %>% layout(xaxis = xformat3, yaxis = yformat3, showlegend = TRUE)
Malaria_P3

#COVID-19 variable dose plots -------------------------
#Plot 1: variable dose timecourse for central compartment [CQ]
Data_COVID19CQ <- readMat('varDose_CQ_COVID19.mat',header=T)
df_COVID19CQ <- as.data.frame(Data_COVID19CQ)# Convert from list to data frame

#define formating for plotly graph
f1 <- list(size = 25)
xformat1 <- list(title = "Time (days)", titlefont = f1,showticklabels = TRUE, tickfont = f1)
yformat1 <- list(title = "Central Compartment [CQ] mg/mL",titlefont = f1,showticklabels = TRUE, tickfont = f1)


#format matrix for heatmap
C19P1 <- ggplot(df_COVID19CQ, aes(x = Timeday))+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.1, ymax = varDose.CQ.iqr.upper.1, color = '25 mg/kg'), fill = "pink")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.2, ymax = varDose.CQ.iqr.upper.2, color = '27 mg/kg'), fill = "peachpuff")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.3, ymax = varDose.CQ.iqr.upper.3, color = '30 mg/kg'), fill = "wheat1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.4, ymax = varDose.CQ.iqr.upper.4, color = '33 mg/kg'), fill = "palegreen")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.5, ymax = varDose.CQ.iqr.upper.5, color = '36 mg/kg'), fill = "paleturquoise1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.6, ymax = varDose.CQ.iqr.upper.6, color = '38 mg/kg'), fill = "lightblue1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.7, ymax = varDose.CQ.iqr.upper.7, color = '41 mg/kg'), fill = "thistle1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.8, ymax = varDose.CQ.iqr.upper.8, color = '44 mg/kg'), fill = "skyblue")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.9, ymax = varDose.CQ.iqr.upper.9, color = '47 mg/kg'), fill = "plum1")+
  geom_ribbon(aes(ymin =varDose.CQ.iqr.lower.10,ymax = varDose.CQ.iqr.upper.10,color = '50 mg/kg'), fill = "snow2")+
  
  geom_line(aes(y = varDose.CQmedian.1, color = '25 mg/kg'))+
  geom_line(aes(y = varDose.CQmedian.2, color = '27 mg/kg'))+
  geom_line(aes(y = varDose.CQmedian.3, color = '30 mg/kg'))+
  geom_line(aes(y = varDose.CQmedian.4, color = '33 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.5, color = '36 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.6, color = '38 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.7, color = '41 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.8, color = '44 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.9, color = '47 mg/kg' ))+
  geom_line(aes(y = varDose.CQmedian.10, color ='50 mg/kg' ))+
  labs(color = "Total Dose") +
  theme_bw(base_size = 22)

COVID19_P1 <- ggplotly(C19P1)
COVID19_P1 <- COVID19_P1 %>% layout(xaxis = xformat1, yaxis = yformat1, showlegend = TRUE)
COVID19_P1

# Plot variable dose timecourse for central compartment [DCQ]
Data_COVID19DCQ <- readMat('varDose_DQ_COVID19.mat',header=T)
df_COVID19DCQ <- as.data.frame(Data_COVID19DCQ)# Convert from list to data frame

#define formating for plotly graph
f1 <- list(size = 25)
xformat2 <- list(title = "Time (days)", titlefont = f1,showticklabels = TRUE, tickfont = f1)
yformat2 <- list(title = "Central Compartment [DCQ] mg/mL",titlefont = f1,showticklabels = TRUE, tickfont = f1)

#format matrix for heatmap
C19P2 <- ggplot(df_COVID19DCQ, aes(x = Timeday))+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.1, ymax = varDose.DCQ.iqr.upper.1, color = '25 mg/kg'), fill = "pink")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.2, ymax = varDose.DCQ.iqr.upper.2, color = '27 mg/kg'), fill = "peachpuff")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.3, ymax = varDose.DCQ.iqr.upper.3, color = '30 mg/kg'), fill = "wheat1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.4, ymax = varDose.DCQ.iqr.upper.4, color = '33 mg/kg'), fill = "palegreen")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.5, ymax = varDose.DCQ.iqr.upper.5, color = '36 mg/kg'), fill = "paleturquoise1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.6, ymax = varDose.DCQ.iqr.upper.6, color = '38 mg/kg'), fill = "lightblue1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.7, ymax = varDose.DCQ.iqr.upper.7, color = '41 mg/kg'), fill = "thistle1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.8, ymax = varDose.DCQ.iqr.upper.8, color = '44 mg/kg'), fill = "skyblue")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.9, ymax = varDose.DCQ.iqr.upper.9, color = '47 mg/kg'), fill = "plum1")+
  geom_ribbon(aes(ymin =varDose.DCQ.iqr.lower.10, ymax = varDose.DCQ.iqr.upper.10, color = '50 mg/kg'), fill = "snow2")+
  
  geom_line(aes(y = varDose.DCQmedian.1, color = '25 mg/kg'))+
  geom_line(aes(y = varDose.DCQmedian.2, color = '27 mg/kg'))+
  geom_line(aes(y = varDose.DCQmedian.3, color = '30 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.4, color = '33 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.5, color = '36 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.6, color = '38 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.7, color = '41 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.8, color = '44 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.9, color = '47 mg/kg' ))+
  geom_line(aes(y = varDose.DCQmedian.10, color ='50 mg/kg' ))+
  labs(color = "Total Dose") +
  theme_bw(base_size = 22)

COVID19_P2 <- ggplotly(C19P2)
COVID19_P2 <- COVID19_P2 %>% layout(xaxis = xformat2, yaxis = yformat2, showlegend = TRUE)
COVID19_P2

#plot the AUC of the central compartment [CQ]

Data_COVID19AUCCQ = readMat('varDose_AUCCQ_COVID19.mat', header = T)
df_COVID19AUCCQ = as.data.frame(Data_COVID19AUCCQ)

#define formating for plotly graph
f1 <- list(size = 25)
xformat3 <- list(title = "Total Dose (mg/day)", titlefont = f1,showticklabels = TRUE, tickfont = f1)
yformat3 <- list(title = "Central Compartment [CQ] AUC (mg x hr/L)",titlefont = f1,showticklabels = TRUE, tickfont = f1)

#create a vector that represents all the dose conditions that we're testing and add it to the dataframe
# dose_vector <- c('500', '556', '611', '667', '722', '778', '833', '889', '944', '1000')
dose_vector <- c(500, 556, 611, 667, 722, 778, 833, 889, 944, 1000)
df_COVID19AUCCQ$dose<- dose_vector

C19P3 <- ggplot(df_COVID19AUCCQ, aes(x = dose, y = varDose.AUCCQmedian))+
  geom_bar(stat="identity", width=30)+
  geom_errorbar(aes(ymin=varDose.AUCCQ.iqr.lower, ymax=varDose.AUCCQ.iqr.upper), width= 20, position=position_dodge(.9))+
  theme_bw()

print(C19P3)
COVID19_P3 <- ggplotly(C19P3)
COVID19_P3 <- COVID19_P3 %>% layout(xaxis = xformat3, yaxis = yformat3, showlegend = TRUE)
COVID19_P3
