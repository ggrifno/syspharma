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

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Wight"),

    # Sidebar with a slider input for number of bins 
    fluidRow(
        column(6,
               plotlyOutput('weight'),
               h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.'),
        ),

    ),
    hr(),
    wellPanel(
        sliderInput("Weight", label = h3("Weight Range"), min = 0, 
                    max = 65, value = c(0, 65), width = 900)
        
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

server <- function(input, output) {

    output$weight <- renderPlotly({
        fig <- df %>%
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
                    title = "Central Compartment Volume: V1 (L)",
                    range = input$Weight,
                    zeroline = F
                ),
                title = 'Distribution of V1 vs. Subpopulation'
            )
        fig
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
