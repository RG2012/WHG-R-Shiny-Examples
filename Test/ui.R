
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("n",
                  "Input n",
                  min = 1,
                  max = 50,
                  value = 11)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      textOutput("textoutput"),
      hr(),
      textOutput("textoutput1"),
      hr(),
      tags$textarea(id="inputtext","text"),
      textOutput("textoutput3")
    )
  )
))
