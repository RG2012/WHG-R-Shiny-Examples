
library(shiny)
library(ggplot2)
source("global.R") # load common functions

shinyServer(function(input, output, session) {
    session$isValid = 0;
    
    #-------------------------------------
    #renderUI of Uploading data
    #-------------------------------------
    output$uploadAction <- renderUI({
        #check the user
        if (input$Login && isolate(checkUser(input$username, input$password)) )
        {
            session$isValid = 1;
        }else
        {
            return();
        }
        
        if ( session$isValid )
        {
            #input file1 (data used to analysis linear regression)
            div(
                strong(helpText('Linear regression')),
                #lr means linear regression
                fileInput('lrfile', 
                          'Upload a csv file'
                ),
                #end of upload data
                
                hr(),
                
                #input file2 (data used to calc AR and CAR)
                strong(helpText('Calculator AR and CAR')),
                fileInput('predictfile', 
                          'Upload a csv file'
                )
                #end of upload data (used to calc AR and CAR)
            );
        }
    })
    
    lrrawData <- reactive({
        data <- NULL;
        lrfile <- input$lrfile;
        if(is.null(lrfile))
        {
            data <- NULL;
        }else{
            data <- read.csv( lrfile$datapath, header=T );
            names(data) <- c("Date", "Market", "Company");
        }
        return(data);
    })
    
    lrconvertedData <- reactive({
        data <- NULL;
        if (!is.null( lrrawData() ))
        {
            data <- convert2Rij(lrrawData());
        }
        return(data);
    })
    
    #lm object of converted data
    lmobj <- reactive({
        lrobj <- NULL;
        if ( !is.null(lrconvertedData()))
        {
            lrobj <- lm(Company ~ Market, lrconvertedData());
        }
        return(lrobj);
    })
    
    #---------------------------------------
    #raw summary output
    #--------------------------------------
    output$rawSummary <- renderPrint({
        if (is.null(lrrawData()))
        {
            return("No result");
        }else{
            summary(lrrawData()[,-1]);
        }
    })
    
    
    #---------------------------------------
    #convert summary output
    #--------------------------------------
    output$convertSummary <- renderPrint({
        if (is.null(lrconvertedData()))
        {
            return("No result");
        }else{
            summary(lrconvertedData()[,-1]);
        }
    })
    
    #--------------------------------
    #summary of lm result
    #--------------------------------
    output$linearRegressionSummary <- renderPrint({
        if (is.null(lmobj()))
        {
            return("No result");
        }
        summary(lmobj());
    })
    
    #----------------------------
    #print formula of lm result
    #-----------------------------
    output$formulaOutput <- renderUI({
        
        if( is.null(lrconvertedData()) )
        {
            return();
        }else
        {
            div(
                hr(),
                strong("Formula:"),
                strong(paste("Company = ", 
                             (lmobj())$coefficients[1], " + ",
                             (lmobj())$coefficients[2], "* Market", collapse = "")
                )
            )
        }
    })
    
    #-----------------------------------
    #output data table
    #-----------------------------------
    output$convertData <- renderDataTable(
        lrconvertedData(),
        options = list(
            bSortClasses = TRUE, 
            aLengthMenu = c(10, 30, 50),
            iDisplayLength = 10,
            aoColumns = list(
                list(bSearchable = F),
                list(bSearchable = F),
                list(bSearchable = F)
                )
            )
    )
    
    #-----------------------------
    #download data
    #------------------------------
    output$downloadConvertData <- downloadHandler(
        filename = "convertedData.csv",
        content = function(file){write.csv(lrconvertedData(), file)}
    )
    
    #---------------------------------------
    #output plot of X with Y
    #-------------------------------------
    output$rawScatterPlot <- renderPlot({
        if (is.null(lrrawData()))
        {
            return("No result");
        }
        
        data <- lrrawData();
        q <- ggplot(data, aes(x=Market,  y=Company));
        q <- q + geom_point() + 
            stat_smooth(method="lm") + 
            theme_bw();
        q
    })
    
    #--------------------------------
    #plot converted data (Market and Company)
    #-------------------------------
    output$convertedScatterPlot <- renderPlot({
        if (is.null(lrconvertedData()))
        {
            return("No result");
        }
        data <- lrconvertedData();
        q <- ggplot(data, aes(x=Market,  y=Company));
        q <- q + geom_point() + 
            stat_smooth(method="lm") + 
            theme_bw();
        q
    })
    
    predictRawData <- reactive({
        data <- NULL;
        predictFile <- input$predictfile;
        if(is.null(predictFile))
        {
            data <- NULL;
        }else{
            data <- read.csv( predictFile$datapath, header=T );
            names(data) <- c("Date", "Market", "Company");
        }
        return(data);
    })
    
    
    predictconvertedData <- reactive({
        data <- NULL;
        if (!is.null( predictRawData() ))
        {
            data <- convert2Rij(predictRawData());
        }
        return(data);
    })
    
    printPredictConvertedData <- reactive({
        data <- NULL;
        if (!is.null( predictconvertedData() ))
        {
            data <- data.frame( Date = (predictconvertedData())[,1],
                                ConvertedMarket = (predictconvertedData())[,2],
                                ConvertedCompany = (predictconvertedData())[,3],
                                PredictedCompany = predict(lmobj(), 
                                                           data.frame(Market=(predictconvertedData())[,2])),
                                ARs = (predictconvertedData())[,3] - 
                                    predict(lmobj(), data.frame(Market=(predictconvertedData())[,2]))
            )
        }
        return(data);
    })
    
    #----------------------------------
    #print data table of converted predict data
    #--------------------------------
    output$ARsData <- renderDataTable(
        printPredictConvertedData(),
        options = list(
            bSortClasses = TRUE, 
            aLengthMenu = c(10, 30, 50),
            iDisplayLength = 10,
            aoColumns = list( 
                list(bSearchable = F),
                list(bSearchable = F),
                list(bSearchable = F),
                list(bSearchable = F),
                list(bSearchable = F)
                )
        )
    )
    
    #-----------------------------
    #download ARs data
    #------------------------------
    output$downloadARsData <- downloadHandler(
        filename = "convertPredictedARsData.csv",
        content = function(file){write.csv(printPredictConvertedData(), file)}
    )
    
    #------------------
    #plot ARs data
    #---------------------
    output$ARsPlot <- renderPlot({
        if (is.null(printPredictConvertedData()))
        {
            return();
        }
        plot(x=(printPredictConvertedData())$Date, 
             y=(printPredictConvertedData())$ARs, 
             type="l",
             xlab="Date", ylab="AR"
             )
    })
    
    output$selectEventDay <- renderUI({
        if (is.null(printPredictConvertedData()))
        {
            return();
        }
        mychoices <- c(1:length((printPredictConvertedData())$Date));
        names(mychoices) <- (printPredictConvertedData())$Date;
        div(
            strong("Select the Event Day:"),
            selectInput(inputId = "EventDay", label = NULL, 
                        choices = mychoices,
                        selectize = F)
            )
        })
    
    
    getCARsData <- reactive({
        if (is.null(printPredictConvertedData()))
        {
            return();
        }
        region <- as.numeric(input$EventDay) - 1;
        if ( as.numeric(input$EventDay) > length((printPredictConvertedData())$Date) / 2)
        {
            region <- length((printPredictConvertedData())$Date) - as.numeric(input$EventDay);
        }
        CARs <- NULL;
        for (i in 1:region)
        {
            CARs[i] <- sum( ((printPredictConvertedData())$ARs)[(as.numeric(input$EventDay)-i):(as.numeric(input$EventDay)+i)] )
        }
        return(data.frame(Regions=as.character(paste(-c(1:region),c(1:region),sep="-")), CARs=CARs));
    })
    
    #------------------
    #datatable of CARs
    #------------------
    output$CARsData <- renderDataTable(
        getCARsData(),
        options = list(
            bSortClasses = TRUE, 
            aLengthMenu = c(5, 10, 15),
            iDisplayLength = 5,
            aoColumns = list( 
                list(bSearchable = F),
                list(bSearchable = F)
            )
        )
    )
    
    #-----------------------------
    #download CARs data
    #------------------------------
    output$downloadCARsData <- downloadHandler(
        filename = "CARsData.csv",
        content = function(file){write.csv(getCARsData(), file)}
    )
    
})
