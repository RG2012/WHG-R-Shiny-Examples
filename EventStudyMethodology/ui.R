library(shiny)

shinyUI(navbarPage("Online Event-Study Methodology",
                   tabPanel("Start Analysis",
                            icon=icon("bar-chart-o"),
                            sidebarLayout(
                                sidebarPanel(
                                    #login part
                                    strong(helpText('Login')),
                                    helpText("If you want to use this application, 
                                             please let me known. Contact my with", 
                                             strong(a(href="mailto:gaowenhui2012@gmail.com", "email")),
                                             " I will send you an account."),
                                    div(
                                        tags$span('Username'),
                                        textInput('username', NULL, 'Username')
                                        ),
                                    div(
                                        tags$span('Password'),
                                        textInput("password", NULL, "Password")
                                        ),
                                    actionButton('Login', 'Login', icon=icon("arrow-circle-right")),
                                    #end of login part

                                    hr(),
                                    #display when login correctly
                                    uiOutput("uploadAction")
                                ),
                                
                                #main output panel
                                mainPanel(
                                    tabsetPanel(
                                        tabPanel('Summary', 
                                                 strong("Summary of raw stock price data"),
                                                 verbatimTextOutput("rawSummary"),
                                                 hr(),
                                                 strong("Summary of converted stock price data"),
                                                 verbatimTextOutput("convertSummary"),
                                                 hr(),
                                                 strong("Summary of linear regression"),
                                                 verbatimTextOutput("linearRegressionSummary"),
                                                 uiOutput("formulaOutput")
                                                 ),
                                        tabPanel('Datatable', 
                                                 strong("Datatable of converted data"),
                                                 hr(),
                                                 dataTableOutput("convertData"),
                                                 hr(),
                                                 downloadButton('downloadConvertData', 'Download')
                                                 ),
                                        tabPanel('Scatter Plot', 
                                                 strong("Scatter plot of raw data"),
                                                 plotOutput("rawScatterPlot"),
                                                 hr(),
                                                 strong("Scattter plot of converted data"),
                                                 plotOutput("convertedScatterPlot")
                                                 ),
                                        tabPanel('AR and CAR',
                                                 strong("DataTable of ARs"),
                                                 dataTableOutput("ARsData"),
                                                 downloadButton('downloadARsData', 'Download'),
                                                 hr(),
                                                 strong("Scatter plot of ARs"),
                                                 plotOutput("ARsPlot"),
                                                 hr(),
                                                 strong("DataTable of CARs"),
                                                 uiOutput('selectEventDay'),
                                                 dataTableOutput("CARsData"),
                                                 downloadButton('downloadCARsData', 'Download')
                                                 )
                                    )
                                )
                                #end of output panel
                                )
                            ),
                   tabPanel("Publications",
                            icon=icon("book"),
                            div(id="publications-part", "http://users.telenet.be/webdesignsite/Bachelorproeven/Bronnen/analyst%20recommendations/Introduction_to_the_Event_Study_Methodology%5B1%5D.pdf",
                                style="margin-left:auto;margin-right:auto;width:80%"
                                )
                            ),
                   tabPanel("Help",
                            icon=icon("question-circle"),
                            div(
                                div(icon("long-arrow-right"),strong("The theory of this application")),
                                div(id="theory-part", 
                                    "In the ESM, 
                                    there are main formulas to show how it works with the ",
                                    strong("Market Model."),
                                    br(),
                                    strong(tags$i("Formula 1:")),
                                    withMathJax(helpText('$$Rc = \\alpha + \\beta*Rm + e$$')),
                                    helpText("This formula is the linear regression between 
                                             company return and market return. 
                                             Rc is the return of Company stock and 
                                             Rm is the return of Market."),
                                    strong(tags$i("Formula 2:")),
                                    withMathJax(helpText('$$Rc = ln(\\frac{PC_t}{PC_{t-1}})*100,
                                                         Rm = ln(\\frac{PM_t}{PM_{t-1}})*100$$')
                                                ),
                                    strong(tags$i("Formula 3:")),
                                    withMathJax(helpText('$$AR = , CAR = $$')),
                                    helpText("This formula shows how to get the return value. 
                                             PC is the stock price of Company and PM is the 
                                             \"price\" of Market. t is the t-th day.")
                                    ),
                                div(icon("long-arrow-right"),strong("The format of input data")),
                                helpText("Here, I just want to tell how to prepare the input data. 
                                         The data include two files: one file contains the raw stock price of ", 
                                         strong("company"), "and", strong("market"), 
                                         " with corresponding date information and saved as ",
                                         strong("CSV"),
                                         " format. The following screenshot of price data is an example."),
                                hr(),
                                div(img(src="fileexample1.png", width = "300px", height = "300px"),
                                    style="margin-left:auto;margin-right:auto;text-align:center;"),
                                hr(),
                                helpText("The another input data is used to calculate 
                                         the ARs(abnormal return) and CARs(cummulative abnormal return).
                                         Its format is same as the first input data.
                                         You should select one day as the event broken day
                                         after you have uploaded the csv data.
                                         The CARs value will be calculated with different windows(1, 2, 3, etc.) 
                                         which depends on the event day you selected."),
                                style="margin-left:auto;margin-right:auto;width:70%"
                            )
                            ),
                   footer=div(
                                id ="footer",
                                icon("arrow-circle-right"),
                                "Copyright by ",
                                strong(a(href="http://www.iwhgao.com", target="_blank", "Wenhui Gao")),
                                ".",
                                "Last updated at: 2014-8-31",
                                br(),
                                "This application is based on ",
                                strong(a(href="http://shiny.rstudio.com/","R Shiny", target="_blank")),
                                " project in ", 
                                strong(a(href="http://www.rstudio.com/", "RStuio", target="_blank")),
                                ".",
                                style="margin-left:auto;margin-right:auto;margin-top:20px;
                                text-align:center;width:100%;
                                background-color:lightgrey;
                                border-radius:5px"
                   ),
                   inverse=F,
                   collapsable=F
                   )
        )
