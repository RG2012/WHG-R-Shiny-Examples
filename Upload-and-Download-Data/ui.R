library(shiny)

shinyUI(pageWithSidebar(
  
  #Title
  headerPanel("File Upload Text"),
  
  sidebarPanel(
    #add fileInput widget
    fileInput('fileinput', 
              label="Upload file", accept="text/plain",multiple=F
              ),
    hr(),
    checkboxInput("isheader", label="Header", value=F),
    hr(),
    radioButtons('sepchar', 'Separator',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 ','),
    textInput("definesep","or define other separator", ""),
    hr(),
    # add download button widget
    downloadButton('downloadbutton', 'Download')
  ),
  
  #print output
  mainPanel(
    verbatimTextOutput("fileinfo")
  )
))
