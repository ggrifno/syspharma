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

# COVID19: Univariate analysis local sensitivity bar graph -------------------------

#load in data for univariate analysis
DataAUC_COVID19 = readMat('LocalSensiAUC-COVID-19.mat', header = T)
#organize as dataframes from .mat files
df_AUC_COVID19 = as.data.frame(DataAUC_COVID19)
#add in a column for the variable names
df_AUC_COVID19$variables <- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")

#rename columns to reflect the type of data
names(df_AUC_COVID19)[1] <- 'CQ'
names(df_AUC_COVID19)[2] <- 'CQstdev'
names(df_AUC_COVID19)[3] <- 'DCQ'
names(df_AUC_COVID19)[4] <- 'DCQstdev'

#Local sensitivity figure 1: univariate analysis bar graph
#formatting for plotly graph
f1 <- list(size = 25)
xformat <- list(title = "Variables", titlefont = f1,showticklabels = TRUE,  tickangle = 290,tickfont = f1)
yformat <- list(title = "Normalized Sensitivity of AUC",titlefont = f1,showticklabels = TRUE, tickfont = f1, range = c(-1,1))

#make the plot
figbar_C19 <- plot_ly(df_AUC_COVID19, 
                  x = ~variables,
                  y = ~CQ, type = 'bar',color = I("light blue"), name = 'CQ central',
                  error_y = ~list(array = CQstdev, color= '#000000'))
figbar_C19 <- figbar_C19 %>% add_trace(df_AUC_COVID19,
                               x = ~variables,
                               y = ~DCQ, type = 'bar',color = I("pink"), name = 'CDQ central',
                               error_y = ~list(array = DCQstdev, color = '#000000'))
figbar_C19 <- figbar_C19 %>% layout(xaxis = xformat, yaxis = yformat, showlegend = TRUE, legend = list(font = list(size = 25)))
figbar_C19

# COVID19: Time-dependent sensitivity analysis line graph -------------------------

#load in data for univariate analysis
timeCQ_C19 = readMat('LocalSensiCQ-COVID19.mat', header = T)
timeDCQ_C19 = readMat('LocalSensiDCQ-COVID19.mat', header = T)
#organize as dataframes from .mat files
df_CQtime_C19 = as.data.frame(timeCQ_C19)
df_DCQtime_C19 = as.data.frame(timeDCQ_C19)

#rename the columns as variables
colnames(df_CQtime_C19) <- c("Time", "q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(df_DCQtime_C19)<- c("Time", "q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")

#establish settings for line graphs
f1 <- list(size = 20)
xformat1 <- list(title = "Time (days)",titlefont = f1, showticklabels = TRUE, tickangle = 360, tickfont = f1)
yformat1 <- list(title = "Normalized Sensitivity of Central Compartment [CQ]",titlefont = f1, showticklabels = TRUE, tickfont = f1,range = c(-1,1))
yformat2 <- list(title = "Normalized Sensitivity of Central Compartment [DCQ]",titlefont = f1, showticklabels = TRUE, tickfont = f1,range = c(-1,1))

#make the graph for changes in CQ sensitivity over time
figlineCQ_C19 <- plot_ly(df_CQtime_C19, x = ~Time, y = ~q, name = 'q', type = 'scatter', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~vCQ1, name = 'vCQ1', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~vCQ2, name = 'vCQ2', mode = 'lines')
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~vDCQ1, name = 'vDCQ1', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~vDCQ2, name = 'vDCQ2', mode = 'lines')
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k10, name = 'k10', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k30, name = 'k30', mode = 'lines')
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k12, name = 'k12', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k21, name = 'k21', mode = 'lines')
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k23, name = 'k23', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k34, name = 'k34', mode = 'lines')
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~k43, name = 'k43', mode = 'lines')
figlineCQ_C19<- figlineCQ_C19%>% add_trace(y = ~ka, name = 'ka', mode = 'lines') 
figlineCQ_C19<- figlineCQ_C19%>% layout(xaxis = xformat1, yaxis = yformat1, showlegend = TRUE, legend = list(font = list(size = 20)))

