#example for HTML content
library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("New Application"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("obs", 
                "Number of observations:", 
                min = 1, 
                max = 1000, 
                value = 500)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    h6("Episode IV", align = "center"),
    h6("A NEW HOPE", align = "center"),
    h5("It is a period of civil war.", align = "center"),
    h4("Rebel spaceships, striking", align = "center"),
    h3("from a hidden base, have won", align = "center"),
    h2("their first victory against the", align = "center"),
    h1("evil Galactic Empire."),
    code("R code"),
    p('My first paragraph, with some ', strong('bold'), ' text.'),
    a("my web site", href="http://www.iwhgao.com", target="_blank"),
    plotOutput('distPlot')
  )
))
