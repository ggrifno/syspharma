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

# Define UI
ui <- fluidPage(
    titlePanel("CLld"),
    # Application title
    mainPanel(
        tabsetPanel(
            tabPanel("Population Parameters",
    #panel layout
    fluidRow(
        column(6,
                plotlyOutput('wt'),
                h5('Panel A: Violin plots displaying the distribution of weight for each sex in the patient population.')
        ),
        column(6,
               plotlyOutput('scatter'),
               h5('Pabel B: A scatter plot displaying the disribution of the selected parameter over the weight range')
        ),
    wellPanel(sliderInput("Weight", label = h3("Weight Range"), min = 0, 
                                          max = 450, value = c(0, 450), width = 2000))
    ),
    wellPanel(selectInput("pl", label = h3("Parameter"), c('CQ V1','CQ V2','DCQ V1','DCQ V2','CQ Clearance','DCQ Clearance')))
            
        )
    )
    )
)
#===================================================================================

# Define server logic
#load and format population parameter data
mat <- readMat('data.mat',header=T)
dat <- as.data.frame(mat)
dat $SexLabels<- as.factor(dat$SexLabels)
df_m<-dat[1:50,]
df_f<-dat[51:100,]
# m_CQV1<-df_m[,2:3]
# f_CQV1<-df_f[,2:3]
# m_CQV2<- df_m %>% select(2, 4)
# f_CQV2<- df_f %>% select(2, 4)
# m_DCQV1<- df_m %>% select(2, 5)
# f_DCQV1<- df_f %>% select(2, 5)
# m_DCQV2<- df_m %>% select(2, 6)
# f_DCQV2<- df_f %>% select(2, 6)
# m_CQcl<- df_m %>% select(2, 7)
# f_CQcl<- df_f %>% select(2, 7)
# m_DCQcl<- df_m %>% select(2, 8)
# f_DCQcl<- df_f %>% select(2, 8)
# [m_datasetInput() <- reactive({
#     switch(input$pl,
#            'CQ V1'=m_CQV1,
#            'CQ V2'=m_CQV2,
#            'DCQ V1'=m_DCQV1,
#            'DCQ V2'=m_DCQV2,
#            'CQ Clearance'=m_CQcl,
#            'DCQ Clearance'=m_DCQcl)

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


#plot
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
    output$scatter <- renderPlotly({
            fig <- switch(input$pl,'CQ V1'=fig_CQV1,'CQ V2'=fig_CQV2,'DCQ V1'=fig_DCQV1,'DCQ V2'=fig_DCQV2,'CQ Clearance'=fig_CQcl,'DCQ Clearance'=fig_DCQcl)
            fig
    })
}  

# Run the application 
shinyApp(ui = ui, server = server)