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
    titlePanel("Wight"),
    mainPanel(
        textOutput("selected_var")
    ),
    
    # Sidebar with a slider input for number of bins 
    fluidRow(
        column(6,
               plotlyOutput('boo'),
               h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.')
        ),
        column(6,
               plotlyOutput('v1cq'),
               h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.')
        ),
        # column(6,
        #        plotlyOutput('v2cq'),
        #        h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.'),
        # ),
        # column(6,
        #        plotlyOutput('v1dcq'),
        #        h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.'),
        # ),
        # column(6,
        #        plotlyOutput('v2dcq'),
        #        h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.'),
        # ),
        # column(6,
        #        plotlyOutput('K10'),
        #        h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.'),
        # ),
        # column(6,
        #        plotlyOutput('K30'),
        #        h5('Panel A: Violin plots displaying the distribution of central compartment volume (V1) for each scenario and sex.'),
        # ),
        
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

df <- data.frame(matrix(ncol = 9, nrow = 0))
x <- c("SexLabels", "WeightVal", "v1cq","v2cq","v1dcq",'v2dcq','K10','K30','kabs')
colnames(df) <- x
df$SexLabels<- as.factor(df$SexLabels)

# reactive({

# })
reactive({
    mn<-input$Weight[1]
    mx<-input$Weight[2]
    for (val in 1:nrow(dat)) {
        if (dat[val,]$WeightVal > mn && dat[val,]$WeightVal < mx) {
            df<-rbind(df,dat[val,])
        }
    }
})

server <- function(input, output) {
    output$selected_var <- renderText({ 
        paste("You have selected", input$Weight[1])
    })
    reactive{(
        mn<-input$Weight[1]
        mx<-input$Weight[2]
        for (val in 1:nrow(dat)) {
            if (dat[val,]$WeightVal > mn && dat[val,]$WeightVal < mx) {
                df<-rbind(df,dat[val,])
            }
        }
    })
    output$boo <- renderPlotly({
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
                    title = "Central Compartment Volume: V1 (L)",
                    range = input$Weight,
                    zeroline = F
                ),
                title = 'Distribution of V1 vs. Subpopulation'
            )
        fig
    })
    output$v1cq <- renderPlotly({
            fig <- df %>%
                plot_ly(
                    x = ~SexLabels,
                    y = ~v1cq,
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
                        zeroline = F
                    ),
                    title = 'Distribution of V1 vs. Subpopulation'
                )
            fig
    })
}  


# Run the application 
shinyApp(ui = ui, server = server)
