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
    titlePanel("Population Parameters"),
    
    # Sidebar with a slider input for number of bins 
    fluidRow(
        column(6,
               plotlyOutput('wt'),
               h5('Panel A: Violin plots displaying the distribution of weight for each sex in the patient population.')
        ),
        column(6,
               plotlyOutput('v1cq'),
               h5('Panel B: Scatter plot of Chloroquine central compartment volume (V1) and weight.')
        ),
        column(6,
               plotlyOutput('v2cq'),
               h5('Panel C: Scatter plot of Chloroquine peripheral compartment volume (V2) and weight.')
        ),
        column(6,
               plotlyOutput('v1dcq'),
               h5('Panel D: Scatter plot of Desethylchloroquine central compartment volume (V1) and weight.')
        ),
        column(6,
               plotlyOutput('v2dcq'),
               h5('Panel E: Scatter plot of Desethylchloroquine peripheral compartment volume (V2) and weight.')
        ),
        column(6,
               plotlyOutput('K10'),
               h5('Panel F: Scatter plot of Chloroquine central clearance and weight.')
        ),
        column(6,
               plotlyOutput('K30'),
               h5('Panel G: Scatter plot of Desethylchloroquine central clearance and weight.')
        ),
        
    ),
    hr(),
    wellPanel(
        sliderInput("Weight", label = h3("Weight Range"), min = 0, 
                    max = 450, value = c(0, 450), width = 900)
        
    ),
    fluidRow(
        h5('')
    )
)
#===================================================================================

# Define server logic required to draw a histogram
mat <- readMat('data/data.mat',header=T)
dat <- as.data.frame(mat)
dat $SexLabels<- as.factor(dat$SexLabels)

df_m<-dat[1:50,]
df_f<-dat[51:100,]

server <- function(input, output) {
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
    output$v1cq <- renderPlotly({
        g1<-ggplot(NULL) + 
            geom_point(data = df_m, aes(x = WeightVal, y = v1cq, col = "Male"))+
            geom_point(data = df_f, aes(x = WeightVal, y = v1cq, col = "Female"))+
            ggtitle('Chloroquine Central Compartment Volume (V1) vs. Weight') +
            xlab('Weight (lb)')+
            ylab('Central Compartment Volume: V1 (L)')+
            scale_x_continuous('Weight (lb)',limits = input$Weight)+
            scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))
        p1 <- ggplotly(g1) 
    })
    output$v2cq <- renderPlotly({
        g1<-ggplot(NULL) + 
            geom_point(data = df_m, aes(x = WeightVal, y = v2cq, col = "Male"))+
            geom_point(data = df_f, aes(x = WeightVal, y = v2cq, col = "Female"))+
            ggtitle('Chloroquine Peripheral Compartment Volume (V2) vs. Weight') +
            xlab('Weight (lb)')+
            ylab('Peripheral Compartment Volume: V2 (L)')+
            scale_x_continuous('Weight (lb)',limits = input$Weight)+
            scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))
        p1 <- ggplotly(g1) 
    })
    output$v1dcq <- renderPlotly({
        g1<-ggplot(NULL) + 
            geom_point(data = df_m, aes(x = WeightVal, y = v1dcq, col = "Male"))+
            geom_point(data = df_f, aes(x = WeightVal, y = v1dcq, col = "Female"))+
            ggtitle('Desethylhloroquine Central Compartment Volume (V1) vs. Weight') +
            xlab('Weight (lb)')+
            ylab('Central Compartment Volume: V1 (L)')+
            scale_x_continuous('Weight (lb)',limits = input$Weight)+
            scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))
        p1 <- ggplotly(g1) 
    })
    output$v2dcq <- renderPlotly({
        g1<-ggplot(NULL) + 
            geom_point(data = df_m, aes(x = WeightVal, y = v2dcq, col = "Male"))+
            geom_point(data = df_f, aes(x = WeightVal, y = v2dcq, col = "Female"))+
            ggtitle('Desethylhloroquine Peripheral Compartment Volume (V2) vs. Weight') +
            xlab('Weight (lb)')+
            ylab('Peripheral Compartment Volume: V2 (L)')+
            scale_x_continuous('Weight (lb)',limits = input$Weight)+
            scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))
        p1 <- ggplotly(g1) 
    })
    output$K10 <- renderPlotly({
        g1<-ggplot(NULL) + 
            geom_point(data = df_m, aes(x = WeightVal, y = K10, col = "Male"))+
            geom_point(data = df_f, aes(x = WeightVal, y = K10, col = "Female"))+
            ggtitle('Clearance of Chloroquine from Central Compartment (hr^-1) vs. Weight') +
            xlab('Weight (lb)')+
            ylab('CQ Central Clearance (hr^-1)')+
            scale_x_continuous('Weight (lb)',limits = input$Weight)+
            scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))
        p1 <- ggplotly(g1) 
    })
    output$K30 <- renderPlotly({
        g1<-ggplot(NULL) + 
            geom_point(data = df_m, aes(x = WeightVal, y = K30, col = "Male"))+
            geom_point(data = df_f, aes(x = WeightVal, y = K30, col = "Female"))+
            ggtitle('Clearance of Desethylhloroquine from Central Compartment (hr^-1) vs. Weight') +
            xlab('Weight (lb)')+
            ylab('DCQ Central Clearance (hr^-1)')+
            scale_x_continuous('Weight (lb)',limits = input$Weight)+
            scale_color_manual(name='',values=c('Female'='#1F77B4','Male'='#FF7F0E'))
        p1 <- ggplotly(g1) 
    })
}  


# Run the application 
shinyApp(ui = ui, server = server)
