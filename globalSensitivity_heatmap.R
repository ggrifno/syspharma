#ggrifno systems pharma FINAL PROJECT

#plots for the global sensitivity
#call libraries that will be needed
library(R.matlab)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2) #need this to use melt funtion
library(plotly)
#FIGURE 1A--------------------------------------------------

#get the simulation data from MATLAB
Data_Malaria <- readMat('global_sensi_Malaria.mat',header=T)
df1a <- as.data.frame(Data_Malaria)# Convert from list to data frame
df1a_values <- select(df1a, 'peakCQ.mean.Malaria.10','peakCQ.mean.Malaria.9', 'peakCQ.mean.Malaria.8', 'peakCQ.mean.Malaria.7', 'peakCQ.mean.Malaria.6', 'peakCQ.mean.Malaria.5','peakCQ.mean.Malaria.4', 'peakCQ.mean.Malaria.3', 'peakCQ.mean.Malaria.2', 'peakCQ.mean.Malaria.1')
mat_1a <- as.matrix(df1a_values, rownames.force = NA)
#format matrix for heatmap

rownames(mat_1a)<- c("0.00144", '0.00018', '0.00099', '0.00086', '0.00076', '0.00068', '0.000618', '0.000565', '0.000519', '0.00048')
colnames(mat_1a)<- c('25.0','27.77','30.55','33.3','36.1','38.88','41.66', '44.44', '47.22','50.0')

