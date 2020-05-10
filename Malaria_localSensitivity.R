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

# MALARIA: Time-dependent sensitivity analysis line graph -------------------------

#load in data for univariate analysis
timeCQ = readMat('LocalSensiCQ.mat', header = T)
timeDCQ = readMat('LocalSensiDCQ.mat', header = T)

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
# save HeatDataCQdose.mat sensiCQmax_dose
# save HeatDataCQtime.mat sensiCQtime_dose


#import heatmap data
dataCQheat = readMat('HeatDataCQdose.mat', header = T)
dataCQheattime = readMat('HeatDataCQtime.mat', header = T)
#make dataframes
df_CQheat = as.data.frame(dataCQheat)
mat_CQheat = as.matrix.data.frame(dataCQheat)
df_CQheattime = as.data.frame(dataCQheattime)

#relabel the columns with dose sizes
names(df_CQheat)[1] <- '25.0'
names(df_CQheat)[2] <- '27.8'
names(df_CQheat)[3] <- '30.6'
names(df_CQheat)[4] <- '33.3'
names(df_CQheat)[5] <- '36.1'
names(df_CQheat)[6] <- '38.9'
names(df_CQheat)[7] <- '41.7'
names(df_CQheat)[8] <- '44.4'
names(df_CQheat)[9] <- '47.2'
names(df_CQheat)[10]<- '50.0'
rownames(df_CQheat)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")

#heatmap plot of [CQ] in the central compartment
heatCQ <- plot_ly(z = dataCQheat, type = "heatmap")
heatCQ

df_CQheat_melt <- melt(df_CQheat)

pheatCQ <- ggplot(df_CQheat, aes(x=rownames(df_CQheat),y=colnames(df_CQheat),fill=df_CQheat) + geom_tile(color='black')) +
  theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=3,limit=c(1,5),name='Peak [CQ] (mg/L)')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  # coord_fixed()+
  xlab('Variable')+
  ylab('Dose (mg/day)')+
  # ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('local sensitivity to variable dose') # for the main title
print(pheatCQ)



heatCQTime <- plot_ly(x=colnames(df_CQtime), y=rownames(df_CQtime), z = ddf_CQtime, type = "heatmap") %>%
  layout(margin = list(l=120))
heatCQTime

heatCQout <- ggarrange(heatCQ, heatCQTime, nrow=1, ncol=2)
print(heatCQout)
# ggsave(file="heatCQout.png",plot=heatCQout,width=12,height=6)

#Malaria: [DCQ] Heatmap time ------------------
# save HeatDataDCQdose.mat sensiDCQmax_dose
# save HeatDataDCQtime.mat sensiDCQtime_dose
# 
# #import heatmap data
# dataDCQheat = readMat('title.mat', header = T)
# dataDCQtime = readMat('title.mat', header = T)
# #make dataframes
# df_DCQheat = as.data.frame(dataCQheat)
# df_DCQtime = as.data.frame(dataCQtime)
# 
# #heatmap plot of [CQ] in the central compartment
# heatDCQ <- plot_ly(x=colnames(df_DCQheat), y=rownames(df_DCQheat), z = df_DCQheat, type = "heatmap") %>%
#   layout(margin = list(l=120))
# heatDCQ
# 
# heatDCQTime <- plot_ly(x=colnames(df_DCQtime), y=rownames(df_DCQtime), z = df_DCQtime, type = "heatmap") %>%
#   layout(margin = list(l=120))
# heatDCQTime
# 
# heatDCQout <- ggarrange(heatDCQ, heatDCQTime, nrow=1, ncol=2)
# print(heatDCQout)
# # ggsave(file="heatCQout.png",plot=heatCQout,width=12,height=6)

m <- matrix(rnorm(12), nrow = 4, ncol = 3)
fig <- plot_ly(
  # x = c("a", "b", "c"), y = c("d", "e", "f"),
  z = m, type = "heatmap"
)

fig