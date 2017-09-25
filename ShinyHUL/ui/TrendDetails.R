#Trend and Forecasting
tabPanel("Trend and Forecasting",
         sidebarLayout(
           sidebarPanel(
             textInput(inputId = "BarCode",
                       label = "Bar Code:",
                       value = "8901030341663",
                       width = "500px"),
             textInput(inputId = "StoreID",
                       label = "Store ID:",
                       value = "All",
                       width = "500px"),
             radioButtons("TrendForecasting", "Trend / Forecasting",
                          c("TrendOnly"="Trend",
                            "Trend and Forecasting"="Forecasting")
             ),
             
             actionButton("go4", "Get Trends / Forecasting","primary"),
             tags$hr(),
             tags$div("Bar Code Highest Sales = 8901030341663"),
             tags$hr(),
             tags$div("Bar Code 2nd Highest Sales = 8901030534898"),
             tags$hr(),
             tags$div("Store ID Highest Sales = DEL0000000005")
             
           ),
           
           mainPanel(plotOutput("TrendPlot"))
         )
)
