
library(shiny)
library(maps)
data(world.cities);

datatmp <- c("One"="One Apple", "Two"="Two oranges");

shinyUI(fluidPage(

  # Application title
  titlePanel("Using Selectize Input"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        helpText('Mainland Cites'),
        selectInput('example1', '01 Commom select widget with adding "Choose" prompt',
                    choices = c(Choose='', subset(world.cities, country.etc == 'China')[,1]),
#                     choices = datatmp,
                    selectize=F),
        hr(),
        selectInput('example2', '02 Commom select widget without adding "Choose" prompt',
                    choices = c(subset(world.cities, country.etc == 'China')[,1]),
                    selectize=F),
        hr(),
        selectInput('example3', '03 Commom select widget with adding \n "Choose" prompt and selectize',
                    choices = c(Choose='', subset(world.cities, country.etc == 'China')[,1]),
                    selectize=T),
        hr(),
        selectizeInput('example4', '04 selectizeInput same as selectInput with selectize=T', 
                       choices=subset(world.cities, country.etc == 'China')[,1], 
                       selected=NULL, 
                       multiple=F),
        hr(),
        selectizeInput('example5', '05 selectizeInput with multiple=TRUE and initiallze selected', 
                       choices=subset(world.cities, country.etc == 'China')[,1], 
                       selected=c("Aksu", "Wuhan"), 
                       multiple=T),
        hr(),
        selectizeInput('example6', '06 selectizeInput with placeholder',
                       choices=subset(world.cities, country.etc == 'China')[,1],
                       options=list(
                           placeholder =  'select one city'，
                           onInitialize = I('function() { this.setValue(""); }')
                           )
                       ),
        hr(),
        selectizeInput('example7',
                       '07 selectizeInput with multiple=TRUE, max candicate items = 15, max Selected items =4 and initiallze selected', 
                       choices=subset(world.cities, country.etc == 'China')[,1], 
                       selected=c("Aksu", "Wuhan"), 
                       multiple=T,
                       options=list(maxOptions=15, maxItems=4)),
        
        hr(),
        selectizeInput('example8', '08 selectizeInput in ui.R without choices data',
                       choices=NULL, selected=NULL, multiple=F),
        hr(),
        width=5
    ),

    # Show table output of selectizeInput
    mainPanel(
        tableOutput('varoutput'),
        width=7
    )
  )
))
