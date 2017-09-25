#Inventory Tracking
tabPanel("Inventory Tracking",
         sidebarLayout(
           sidebarPanel(
             textInput(inputId = "BarCodeInv",
                       label = "Bar Code:",
                       value = "8901030341663",
                       width = "500px"),
             textInput(inputId = "StoreIDInv",
                       label = "Store ID:",
                       value = "All",
                       width = "500px"),
             dateRangeInput(inputId = "DateRange",
                            label = "Date Range",
                            start ="2017-01-01",
                            end = "2017-01-01"),
             
             actionButton("go5", "Inventory Tracking Details","primary"),
             
             tags$hr(),
             tags$div("Bar Code Highest Sales = 8901030341663"),
             tags$hr(),
             tags$div("Bar Code 2nd Highest Sales = 8901030534898"),
             tags$hr(),
             tags$div("Store ID Highest Sales = DEL0000000005")
             
           ),
           mainPanel(DT::dataTableOutput("InventoryDetailsTable"))
           
         ),style='width: 800px; height: 800px'
         
)
