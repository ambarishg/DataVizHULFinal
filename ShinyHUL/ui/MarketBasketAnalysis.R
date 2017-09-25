#Tab Panel Market Basket Analysis
tabPanel("Market Basket Analysis",
         sidebarLayout(
           sidebarPanel(
             radioButtons("MBACategory", "Market Basket Analysis Items",
                          c("Nil Bar and All Items"="NBA",
                            "Nil Bar and HUL Items"="NBHUL",
                            "Tomato Ketchup and All Items"="TKA",
                            "Tomato Ketchup and HUL Items"="TKHUL")
             ),
             actionButton("go3", "Get Market Basket Analysis","primary"),
             
             
             tags$br(),
             
             tags$div("Nil Bar and Tomato Ketchup are the Two MOST HUL Items")
             
             
           ),
           mainPanel(
             
             plotOutput("MBAplot"), DT::dataTableOutput("MBATable") )
           
         )
)