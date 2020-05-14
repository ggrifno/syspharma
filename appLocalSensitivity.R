#GGrifno
#systems pharma final project
#shiny app for visualizing Malaria versus COVID19 phenomena for local sensivity analysis

#not sure if need all of these...
library(shiny)
library(plotly)
library(ggplot2) 
library(R.matlab)
library(reshape2)
library(plyr)
library(gridExtra)
library(reshape2)
library(gtable)
library(Hmisc)

# Define UI ----
ui <- fluidPage(
    # App title
    titlePanel("Chloroquine Local Sensitivity Analysis"),
    
    # Sidebar layout with input and output definitions
    sidebarLayout(
        
        # Sidebar panel for inputs
        sidebarPanel(
            
            # Input: Select the random distribution type
            radioButtons("disease", "Disease case:",
                         c("Malaria" = "Malaria",
                           "COVID-19" = "COVID-19")),
            
            # br() element to introduce extra vertical spacing
            br(),
            h3('ADD IN FIGURE CAPTION')
            
        ),
        
        # Main panel for displaying outputs
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table
            tabsetPanel(type = "tabs",
                        tabPanel("Sensitivity of AUC", plotlyOutput("AUCbar")),
                        tabPanel("Sensitivity Timecourse", plotlyOutput("Timecourse")),
                        tabPanel("Variable Dose Heatmap", plotlyOutput("Heatmap"))
            )
            
        )
    )
)

#define data needed to generate outputs

# COVID19: Univariate analysis local sensitivity bar graph -------------------------
#load in data for univariate analysis
DataAUC_Malaria = readMat('LocalSensiAUC.mat', header = T)
#organize as dataframes from .mat files
df_AUC_Malaria = as.data.frame(DataAUC_Malaria)
#add in a column for the variable names
df_AUC_Malaria$variables <- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
#rename columns to reflect the type of data
names(df_AUC_Malaria)[1] <- 'CQ'
names(df_AUC_Malaria)[2] <- 'CQstdev'
names(df_AUC_Malaria)[3] <- 'DCQ'
names(df_AUC_Malaria)[4] <- 'DCQstdev'

#load in data for univariate analysis
DataAUC_COVID19 = readMat('LocalSensiAUC-COVID-19.mat', header = T)
#organize as dataframes from .mat files
df_AUC_COVID19 = as.data.frame(DataAUC_COVID19)
#add in a column for the variable names
df_AUC_COVID19$variables <- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")

#rename columns to reflect the type of data
names(df_AUC_COVID19)[1] <- 'CQ'
names(df_AUC_COVID19)[2] <- 'CQstdev'
names(df_AUC_COVID19)[3] <- 'DCQ'
names(df_AUC_COVID19)[4] <- 'DCQstdev'


#Local sensitivity figure 1: univariate analysis bar graph
#formatting for plotly graph
f1 <- list(size = 25)
xformat <- list(title = "Variables", titlefont = f1,showticklabels = TRUE,  tickangle = 290,tickfont = f1)
yformat <- list(title = "Normalized Sensitivity of AUC",titlefont = f1,showticklabels = TRUE, tickfont = f1, range = c(-1,1))


# Define server logic required to draw a histogram
server <- function(input, output) {
    output$AUCbar <- renderPlotly({
        df <- switch(input$disease, 'Malaria' = df_AUC_Malaria, 'COVID-19' = df_AUC_COVID19)
        figbar <- df %>% #use the melted dataframe that contains data for each scenario
            plot_ly(df, 
                  x = ~variables,
                  y = ~CQ, type = 'bar',color = I("light blue"), name = 'CQ central',
                              error_y = ~list(array = CQstdev, color= '#000000'))
        figbar <- figbar %>% add_trace(x = ~variables,
                   y = ~DCQ, type = 'bar',color = I("pink"), name = 'CDQ central',
                   error_y = ~list(array = DCQstdev, color = '#000000'))
        # figbar <- figbar %>% layout(xaxis = xformat, yaxis = yformat, showlegend = TRUE, legend = list(font = list(size = 25)))
        figbar
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
