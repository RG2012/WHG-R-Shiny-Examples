library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Application Title"),
  
  navlistPanel(
    "Header A",
    tabPanel("Component 1",  # 这个Panel中包含了一个典型的sidebarLayout
             sidebarLayout(sidebarPanel("Input",
                                        sliderInput("obs",
                                                    label="slider obs",
                                                    value= 20,
                                                    min=0,
                                                    max=100)
                                        ),
                          mainPanel(plotOutput('distPlot'))
             )
             ),
    tabPanel("Component 2"),
    "Header B",
    tabPanel("Component 3"),
    tabPanel("Component 4"),
    "-----",
    tabPanel("Component 5")
  )
))
