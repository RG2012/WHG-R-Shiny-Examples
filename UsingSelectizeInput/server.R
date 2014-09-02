library(shiny)

shinyServer(function(input, output, session) {
    choicesdata <- data.frame(name=dataname, value=datavalue);
    updateSelectizeInput(session, 'example8', 
                         choices = state.name,
                         server = F,
                         #render argument  JavaScript code
                         options = list(render = I(
                             '{
                             option: function(item, escape) {
                                return "<div><strong>" + escape(item.value) + " State " +"<strong></div>";
                             }
                             }'))
                         );
    
    #output the selected elements as data frame
    output$varoutput <- renderTable({
        examples <- paste("example", 1:8);
        values <- c(input$example1, input$example2, input$example3, input$example4, 
                    paste(input$example5, collapse = ","), input$example6, 
                    paste(input$example7, collapse = ","), paste(input$example8, collapse = ","));
        
        data <- data.frame(exampleID=examples, values=values);
        data
    })
})
