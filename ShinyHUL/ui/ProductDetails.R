#Product Catalog
tabPanel("Product Catalog",
         sidebarLayout(
           sidebarPanel(
             textInput(inputId = "BasePackDesc",
                       label = "Product Description:",
                       value = "NIL MINERAL BAR"),
             textInput(inputId = "BrandCategoryDesc",
                       label = "Brand:",
                       value = "Surf"),
             textInput(inputId = "SubCategoryDesc",
                       label = "Sub Category:",
                       value = "Detergent"),
             #Submit Button
             actionButton("goProduct", "Get Product Details","primary")
           ),
           mainPanel(DT::dataTableOutput("ProductDetailsTable"))
         ),
         style='width: 700px; height: 700px'
)