figlineCQ_C19

#make the graph for changes in DCQ sensitivity over time
figlineDCQ_C19 <- plot_ly(df_DCQtime_C19, x = ~Time, y = ~q, name = 'q', type = 'scatter', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~vCQ1, name = 'vCQ1', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~vCQ2, name = 'vCQ2', mode = 'lines')
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~vDCQ1, name = 'vDCQ1', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~vDCQ2, name = 'vDCQ2', mode = 'lines')
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k10, name = 'k10', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k30, name = 'k30', mode = 'lines')
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k12, name = 'k12', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k21, name = 'k21', mode = 'lines')
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k23, name = 'k23', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k34, name = 'k34', mode = 'lines')
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~k43, name = 'k43', mode = 'lines')
figlineDCQ_C19<- figlineDCQ_C19%>% add_trace(y = ~ka, name = 'ka', mode = 'lines') 
figlineDCQ_C19<- figlineDCQ_C19%>% layout(xaxis = xformat1, yaxis = yformat2, showlegend = TRUE, legend = list(font = list(size = 20)))

figlineDCQ_C19

#COVID19 [CQ] Heatmap time ------------------

#import heatmap data
dataCQheat_C19 = readMat('HeatDataCQdoseCOVID19.mat', header = T)
#make dataframes
df_CQheat_C19 = as.data.frame(dataCQheat_C19)
mat_CQheat_C19 = as.matrix(df_CQheat_C19, rownames.force = NA)

#format matrices for heatmaps
rownames(mat_CQheat_C19)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(mat_CQheat_C19)<- c('500.0','555.55','611.11','666.66','722.22','777.77','833.33', '888.88', '944.44','1000.00')
mat_CQheat_C19 <- t(mat_CQheat_C19)

#formatting for heat maps
f1 <- list(size = 30)
xformat1 <- list(title = "Variable", titlefont = f1, showticklabels = TRUE,  tickangle = 290, tickfont = f1)
yformat1 <- list(title = "Total Dose (mg/day)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatCQ_C19 <- plot_ly(x=colnames(mat_CQheat_C19),y=rownames(mat_CQheat_C19),z = mat_CQheat_C19, type = "heatmap", colorbar = list(title = list(text = "Peak [CQ]", font = f1), tickfont = f1))
heatCQ_C19<- heatCQ_C19%>% layout(xaxis = xformat1, yaxis = yformat1)
heatCQ_C19

#COVID19: [DCQ] Heatmap time ------------------

#import heatmap data
dataDCQheat_C19 = readMat('HeatDataDCQdoseCOVID19.mat', header = T)
# dataDCQtime = readMat('HeatDataDCQtime.mat', header = T)
#make dataframes
df_DCQheat_C19 = as.data.frame(dataDCQheat_C19)
mat_DCQheat_C19 = as.matrix(df_DCQheat_C19,rownames.force = NA)

#format matrix for heatmaps
rownames(mat_DCQheat_C19)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(mat_DCQheat_C19)<- c('500.0','555.55','611.11','666.66','722.22','777.77','833.33', '888.88', '944.44','1000.00')
mat_DCQheat_C19 <- t(mat_DCQheat_C19)

#heatmap plot of [CQ] in the central compartment
f1 <- list(size = 30)
xformat1 <- list(title = "Variable", titlefont = f1, showticklabels = TRUE,  tickangle = 290, tickfont = f1)
yformat1 <- list(title = "Total Dose (mg/day)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatDCQ_C19 <- plot_ly(x=colnames(mat_DCQheat_C19),y=rownames(mat_DCQheat_C19),z = mat_DCQheat_C19, type = "heatmap", colorbar = list(title = list(text = "Peak [DCQ]", font = f1), tickfont = f1))
heatDCQ_C19<- heatDCQ_C19%>% layout(xaxis = xformat1, yaxis = yformat1)
heatDCQ_C19
