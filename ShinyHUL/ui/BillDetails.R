#Bill Details
tabPanel("Bill Details",
         sidebarLayout(
           sidebarPanel(
             tags$div("Please provide Bill Number."),
             tags$hr(),
             tags$div("As an Example a Bill number is provided."),
             tags$hr(),
             tags$div("You can increment by 1 and put another Bill Number such as 
                      counter1DEL000000144630283,
                      counter1DEL000000144630284,
                      counter1DEL000000144630285"),
             tags$div("and test the application"),
             tags$hr(),
             textInput(inputId = "BillNumber",
                       label = "Bill Number:",
                       value = "counter1DEL000000144630282")
             
             ,
             #Submit Button
             actionButton("go1", "Get Bill Details","primary")
             ),
           
           mainPanel(
             
             DT::dataTableOutput("BillDetailsTable")
           )
           ),
         style='width: 1000px; height: 1000px'
         )
