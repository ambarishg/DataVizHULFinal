navbarMenu("Top Ten",
           
           tabPanel("Top Ten Brands",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("BrandCategory", "Top Ten Brands",
                                     c("HUL"="HUL","All"="All")
                        ),
                        actionButton("goBrands", "Get Top Ten Brands","primary")
                      ),
                      mainPanel(plotOutput("BrandPlot"))
                    )
           ),
           tabPanel("Top Ten SubCategories",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("SubCategory", "Top Ten SubCategories",
                                     c("HUL"="HUL","All"="All")
                        ),
                        actionButton("goSubCategories", "Get Top Ten SubCategories","primary")
                      ),
                      mainPanel(plotOutput("SubCategoriesPlot"))
                    )
           ),
           
           #Tab Panel Top Ten Items
           tabPanel("Top Ten Items",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("Category", "Top Ten Items Category",
                                     c("HUL"="HUL","Non HUL"="NON_HUL","All"="All")
                        ),
                        actionButton("go2", "Get Top Ten Items","primary")
                      ),
                      mainPanel(plotOutput("plot"))
                    )
           )
) # End NavBar Menu
