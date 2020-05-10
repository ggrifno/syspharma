# Systems Pharamcology Final Project Spring 2020
# Gabrielle Grifno

#LOCAL SENSITIVIY ANALYSIS
#load packages
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly) #for plotly graphing

# MALARIA: Univariate analysis local sensitivity bar graph -------------------------

#load in data for univariate analysis
DataAUC = readMat('LocalSensiAUC.mat', header = T)

#organize as dataframes from .mat files
df_AUC = as.data.frame(DataAUC)

#add in a column for the variable names
df_AUC$variables <- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
# df_AUC$x <- factor(df_AUC$x, levels = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"))

xform <- list(categoryorder = "array",
              categoryarray = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"))
#rename columns to reflect the type of data
names(df_AUC)[1] <- 'CQ'
names(df_AUC)[2] <- 'CQstdev'
names(df_AUC)[3] <- 'DCQ'
names(df_AUC)[4] <- 'DCQstdev'

#Local sensitivity figure 1: univariate analysis bar graph

#formatting for plotly graph

f1 <- list(
  size = 22
)

xformat <- list(
  title = "Variables",
  titlefont = f1,
  showticklabels = TRUE,
  tickangle = 360,
  tickfont = f1
  # exponentformat = "E"
)

yformat <- list(
  title = "Normalized Sensitivity of AUC",
  titlefont = f1,
  showticklabels = TRUE,
  # tickangle = 225,
  tickfont = f1,
  range = c(-1,1)
  # exponentformat = "E"
)

figbar <- plot_ly(df_AUC, x = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"), y = ~CQ, type = 'bar', name = 'CQ central',
error_y = ~list(array = CQstdev, color= '#000000'))
figbar <- figbar %>% add_trace(y = ~DCQ, name = 'CDQ central',error_y = ~list(array = DCQstdev, color = '#000000'))

# figbar <- figbar %>% layout(yaxis = list(title = list( 'Normalized Sensitivity of AUC', size = 6), tickfont = list(size = 26)),
#                             xaxis = list(title = list('Variable', size = 26), tickfont = list(size = 26)),
#                             barmode = 'group')
figbar <- figbar %>% layout(xaxis = xformat, yaxis = yformat, showlegend = TRUE, legend = list(font = list(size = 20)))
# figbar$x <- factor(figbar$x, levels = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"))
# layout(xaxis = xform)
figbar


