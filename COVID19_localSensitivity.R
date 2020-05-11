# Systems Pharamcology Final Project Spring 2020
# Gabrielle Grifno

#LOCAL SENSITIVIY ANALYSIS - COVID-19
#load packages
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly) #for plotly graphing

# MALARIA: Univariate analysis local sensitivity bar graph -------------------------

#load in data for univariate analysis
DataAUC = readMat('LocalSensiAUC-COVID-19.mat', header = T)

#organize as dataframes from .mat files
df_AUC = as.data.frame(DataAUC)

#add in a column for the variable names
df_AUC$variables <- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")

xform <- list(categoryorder = "array",
              categoryarray = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"))
#rename columns to reflect the type of data
names(df_AUC)[1] <- 'CQ'
names(df_AUC)[2] <- 'CQstdev'
names(df_AUC)[3] <- 'DCQ'
names(df_AUC)[4] <- 'DCQstdev'


#Local sensitivity figure 1: univariate analysis bar graph

#formatting for plotly graph
f1 <- list(size = 25)
xformat <- list(title = "Variables", titlefont = f1,showticklabels = TRUE,  tickangle = 290,tickfont = f1)
yformat <- list(title = "Normalized Sensitivity of AUC",titlefont = f1,showticklabels = TRUE, tickfont = f1, range = c(-1,1))

#make the plot
figbar <- plot_ly(df_AUC, 
                  x = ~variables,
                  y = ~CQ, type = 'bar',color = I("light blue"), name = 'CQ central',
                  error_y = ~list(array = CQstdev, color= '#000000'))
figbar <- figbar %>% add_trace(df_AUC,
                               x = ~variables,
                               y = ~DCQ, type = 'bar',color = I("pink"), name = 'CDQ central',
                               error_y = ~list(array = DCQstdev, color = '#000000'))
figbar <- figbar %>% layout(xaxis = xformat, yaxis = yformat, showlegend = TRUE, legend = list(font = list(size = 25)))

figbar

# MALARIA: Time-dependent sensitivity analysis line graph -------------------------

#load in data for univariate analysis
timeCQ = readMat('LocalSensiCQ-COVID19.mat', header = T)
timeDCQ = readMat('LocalSensiDCQ-COVID19.mat', header = T)

#organize as dataframes from .mat files
df_CQtime = as.data.frame(timeCQ)
df_DCQtime = as.data.frame(timeDCQ)

#rename the columns as variables
names(df_CQtime)[1] <- 'Time'
names(df_CQtime)[2] <- 'q'
names(df_CQtime)[3] <- 'vCQ1'
names(df_CQtime)[4] <- 'vCQ2'
names(df_CQtime)[5] <- 'vDCQ1'
names(df_CQtime)[6] <- 'vDCQ2'
names(df_CQtime)[7] <- 'k10'
names(df_CQtime)[8] <- 'k30'
names(df_CQtime)[9] <- 'k12'
names(df_CQtime)[10] <- 'k21'
names(df_CQtime)[11] <- 'k23'
names(df_CQtime)[12] <- 'k34'
names(df_CQtime)[13] <- 'k43'
names(df_CQtime)[14] <- 'ka'

f1 <- list(size = 22)

xformat1 <- list(
  title = "Time (days)",
  titlefont = f1,
  showticklabels = TRUE,
  tickangle = 360,
  tickfont = f1
)

yformat1 <- list(
  title = "Normalized Sensitivity of Central Compartment [CQ]",
  titlefont = f1,
  showticklabels = TRUE,
  # tickangle = 225,
  tickfont = f1,
  range = c(-1,1)
  # exponentformat = "E"
)


figline <- plot_ly(df_CQtime, x = ~Time, y = ~q, name = 'q', type = 'scatter', mode = 'lines') 
figline<- figline%>% add_trace(y = ~vCQ1, name = 'vCQ1', mode = 'lines') 
figline<- figline%>% add_trace(y = ~vCQ2, name = 'vCQ2', mode = 'lines')
figline<- figline%>% add_trace(y = ~vDCQ1, name = 'vDCQ1', mode = 'lines') 
figline<- figline%>% add_trace(y = ~vDCQ2, name = 'vDCQ2', mode = 'lines')
figline<- figline%>% add_trace(y = ~k10, name = 'k10', mode = 'lines') 
figline<- figline%>% add_trace(y = ~k30, name = 'k30', mode = 'lines')
figline<- figline%>% add_trace(y = ~k12, name = 'k12', mode = 'lines') 
figline<- figline%>% add_trace(y = ~k21, name = 'k21', mode = 'lines')
figline<- figline%>% add_trace(y = ~k23, name = 'k23', mode = 'lines') 
figline<- figline%>% add_trace(y = ~k34, name = 'k34', mode = 'lines')
figline<- figline%>% add_trace(y = ~k43, name = 'k43', mode = 'lines')
figline<- figline%>% add_trace(y = ~ka, name = 'ka', mode = 'lines') 
figline<- figline%>% layout(xaxis = xformat1, yaxis = yformat1, showlegend = TRUE, legend = list(font = list(size = 20)))

figline

#Malaria [CQ] Heatmap time ------------------

#import heatmap data
dataCQheat = readMat('HeatDataCQdoseCOVID19.mat', header = T)
# dataCQheattime = readMat('HeatDataCQtime.mat', header = T)
#make dataframes
df_CQheat = as.data.frame(dataCQheat)
mat_CQheat = as.matrix(df_CQheat, rownames.force = NA)
# df_CQheattime = as.data.frame(dataCQheattime)
# mat_CQheattime = as.matrix(time, rownames.force = NA)

#relabel the columns with dose sizes
names(mat_CQheat)[1] <- '25.0'
names(mat_CQheat)[2] <- '27.8'
names(mat_CQheat)[3] <- '30.6'
names(mat_CQheat)[4] <- '33.3'
names(mat_CQheat)[5] <- '36.1'
names(mat_CQheat)[6] <- '38.9'
names(mat_CQheat)[7] <- '41.7'
names(mat_CQheat)[8] <- '44.4'
names(mat_CQheat)[9] <- '47.2'
names(mat_CQheat)[10]<- '50.0'
rownames(mat_CQheat)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(mat_CQheat)<- c('25.0','27.8','30.6','33.3', '36.1','38.9','41.7','44.4','47.2','50.0')
mat_CQheat <- t(mat_CQheat)

#formatting for heat maps
f1 <- list(size = 30)
xformat1 <- list(title = "Variable", titlefont = f1, showticklabels = TRUE,  tickangle = 290, tickfont = f1)
yformat1 <- list(title = "Dose (mg/mL)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatCQ <- plot_ly(x=colnames(mat_CQheat),y=rownames(mat_CQheat),z = mat_CQheat, type = "heatmap", colorbar = list(title = list(text = "Peak [CQ]", font = f1), tickfont = f1))
heatCQ<- heatCQ%>% layout(xaxis = xformat1, yaxis = yformat1)
heatCQ


#Malaria: [DCQ] Heatmap time ------------------

#import heatmap data
dataDCQheat = readMat('HeatDataDCQdoseCOVID19.mat', header = T)
# dataDCQtime = readMat('HeatDataDCQtime.mat', header = T)
#make dataframes
df_DCQheat = as.data.frame(dataCQheat)
mat_DCQheat = as.matrix(df_DCQheat,rownames.force = NA)

names(mat_DCQheat)[1] <- '25.0'
names(mat_DCQheat)[2] <- '27.8'
names(mat_DCQheat)[3] <- '30.6'
names(mat_DCQheat)[4] <- '33.3'
names(mat_DCQheat)[5] <- '36.1'
names(mat_DCQheat)[6] <- '38.9'
names(mat_DCQheat)[7] <- '41.7'
names(mat_DCQheat)[8] <- '44.4'
names(mat_DCQheat)[9] <- '47.2'
names(mat_DCQheat)[10]<- '50.0'
rownames(mat_DCQheat)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(mat_DCQheat)<- c('25.0','27.8','30.6','33.3', '36.1','38.9','41.7','44.4','47.2','50.0')
mat_DCQheat <- t(mat_DCQheat)

#heatmap plot of [CQ] in the central compartment
f1 <- list(size = 30)
xformat1 <- list(title = "Variable", titlefont = f1, showticklabels = TRUE,  tickangle = 290, tickfont = f1)
yformat1 <- list(title = "Dose (mg/mL)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatDCQ <- plot_ly(x=colnames(mat_DCQheat),y=rownames(mat_DCQheat),z = mat_DCQheat, type = "heatmap", colorbar = list(title = list(text = "Peak [DCQ]", font = f1), tickfont = f1))
heatDCQ<- heatCQ%>% layout(xaxis = xformat1, yaxis = yformat1)
heatDCQ

