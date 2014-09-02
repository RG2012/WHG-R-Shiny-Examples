library(shiny)

shinyServer(function(input, output) {
  
  #recive a input file object
  inputfile <- reactive({
    return(input$fileinput)
  })
  
  #print the content of input file
  output$fileinfo <- renderPrint({
    if(is.null(input$fileinput))
    {
      return("No file uploaded");
    }else
    {
      #specify some parameters
      data <- read.table( (inputfile())$datapath,
                          header = input$isheader,
                          sep= if ( is.null(input$definesep) ) input$sepchar else input$definesep  
                          );
      print(head(data));
    }
    
  })
  
  #download event 
  #theree arguments:
  #filename, content and contentType
  output$downloadbutton <- downloadHandler(
    filename = function(){ return("fileinfo.csv") },
    content = function(file)
      {
        write.csv(inputfile(), file)
      },
    contentType = "text/csv"
  )
  
  
})
