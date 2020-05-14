#load relevant libraries
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
library("viridis")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Chloroquine in Malaria vs. COVID-19"),
    #creates tabs in a main panel
    mainPanel(
        tabsetPanel(
            #first panel shows PK plots
            tabPanel("PK",
    #One row w/ 2 plots each
    fluidRow(
        column(6,
               plotlyOutput('CQ',height=350,width=400),
               h5('Panel A: Concentration vs. time plots of chloroquine in central compartment for all patients.')
        ),
        column(6,
               plotlyOutput('DCQ',height=350,width=400),
               h5('Panel B: Concentration vs. time plots of desethylchloroquine in central compartment for all patients.')
        ),
        column(6,
               plotlyOutput('violin',height=350,width=400),
               h5('Panel C: Violin plot showing distribution of AUC for all patients.')
        ),
    ),
    wellPanel(
        selectInput('disease',"Disease",c('Malaria','COVID-19'))
    )
    ),
    tabPanel("Missed/Late Dosing, Malaria",
             fluidRow(
                 column(6,
                        plotlyOutput('MissedCQ',height=350,width=400),
                        h5('Chloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('MissedDCQ',height=350,width=400),
                        h5('Desethlychloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('Late2CQ',height=350,width=400),
                        h5('Chloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('Late2DQ',height=350,width=400),
                        h5('Desethylchloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('Late3CQ',height=350,width=400),
                        h5('Chloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('Late3DQ',height=350,width=400),
                        h5('Desethylchloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('Late4CQ',height=350,width=400),
                        h5('Chloroquine Concentration')
                 ),
                 column(6,
                        plotlyOutput('Late4DQ',height=350,width=400),
                        h5('Desethylchloroquine Concentration')
                 ),
             )),
    tabPanel("Population Parameters",
      # Sidebar with a slider input for number of bins 
      fluidRow(
        column(6,
               plotlyOutput('wt'),
               h5('Panel A: Violin plots displaying the distribution of weight for each sex in the patient population.')
        ),
        column(6,
               plotlyOutput('scatter'),
               h5('Pabel B: A scatter plot displaying the disribution of the selected parameter over the weight range')
        ),
        column(6,
               wellPanel(sliderInput("Weight", label = h3("Weight Range"), min = 0, 
                              max = 450, value = c(0, 450), width = 2000))
        ),
        column(6,
      wellPanel(selectInput("pl", label = h3("Parameter"), c('CQ V1','CQ V2','DCQ V1','DCQ V2','CQ Clearance','DCQ Clearance')))
        ),
)))))

#==================================================================================

mal_CQ_mat <- readMat('NormalD_Malaria_PK_CQCentral.mat',header=T)
mal_CQ_dat <- as.data.frame(mal_CQ_mat)
cov_CQ_mat <- readMat('NormalD_COVID_PK_CQCentral.mat',header=T)
cov_CQ_dat <- as.data.frame(cov_CQ_mat)
mal_DCQ_mat <- readMat('NormalD_Malaria_PK_DQCentral.mat',header=T)
mal_DCQ_dat <- as.data.frame(mal_DCQ_mat)
cov_DCQ_mat <- readMat('NormalD_COVID_PK_DQCentral.mat',header=T)
cov_DCQ_dat <- as.data.frame(cov_DCQ_mat)
mal_AUCCQ_mat <- readMat('NormalD_Malaria_PK_AUCCQ.mat',header=T)
mal_AUCCQ_dat <- as.data.frame(mal_AUCCQ_mat)
mal_AUCDCQ_mat <- readMat('NormalD_Malaria_PK_AUCDCQ.mat',header=T)
mal_AUCDCQ_dat <- as.data.frame(mal_AUCDCQ_mat)
cov_AUCCQ_mat <- readMat('NormalD_COVID_PK_AUCCQ.mat',header=T)
cov_AUCCQ_dat <- as.data.frame(cov_AUCCQ_mat)
cov_AUCDCQ_mat <- readMat('NormalD_COVID_PK_AUCDCQ.mat',header=T)
cov_AUCDCQ_dat <- as.data.frame(cov_AUCDCQ_mat)
m_CQ<-t(mal_AUCCQ_dat)
lab1='CQ'
m_DCQ<-t(mal_AUCDCQ_dat)
lab2='DCQ'
m_AUCC<-cbind(lab1,m_CQ)
colnames(m_AUCC)<-c('lab','V1')
m_AUCD<-cbind(lab2,m_DCQ)
colnames(m_AUCD)<-c('lab','V1')
m_AUC1<-rbind(m_AUCC,m_AUCD)
mAUC<-as.data.frame(m_AUC1)
c_CQ<-t(cov_AUCCQ_dat)
c_DCQ<-t(cov_AUCDCQ_dat)
c_AUCC<-cbind(lab1,c_CQ)
colnames(c_AUCC)<-c('lab','V1')
c_AUCD<-cbind(lab2,c_DCQ)
colnames(c_AUCD)<-c('lab','V1')
c_AUC1<-rbind(c_AUCC,c_AUCD)
cAUC<-as.data.frame(c_AUC1)

mal_CQ <- melt(mal_CQ_dat, id.vars = "Time")
mal_DCQ <- melt(mal_DCQ_dat, id.vars = "Time")
cov_CQ <- melt(cov_CQ_dat, id.vars = "Time")
cov_DCQ <- melt(cov_DCQ_dat, id.vars = "Time")

#Load Missed/LateDose Data
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

mat <- readMat('data/data.mat',header=T)
dat <- as.data.frame(mat)
dat $SexLabels<- as.factor(dat$SexLabels)

df_m<-dat[1:50,]
df_f<-dat[51:100,]

#pre-plot parameter scatter plots
g1<-ggplot(NULL) +
  geom_point(data = df_m, aes(x = WeightVal, y = v1cq, col = "Male"))+
  geom_point(data = df_f, aes(x = WeightVal, y = v1cq, col = "Female"))+
  ggtitle('Chloroquine Central Compartment Volume (V1)') +
  xlab('Weight (lb)')+
  ylab('Central Compartment Volume: V1 (L)')+
  scale_x_continuous('Weight (lb)',limits = c(0,450))+
  scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))+
  theme(plot.title = element_text(size=10))
fig_CQV1 <- ggplotly(g1)

g2<-ggplot(NULL) +
  geom_point(data = df_m, aes(x = WeightVal, y = v2cq, col = "Male"))+
  geom_point(data = df_f, aes(x = WeightVal, y = v2cq, col = "Female"))+
  ggtitle('Chloroquine Peripheral Compartment Volume (V2)') +
  xlab('Weight (lb)')+
  ylab('Peripheral Compartment Volume: V2 (L)')+
  scale_x_continuous('Weight (lb)',limits = c(0,450))+
  scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))+
  theme(plot.title = element_text(size=10))
fig_CQV2 <- ggplotly(g2)

g3<-ggplot(NULL) +
  geom_point(data = df_m, aes(x = WeightVal, y = v1dcq, col = "Male"))+
  geom_point(data = df_f, aes(x = WeightVal, y = v1dcq, col = "Female"))+
  ggtitle('Desethylhloroquine Central Compartment Volume (V1)') +
  xlab('Weight (lb)')+
  ylab('Central Compartment Volume: V1 (L)')+
  scale_x_continuous('Weight (lb)',limits = c(0,450))+
  scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))+
  theme(plot.title = element_text(size=10))