#formatting for heat maps with Plotly
f1 <- list(size = 20)
xformat1 <- list(title = "CQ Clearance rate (hr-1)", titlefont = f1, showticklabels = TRUE, tickfont = f1)
yformat1 <- list(title = "Total Dose (mg/kg)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatMalaria <- plot_ly(x=rownames(mat_1a),y=colnames(mat_1a),z = mat_1a, type = "heatmap", colorbar = list(title = list(text = "Peak [CQ]", font = f1), tickfont = f1))
heatMalaria<- heatMalaria%>% layout(xaxis = xformat1, yaxis = yformat1)
heatMalaria

#FIGURE 1B--------------------------------------------------

Data_COVID19 <- readMat('global_sensi_COVID19.mat',header=T)
df1b <- as.data.frame(Data_COVID19)# Convert from list to data frame
df1b_values <- select(df1b, 'peakCQ.mean.C19.10','peakCQ.mean.C19.9', 'peakCQ.mean.C19.8', 'peakCQ.mean.C19.7', 'peakCQ.mean.C19.6', 'peakCQ.mean.C19.5','peakCQ.mean.C19.4', 'peakCQ.mean.C19.3', 'peakCQ.mean.C19.2', 'peakCQ.mean.C19.1')
mat_1b <- as.matrix(df1b_values, rownames.force = NA)
#format matrix for heatmap

rownames(mat_1b)<- c("0.00144", '0.00018', '0.00099', '0.00086', '0.00076', '0.00068', '0.000618', '0.000565', '0.000519', '0.00048')
colnames(mat_1b)<- c('500.0','555.55','611.11','666.66','722.22','777.77','833.33', '888.88', '944.44','1000.00')

#formatting for heat maps with Plotly
f1 <- list(size = 20)
xformat1 <- list(title = "CQ Clearance rate (hr-1)", titlefont = f1, showticklabels = TRUE, tickfont = f1)
yformat1 <- list(title = "Total Dose (mg/kg)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatCOVID19 <- plot_ly(x=rownames(mat_1b),y=colnames(mat_1b),z = mat_1b, type = "heatmap", colorbar = list(title = list(text = "Peak [CQ]", font = f1), tickfont = f1))
heatCOVID19<- heatCOVID19%>% layout(xaxis = xformat1, yaxis = yformat1)
heatCOVID19

#OLD CODE --------------------

#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df1_values <- select(df1a, 'dose.total.Malaria', 'peakCQ.mean.Malaria.10','peakCQ.mean.Malaria.9', 'peakCQ.mean.Malaria.8', 'peakCQ.mean.Malaria.7', 'peakCQ.mean.Malaria.6', 'peakCQ.mean.Malaria.5','peakCQ.mean.Malaria.4', 'peakCQ.mean.Malaria.3', 'peakCQ.mean.Malaria.2', 'peakCQ.mean.Malaria.1')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df1_values)[1] <- 'Dose'
names(df1_values)[2] <- '0.00048'
names(df1_values)[3] <- '0.00052'
names(df1_values)[4] <- '0.00057'
names(df1_values)[5] <- '0.00062'
names(df1_values)[6] <- '0.00068'
names(df1_values)[7] <- '0.00076'
names(df1_values)[8] <- '0.00087'
names(df1_values)[9] <- '0.00100'
names(df1_values)[10] <- '0.00118'
names(df1_values)[11]<- '0.00144'

# #melt the dataframe to put it in a format that can be used to make a heatmap
df1_melt <- melt(df1_values,id.vars='Dose')
names(df1_melt)[2]<- 'kCQ'
names(df1_melt)[3]<- 'ConcentrationCQ'

p1a <- ggplot(df1_melt, aes(x=kCQ,y=Dose,fill=ConcentrationCQ)) + geom_tile(color='black') +
  theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=3,limit=c(1,5),name='Peak [CQ] (mg/L)')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  # coord_fixed()+
  xlab('CQ Clearance Rate (hr-1)')+
  ylab('Dose (mg/kg)')+
  # ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('Malaria Global Sensitivity') # for the main title
print(p1a)

#FIGURE 1B--------------------------------------------------

#get the simulation data from MATLAB
Data_COVID19 <- readMat('global_sensi_COVID19.mat',header=T)
df1b <- as.data.frame(Data_COVID19)# Convert from list to data frame

#make a new dataframe with just the cure values (have to select in reverse to get axes to format correctly)
df1b_values <- select(df1b, 'dose.vector.C19.1', 'peakCQ.mean.C19.10','peakCQ.mean.C19.9', 'peakCQ.mean.C19.8', 'peakCQ.mean.C19.7', 'peakCQ.mean.C19.6', 'peakCQ.mean.C19.5','peakCQ.mean.C19.4', 'peakCQ.mean.C19.3', 'peakCQ.mean.C19.2', 'peakCQ.mean.C19.1')
#rename the column headers from default names that were passed in from MATLAB to the kP values
names(df1b_values)[1] <- 'Dose'
names(df1b_values)[2] <- '0.00048'
names(df1b_values)[3] <- '0.00052'
names(df1b_values)[4] <- '0.00057'
names(df1b_values)[5] <- '0.00062'
names(df1b_values)[6] <- '0.00068'
names(df1b_values)[7] <- '0.00076'
names(df1b_values)[8] <- '0.00087'
names(df1b_values)[9] <- '0.00100'
names(df1b_values)[10]<- '0.00118'
names(df1b_values)[11]<- '0.00144'

# #melt the dataframe to put it in a format that can be used to make a heatmap
df1b_melt <- melt(df1b_values,id.vars='Dose')
names(df1b_melt)[2]<- 'kCQ'
names(df1b_melt)[3]<- 'ConcentrationCQ'

p1b <- ggplot(df1b_melt, aes(x=kCQ,y=Dose,fill=ConcentrationCQ)) + geom_tile(color='black') +
  theme_minimal() +
  scale_fill_gradient2(low='darkblue',high='darkred',mid='white',midpoint=3,limit=c(1,5),name='Peak [CQ] (mg/L)')+
  theme(axis.text.x =element_text(angle=90,vjust=1,hjust=1), text=element_text(size=18))+
  # coord_fixed()+
  xlab('CQ Clearance Rate (hr-1)')+
  ylab('Dose (mg/day)')+
  # ggtitle('Standard MIC: Chloroquine Efficacy for Variable Dose and Parasite Drug Sensitivity') # for the main title
  ggtitle('COVID-19 Global Sensitivity') # for the main title
print(p1b)

outfig<- ggarrange(p1a, p1b, nrow=1, ncol=2, common.legend = TRUE, legend = 'right')
print(outfig)
ggsave(file="globalSensResults.png",plot=outfig,width=12,height=6)
