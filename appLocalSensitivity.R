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

# MALARIA: Univariate analysis local sensitivity bar graph -------------------------
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

#Local sensitivity figure 1: univariate analysis bar graph
#formatting for plotly graph
f1 <- list(size = 16)
xformat <- list(title = "Variables", titlefont = f1,showticklabels = TRUE,  tickangle = 290,tickfont = f1)
yformat <- list(title = "Normalized Sensitivity of AUC",titlefont = f1,showticklabels = TRUE, tickfont = f1, range = c(-1,1))

#make the plot
figbar_M <- plot_ly(df_AUC_Malaria, 
                  x = ~variables,
                  y = ~CQ, type = 'bar',color = I("light blue"), name = 'CQ central',
                  error_y = ~list(array = CQstdev, color= '#000000'))
figbar_M <- figbar_M %>% add_trace(df_AUC_Malaria,
                               x = ~variables,
                               y = ~DCQ, type = 'bar',color = I("pink"), name = 'CDQ central',
                               error_y = ~list(array = DCQstdev, color = '#000000'))
figbar_M <- figbar_M %>% layout(xaxis = xformat, yaxis = yformat, showlegend = TRUE, legend = list(font = list(size = 16)))
figbar_M

#load in data for univariate analysis
timeCQ_M = readMat('LocalSensiCQ_Malaria.mat', header = T)
timeDCQ_M = readMat('LocalSensiDCQ_Malaria.mat', header = T)
#organize as dataframes from .mat files
df_CQtime_M = as.data.frame(timeCQ_M)
df_DCQtime_M = as.data.frame(timeDCQ_M)
#rename the columns as variables
colnames(df_CQtime_M) <- c("Time", "q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(df_DCQtime_M)<- c("Time", "q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")

#establish settings for line graphs
f1 <- list(size = 20)
xformat1 <- list(title = "Time (days)",titlefont = f1, showticklabels = TRUE, tickangle = 360, tickfont = f1)
yformat1 <- list(title = "Normalized Sensitivity of Central Compartment [CQ]",titlefont = f1, showticklabels = TRUE, tickfont = f1,range = c(-1,1))
yformat2 <- list(title = "Normalized Sensitivity of Central Compartment [DCQ]",titlefont = f1, showticklabels = TRUE, tickfont = f1,range = c(-1,1))

#make the graph for changes in CQ sensitivity over time
figlineCQ_M <- plot_ly(df_CQtime_M, x = ~Time, y = ~q, name = 'q', type = 'scatter', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~vCQ1, name = 'vCQ1', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~vCQ2, name = 'vCQ2', mode = 'lines')
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~vDCQ1, name = 'vDCQ1', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~vDCQ2, name = 'vDCQ2', mode = 'lines')
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k10, name = 'k10', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k30, name = 'k30', mode = 'lines')
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k12, name = 'k12', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k21, name = 'k21', mode = 'lines')
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k23, name = 'k23', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k34, name = 'k34', mode = 'lines')
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~k43, name = 'k43', mode = 'lines')
figlineCQ_M<- figlineCQ_M%>% add_trace(y = ~ka, name = 'ka', mode = 'lines') 
figlineCQ_M<- figlineCQ_M%>% layout(xaxis = xformat1, yaxis = yformat1, showlegend = TRUE, legend = list(font = list(size = 20)))

figlineCQ_M

#make the graph for changes in DCQ sensitivity over time
figlineDCQ_M <- plot_ly(df_DCQtime_M, x = ~Time, y = ~q, name = 'q', type = 'scatter', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~vCQ1, name = 'vCQ1', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~vCQ2, name = 'vCQ2', mode = 'lines')
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~vDCQ1, name = 'vDCQ1', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~vDCQ2, name = 'vDCQ2', mode = 'lines')
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k10, name = 'k10', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k30, name = 'k30', mode = 'lines')
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k12, name = 'k12', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k21, name = 'k21', mode = 'lines')
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k23, name = 'k23', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k34, name = 'k34', mode = 'lines')
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~k43, name = 'k43', mode = 'lines')
figlineDCQ_M<- figlineDCQ_M%>% add_trace(y = ~ka, name = 'ka', mode = 'lines') 
figlineDCQ_M<- figlineDCQ_M%>% layout(xaxis = xformat1, yaxis = yformat2, showlegend = TRUE, legend = list(font = list(size = 20)))