fig_DCQV1 <- ggplotly(g3)

g4<-ggplot(NULL) +
  geom_point(data = df_m, aes(x = WeightVal, y = v2dcq, col = "Male"))+
  geom_point(data = df_f, aes(x = WeightVal, y = v2dcq, col = "Female"))+
  ggtitle('Desethylhloroquine Peripheral Compartment Volume (V2)') +
  xlab('Weight (lb)')+
  ylab('Peripheral Compartment Volume: V2 (L)')+
  scale_x_continuous('Weight (lb)',limits = c(0,450))+
  scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))+
  theme(plot.title = element_text(size=10))
fig_DCQV2 <- ggplotly(g4)

g5<-ggplot(NULL) +
  geom_point(data = df_m, aes(x = WeightVal, y = K10, col = "Male"))+
  geom_point(data = df_f, aes(x = WeightVal, y = K10, col = "Female"))+
  ggtitle('Clearance of Chloroquine from Central Compartment (hr^-1)') +
  xlab('Weight (lb)')+
  ylab('CQ Central Clearance (hr^-1)')+
  scale_x_continuous('Weight (lb)',limits = c(0,450))+
  scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))+
  theme(plot.title = element_text(size=10))
fig_CQcl <- ggplotly(g5)

g6<-ggplot(NULL) +
  geom_point(data = df_m, aes(x = WeightVal, y = K30, col = "Male"))+
  geom_point(data = df_f, aes(x = WeightVal, y = K30, col = "Female"))+
  ggtitle('Clearance of Desethylhloroquine from Central Compartment (hr^-1)') +
  xlab('Weight (lb)')+
  ylab('DCQ Central Clearance (hr^-1)')+
  scale_x_continuous('Weight (lb)',limits = c(0,450))+
  scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))+
  theme(plot.title = element_text(size=10))
