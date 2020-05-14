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
    tabPanel("Missed",
             fluidRow(
                 column(6,
                        plotlyOutput('MissedCQ',height=350,width=400),
                        h5('Panel A: Chloroquine Concentration as a result of missing a dose.')
                 ),
                 column(6,
                        plotlyOutput('MissedDCQ',height=350,width=400),
                        h5('Panel B: Desethlychloroquine Concentration as a result of missing a dose.')
                 ),
                 column(6,
                        plotlyOutput('Late2CQ',height=350,width=400),
                        h5('Panel C: Chloroquine Concentration as a result of missing a dose.')
                 ),
                 column(6,
                        plotlyOutput('Late2DQ',height=350,width=400),
                        h5('Panel D: Chloroquine Concentration as a result of missing a dose.')
                 ),
                 column(6,
                        plotlyOutput('Late3CQ',height=350,width=400),
                        h5('Panel E: Chloroquine Concentration as a result of missing a dose.')
                 ),
                 column(6,
                        plotlyOutput('Late3DQ',height=350,width=400),
                        h5('Panel F: Chloroquine Concentration as a result of missing a dose.')
                 ),
             )))
    
  
    ))

#==================================================================================

mal_CQ_mat <- readMat('data/NormalD_Malaria_PK_CQCentral.mat',header=T)
mal_CQ_dat <- as.data.frame(mal_CQ_mat)
cov_CQ_mat <- readMat('data/NormalD_COVID_PK_CQCentral.mat',header=T)
cov_CQ_dat <- as.data.frame(cov_CQ_mat)
mal_DCQ_mat <- readMat('data/NormalD_Malaria_PK_DQCentral.mat',header=T)
mal_DCQ_dat <- as.data.frame(mal_DCQ_mat)
cov_DCQ_mat <- readMat('data/NormalD_COVID_PK_DQCentral.mat',header=T)
cov_DCQ_dat <- as.data.frame(cov_DCQ_mat)
mal_AUCCQ_mat <- readMat('data/NormalD_Malaria_PK_AUCCQ.mat',header=T)
mal_AUCCQ_dat <- as.data.frame(mal_AUCCQ_mat)
mal_AUCDCQ_mat <- readMat('data/NormalD_Malaria_PK_AUCDCQ.mat',header=T)
mal_AUCDCQ_dat <- as.data.frame(mal_AUCDCQ_mat)
cov_AUCCQ_mat <- readMat('data/NormalD_COVID_PK_AUCCQ.mat',header=T)
cov_AUCCQ_dat <- as.data.frame(cov_AUCCQ_mat)
cov_AUCDCQ_mat <- readMat('data/NormalD_COVID_PK_AUCDCQ.mat',header=T)
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
DataMD_CQ <- readMat("data/MissedDose_Malaria_PK_CQCentral.mat",header=T) # from mat file
DMD_CQ <- as.data.frame(DataMD_CQ) # Convert .mat data into a data frame.
Data2_CQ <- readMat("data/LateDose2_Malaria_PK_CQCentral.mat",header=T) # from mat file
D2_CQ <- as.data.frame(Data2_CQ) # Convert .mat data into a data frame.
Data3_CQ <- readMat("data/LateDose3_Malaria_PK_CQCentral.mat",header=T) # from mat file
D3_CQ <- as.data.frame(Data3_CQ) # Convert .mat data into a data frame.
#Data4_CQ <- readMat("LateDose4_Malaria_PK_CQCentral.mat",header=T) # from mat file
#D4_CQ <- as.data.frame(Data4_CQ) # Convert .mat data into a data frame.

DataMD_DQ <- readMat("data/MissedDose_Malaria_PK_DQCentral.mat",header=T) # from mat file
DMD_DQ <- as.data.frame(DataMD_DQ) # Convert .mat data into a data frame.
Data2_DQ <- readMat("data/LateDose2_Malaria_PK_DQCentral.mat",header=T) # from mat file
D2_DQ <- as.data.frame(Data2_DQ) # Convert .mat data into a data frame.
Data3_DQ <- readMat("data/LateDose3_Malaria_PK_DQCentral.mat",header=T) # from mat file
D3_DQ <- as.data.frame(Data3_DQ) # Convert .mat data into a data frame.
#Data4_DQ <- readMat("LateDose4_Malaria_PK_DQCentral.mat",header=T) # from mat file
#D4_DQ <- as.data.frame(Data4_DQ) # Convert .mat data into a data frame.


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
            ggtitle('Chloroquine') + # for the main title
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
      geom_ribbon(aes(ymin=P25YCQCM1, ymax=P75YCQCM1, color = '1.2 Hours Late'), fill = 'red', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM2, ymax=P75YCQCM2, color = '2.4 Hours Late'), fill = 'orange', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM3, ymax=P75YCQCM3, color = '3.6 Hours Late'), fill = 'grey', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM4, ymax=P75YCQCM4, color = '4.8 Hours Late'), fill = 'purple4', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YCQCM5, ymax=P75YCQCM5, color = '6 Hours Late'), fill = 'violetred4', alpha=0.1) +
      
      #formating lines
      ggtitle('Chloroquine') + # for the main title
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
      geom_ribbon(aes(ymin=P25YDQCM1, ymax=P75YDQCM1, color = '1.2 Hours Late'), fill = 'red', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM2, ymax=P75YDQCM2, color = '2.4 Hours Late'), fill = 'orange', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM3, ymax=P75YDQCM3, color = '3.6 Hours Late'), fill = 'grey', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM4, ymax=P75YDQCM4, color = '4.8 Hours Late'), fill = 'purple4', alpha=0.1) +
      geom_ribbon(aes(ymin=P25YDQCM5, ymax=P75YDQCM5, color = '6 Hours Late'), fill = 'violetred4', alpha=0.1) +
      
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
        ggtitle('Chloroquine') + # for the main title
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
}

# Run the application 
shinyApp(ui = ui, server = server)
