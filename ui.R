#####Developing Data Products-Course Project
#####Jeff Roberts
#####24 November 2014
#####Based and expanded upon tutorial: http://shiny.rstudio.com/tutorial/lesson6/

library(shiny)

shinyUI(fluidPage(
  titlePanel("Developing Data Products-Course Project"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a stock to examine. Enter Stock Symbol and Date Range and press Get Stock-Button. 
        Information will be collected from yahoo finance."),
    
      textInput("symb", "Symbol", "IBM"),
    
      dateRangeInput("dates", 
        "Date range",
        start = "2000-01-03", 
        end = as.character(Sys.Date())),
   
      actionButton("get", "Get Stock"),
      
      br(),
      br(),
      
      checkboxInput("log", "Plot y axis on log scale", 
        value = FALSE),
      
      checkboxInput("adjust", 
        "Adjust prices for inflation", value = FALSE)
    ),
    
    mainPanel(
    h3('Chart of Share Prices'),
      plotOutput("plot"),
    h3('Annual Returns'),
    verbatimTextOutput("summary"))
  )
))