fig_DCQcl <- ggplotly(g1)


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$CQ <- renderPlotly({ 
        df_CQ_sw <- switch(input$disease,
                            "Malaria" = mal_CQ, 
                            "COVID-19" = cov_CQ)
        p2 <- ggplot(df_CQ_sw, aes(x = Time, y = value, colour = variable)) + geom_line() +
            ggtitle('Chloroquine in Central Compartment over Time') +
            xlab("Time (hr)") +
            ylab("Chloroquine in Blood (mg/L)")
        pB <- ggplotly(p2)
        p2 + theme(legend.position = "none")
        
    }) 
    output$DCQ <- renderPlotly({ 
        df_DCQ_sw <- switch(input$disease,
                           "Malaria" = mal_DCQ, 
                           "COVID-19" = cov_DCQ)
        p2 <- ggplot(df_DCQ_sw, aes(x = Time, y = value, colour = variable)) + geom_line() +
            ggtitle('Desethylchloroquine in Central Compartment over Time') +
            xlab('Time (hr)')+
            ylab('Desethylchloroquine in Blood (mg/L)')
        pB <- ggplotly(p2)
        p2 + theme(legend.position = "none")
    }) 
    output$violin <- renderPlotly({
        df_AUC_sw <- switch(input$disease,
                            "Malaria" = mAUC, 
                            "COVID-19" = cAUC)
        fig <- df_AUC_sw %>%
            plot_ly(
                x = ~lab,
                y = ~V1,
                split = ~lab,
                type = 'violin',
                box = list(
                    visible = T
                ),
                meanline = list(
                    visible = T
                )
            ) 
        
        fig <- fig %>%
            layout(
                xaxis = list(
                    title = "Form"
                ),
                yaxis = list(
                    title = "AUC",
                    rangemode = "tozero",
                    zeroline = F
                )
            )
        
        fig
    })
    output$MissedCQ<- renderPlotly({ 
        pMDCQ <- ggplot(DMD_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
            geom_line(aes(color = 'Normal'),alpha = 1, size = 1) +
            geom_ribbon(aes(ymin=P25YCQCM0, ymax=P75YCQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
            geom_line(aes(y = MedianYCQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
            geom_ribbon(aes(ymin=P25YCQCM1, ymax=P75YCQCM1, color = 'Missed First'), fill = 'grey',alpha=0.3) +
            geom_line(aes(y = MedianYCQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
            geom_ribbon(aes(ymin=P25YCQCM2, ymax=P75YCQCM2, color = 'Missed Second'), fill = 'violetred4',alpha=0.1) +
            geom_line(aes(y = MedianYCQCM3, color = 'Missed Third'),alpha = 0.7, size = 1) +
            geom_ribbon(aes(ymin=P25YCQCM3, ymax=P75YCQCM3, color = 'Missed Third'), fill = 'orange',alpha=0.1) +
            geom_line(aes(y = MedianYCQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
            geom_ribbon(aes(ymin=P25YCQCM4, ymax=P75YCQCM4, color = 'Missed Fourth'), fill = 'purple4', alpha=0.1) +
            #formating lines
            ggtitle('A: Missed Dosing') + # for the main title
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
                  #legend.position = "none",
                  plot.title = element_text(size = 11, face = "bold"),
                  axis.title = element_text(size = 10))+
            scale_y_continuous(limits = c(0.0, 1.2))
        
    }) 
    output$MissedDCQ<- renderPlotly({ 
      pMDDQ <- ggplot(DMD_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
        geom_line(aes(color = 'Normal'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM0, ymax=P75YDQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
        geom_line(aes(y = MedianYDQCM1, color = 'Missed First'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM1, ymax=P75YDQCM1, color = 'Missed First'), fill = 'grey', alpha=0.3) +
        geom_line(aes(y = MedianYDQCM2, color = 'Missed Second'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2, color = 'Missed Second'), fill = 'violetred4',alpha=0.1) +
        geom_line(aes(y = MedianYDQCM3, color = 'Missed Third'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM3, ymax=P75YDQCM3, color = 'Missed Third'), fill = 'orange',alpha=0.1) +
        geom_line(aes(y = MedianYDQCM4, color = 'Missed Fourth'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM4, color = 'Missed Fourth'), fill = 'purple4',alpha=0.1) +
        
        #formating lines
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
      
    }) 
    output$Late2CQ<- renderPlotly({ 
    pL2CQ <- ggplot(D2_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
      geom_line(aes(color = 'Normal'), size = 1) +
      geom_line(aes(y = MedianYCQCM1, color = '1.2 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYCQCM2, color = '2.4 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYCQCM3, color = '3.6 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYCQCM4, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYCQCM5, color = '6 Hours Late'),alpha = 0.7, size = 1) +
      geom_ribbon(aes(ymin=P25YCQCM0, ymax=P75YCQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM1, ymax=P75YCQCM1, color = '1.2 Hours Late'), fill = 'grey', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM2, ymax=P75YCQCM2, color = '2.4 Hours Late'), fill = 'purple4', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM3, ymax=P75YCQCM3, color = '3.6 Hours Late'), fill = 'violetred4', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM4, ymax=P75YCQCM4, color = '4.8 Hours Late'), fill = 'red', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM5, ymax=P75YCQCM5, color = '6 Hours Late'), fill = 'orange', alpha=0.1) +
      
      #formating lines
      ggtitle('B: Taking Second Dose Late') + # for the main title
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
            axis.title = element_text(size = 10))
    })
    
    output$Late2DQ<- renderPlotly({ 
      pL2DQ <- ggplot(D2_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
    geom_line(aes(color = 'Normal'), size = 1) +
      geom_line(aes(y = MedianYDQCM1, color = '1.2 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYDQCM2, color = '2.4 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYDQCM3, color = '3.6 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYDQCM4, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
      geom_line(aes(y = MedianYDQCM5, color = '6 Hours Late'),alpha = 0.7, size = 1) +
      geom_ribbon(aes(ymin=P25YDQCM0, ymax=P75YDQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM1, ymax=P75YDQCM1, color = '1.2 Hours Late'), fill = 'grey', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2, color = '2.4 Hours Late'), fill = 'purple4', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM3, ymax=P75YDQCM3, color = '3.6 Hours Late'), fill = 'violetred4', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM4, color = '4.8 Hours Late'), fill = 'red', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM5, ymax=P75YDQCM5, color = '6 Hours Late'), fill = 'orange', alpha=0.1) +
      
      #formating lines
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
            axis.title = element_text(size = 10)) +
        scale_y_continuous(limits = c(0.0, 1.2))
      
})
    output$Late3CQ<- renderPlotly({ 
      pL3CQ <- ggplot(D3_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
        geom_line(aes(color = 'Normal'), size = 1) +
        geom_line(aes(y = MedianYCQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +        
        geom_line(aes(y = MedianYCQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYCQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYCQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYCQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YCQCM0, ymax=P75YCQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM1, ymax=P75YCQCM1, color = '4.8 Hours Late'), fill = 'red', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM2, ymax=P75YCQCM2, color = '9.6 Hours Late'), fill = 'orange', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM3, ymax=P75YCQCM3, color = '14.4 Hours Late'), fill = 'grey', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM4, ymax=P75YCQCM4, color = '19.2 Hours Late'), fill = 'purple4', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM5, ymax=P75YCQCM5, color = '24 Hours Late'), fill = 'violetred4', alpha=0.1) +
        
        #formating lines
        ggtitle('C: Taking Third Dose Late') + # for the main title
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
              axis.title = element_text(size = 10))
    })
    
    output$Late3DQ<- renderPlotly({ 
      pL3DQ <- ggplot(D3_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
        scale_y_continuous(limits = c(0.0, 1.2))+
        geom_line(aes(color = 'Normal'), size = 1) +
        geom_line(aes(y = MedianYDQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM0, ymax=P75YDQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM1, ymax=P75YDQCM1, color = '4.8 Hours Late'), fill = 'red', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2, color = '9.6 Hours Late'), fill = 'orange', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM3, ymax=P75YDQCM3, color = '14.4 Hours Late'), fill = 'grey', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM4, color = '19.2 Hours Late'), fill = 'purple4', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM5, color = '24 Hours Late'), fill = 'violetred4', alpha=0.1) +
        
        #formating lines
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
              axis.title = element_text(size = 10))
      
    })
    
    output$Late4CQ<- renderPlotly({ 
      pL4CQ <- ggplot(D4_CQ, aes(x = T/24, y = MedianYCQCM0)) + 
        geom_line(aes(color = 'Normal'), size = 1) +
        geom_line(aes(y = MedianYCQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +        
        geom_line(aes(y = MedianYCQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYCQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYCQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYCQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YCQCM0, ymax=P75YCQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM1, ymax=P75YCQCM1, color = '4.8 Hours Late'), fill = 'red', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM2, ymax=P75YCQCM2, color = '9.6 Hours Late'), fill = 'orange', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM3, ymax=P75YCQCM3, color = '14.4 Hours Late'), fill = 'grey', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM4, ymax=P75YCQCM4, color = '19.2 Hours Late'), fill = 'purple4', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YCQCM5, ymax=P75YCQCM5, color = '24 Hours Late'), fill = 'violetred4', alpha=0.1) +
        
        #formating lines
        ggtitle('D: Taking Final Dose Late') + # for the main title
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
              axis.title = element_text(size = 10))
    })
    
    output$Late4DQ<- renderPlotly({ 
      pL4DQ <- ggplot(D4_DQ, aes(x = T/24, y = MedianYDQCM0)) + 
        scale_y_continuous(limits = c(0.0, 1.2))+
        geom_line(aes(color = 'Normal'), size = 1) +
        geom_line(aes(y = MedianYDQCM1, color = '4.8 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM2, color = '9.6 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM3, color = '14.4 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM4, color = '19.2 Hours Late'),alpha = 0.7, size = 1) +
        geom_line(aes(y = MedianYDQCM5, color = '24 Hours Late'),alpha = 0.7, size = 1) +
        geom_ribbon(aes(ymin=P25YDQCM0, ymax=P75YDQCM0, color = 'Normal'), fill = 'yellow', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM1, ymax=P75YDQCM1, color = '4.8 Hours Late'), fill = 'red', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2, color = '9.6 Hours Late'), fill = 'orange', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM3, ymax=P75YDQCM3, color = '14.4 Hours Late'), fill = 'grey', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM4, color = '19.2 Hours Late'), fill = 'purple4', alpha=0.1) +
        geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM5, color = '24 Hours Late'), fill = 'violetred4', alpha=0.1) +
        
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
              axis.title = element_text(size = 10))
      
    })
    
    output$wt <- renderPlotly({
      fig <- dat %>%
        plot_ly(
          x = ~SexLabels,
          y = ~WeightVal,
          split = ~SexLabels,
          type = 'violin',
          box = list(
            visible = T
          ),
          meanline = list(
            visible = T
          )
        ) 
      
      fig <- fig %>%
        layout(
          xaxis = list(
            title = "Sex"
          ),
          yaxis = list(
            title = "Weight (lb)",
            range = input$Weight,
            zeroline = F
          ),
          title = 'Distribution of Weight'
        )
      fig
    })
    output$scatter <- renderPlotly({
      fig <- switch(input$pl,'CQ V1'=fig_CQV1,'CQ V2'=fig_CQV2,'DCQ V1'=fig_DCQV1,'DCQ V2'=fig_DCQV2,'CQ Clearance'=fig_CQcl,'DCQ Clearance'=fig_DCQcl)
      fig
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
