library(shiny)
source("./help.R");

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Map Application"),
  
  sidebarPanel(
    h2("China population map")
  ),
  
  mainPanel(
    plotOutput("map")
  )
))
