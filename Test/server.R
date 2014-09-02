
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

fib <- function(n) ifelse(n<3, 1, fib(n-1)+fib(n-2))

shinyServer(function(input, output) {
    
    currentFib <- reactive({ fib(as.numeric(input$n)) })
    
    output$textoutput <- renderText({ currentFib() })
    
    output$textoutput1 <- renderText({ 
        currentFib1 <- fib(as.numeric(input$n));
        currentFib1
    })
    
    output$textoutput3 <- renderText({
        input$inputtext
    })
})