figlineDCQ_M

#Malaria [CQ] Heatmap time ------------------

#import heatmap data
dataCQheat_M = readMat('HeatDataCQdose.mat', header = T)
#make dataframes
df_CQheat_M = as.data.frame(dataCQheat_M)
#change dataframe to a matrix to use plotly heatmaps (dataframe not supported by plotly heatmap)
mat_CQheat_M = as.matrix(df_CQheat_M, rownames.force = NA)

#format matrices for heatmaps
rownames(mat_CQheat_M)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(mat_CQheat_M)<- c('25.0','27.8','30.6','33.3', '36.1','38.9','41.7','44.4','47.2','50.0')
mat_CQheat_M <- t(mat_CQheat_M) #transpose to get desired axes

#formatting for heat maps
f2 <- list(size = 30)
xformat2 <- list(title = "Variable", titlefont = f1, showticklabels = TRUE,  tickangle = 290, tickfont = f1)
yformat2 <- list(title = "Total Dose (mg/kg)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatCQ_M <- plot_ly(x=colnames(mat_CQheat_M),y=rownames(mat_CQheat_M),z = mat_CQheat_M, type = "heatmap", colorbar = list(title = list(text = "Peak [CQ]", font = f1), tickfont = f1))
heatCQ_M <- heatCQ_M%>% layout(xaxis = xformat2, yaxis = yformat2)
heatCQ_M

#Malaria: [DCQ] Heatmap time ------------------

#import heatmap data
dataDCQheat_M = readMat('HeatDataDCQdose.mat', header = T)
# dataDCQtime = readMat('HeatDataDCQtime.mat', header = T)
#make dataframes
df_DCQheat_M = as.data.frame(dataDCQheat_M)
mat_DCQheat_M = as.matrix(df_DCQheat_M,rownames.force = NA)

#format matrix for heatmaps
rownames(mat_DCQheat_M)<- c("q", "vCQ1", "vCQ2", "vDCQ1", "vDCQ2", "k10", "k30","k12", "k21", "k23", "k34", "k43", "ka")
colnames(mat_DCQheat_M)<- c('25.0','27.8','30.6','33.3', '36.1','38.9','41.7','44.4','47.2','50.0')
mat_DCQheat_M <- t(mat_DCQheat_M)

#heatmap plot of [CQ] in the central compartment
f2 <- list(size = 30)
xformat2 <- list(title = "Variable", titlefont = f1, showticklabels = TRUE,  tickangle = 290, tickfont = f1)
yformat2 <- list(title = "Total Dose (mg/kg)", titlefont = f1, showticklabels = TRUE,tickfont = f1)

#heatmap plot of [CQ] in the central compartment
heatDCQ_M <- plot_ly(x=colnames(mat_DCQheat_M),y=rownames(mat_DCQheat_M),z = mat_DCQheat_M, type = "heatmap", colorbar = list(title = list(text = "Peak [DCQ]", font = f1), tickfont = f1))
heatDCQ_M<- heatDCQ_M%>% layout(xaxis = xformat2, yaxis = yformat2)
heatDCQ_M

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$AUCbar <- renderPlotly({
        figbar <- switch(input$disease, 'Malaria' = figbar_M, 'COVID-19' = figbar_C19)
        figbar

    })
    output$Timecourse <- renderPlotly({
        figline <- witch(input$disease, 'Malaria' = figlineCQ_M, 'COVID-19' = figline_CQC19)
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
