# server.R
#####Developing Data Products-Course Project
#####Jeff Roberts
#####24 November 2014
#####Based and expanded upon tutorial: http://shiny.rstudio.com/tutorial/lesson6/

library(quantmod)
source("helpers.R")


shinyServer(function(input, output) {
  
  dataInput <- reactive({  
      getSymbols(input$symb, src = "yahoo", 
          from = input$dates[1],
          to = input$dates[2],
          auto.assign = FALSE)
  })
  
  finalInput <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })
  # Generate a summary of the dataset
  output$summary <- renderPrint({
  a<-as.data.frame(annualReturn(finalInput())*100)
  a$Year = rownames(a)
  colnames(a) <-c("Annual Return", "Year Ending")
  a<-a[,c("Year Ending", "Annual Return")]
  print(a, row.names = FALSE)
  })
  output$plot <- renderPlot({
    chartSeries(finalInput(), theme = chartTheme("white"), 
        type = "line", log.scale = input$log, TA = NULL)
  })
})
