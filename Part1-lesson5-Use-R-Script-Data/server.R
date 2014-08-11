library(shiny)
shinyServer(function(input, output) {
  output$map <- renderPlot({
    plot(chinamap,col=getColor(chinamap,provname,provcol,"white"),xlab="",ylab="");
  })
})
