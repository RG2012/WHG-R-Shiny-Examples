library(shiny)

shinyUI(navbarPage("Navbar Page",
                   header=h1("Header of all the main panel"), #页面头部
                   tabPanel("Component 1",
                            sidebarPanel(
                                   sliderInput("obs", 
                                               "Number of observations:", 
                                               min = 1, 
                                               max = 1000, 
                                               value = 500),
                                   fileInput('fileinput',"Upload a file",multiple=F)
                                 ),
                                 
                                 # Show a plot of the generated distribution
                                 mainPanel(
                                   textOutput("fileupload"),
                                   plotOutput("distPlot")
                                 ),
                            icon=icon("refresh") #菜单图标
                            ),
                   tabPanel("Component 2"),
                   navbarMenu("More", # 子菜单函数
                              tabPanel("Sub-Component A"),
                              tabPanel("Sub-Component B"),
                              icon=icon("table")), # 设置菜单的图标
                   #页脚内容
                   footer=div("Copyright-gaowenhui2012@gmail.com", align="center"),
                   inverse = T, # 主题背景反转
                   theme="bootstrap.min.css" # 设置主题
))
