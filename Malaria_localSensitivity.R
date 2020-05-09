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

figbar <- plot_ly(df_AUC, x = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"), y = ~CQ, type = 'bar', name = 'CQ central')
figbar <- figbar %>% add_trace(y = ~DCQ, name = 'CDQ central')
figbar <- figbar %>% layout(yaxis = list(title = 'Count', size = 18, tickfont = list(size = 16)),
                            xaxis = list(title = 'Variable', size = 18, tickfont = list(size = 16)),
                            barmode = 'group')
# figbar$x <- factor(figbar$x, levels = c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka"))
layout(xaxis = xform)
figbar


