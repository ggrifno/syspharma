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

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Chloroquine in Malaria vs. COVID-19"),
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
)
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
}

# Run the application 
shinyApp(ui = ui, server = server)
