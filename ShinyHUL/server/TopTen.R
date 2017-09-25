TopTenBrandsPlot <- eventReactive(input$goBrands,{
  
  # SELECT BRAND_DESC, COUNT(*) AS n 
  # FROM AllTransactions 
  # LEFT JOIN Products 
  # ON AllTransactions.BARCODE = Products.BARCODE
  # WHERE (BRAND_DESC != "NULL")
  # AND (BRAND_DESC != "Unknown")
  # GROUP BY BRAND_DESC ;
  
  if(input$BrandCategory == "All")
  {
    queryString = "SELECT BRAND_DESC, COUNT(*) AS n 
    FROM AllTransactions 
    LEFT JOIN Products 
    ON AllTransactions.BARCODE = Products.BARCODE
    WHERE (BRAND_DESC != 'NULL')
    AND (BRAND_DESC != 'Unknown')
    GROUP BY BRAND_DESC ORDER BY n DESC"
  }
  else if (input$BrandCategory == "HUL")
  {
    queryString = "SELECT BRAND_DESC, COUNT(*) AS n 
    FROM AllTransactions 
    LEFT JOIN Products 
    ON AllTransactions.BARCODE = Products.BARCODE
    WHERE (BRAND_DESC != 'NULL')
    AND (BRAND_DESC != 'Unknown')
    AND (COMPANY_CODE == 'HUL')
    GROUP BY BRAND_DESC ORDER BY n DESC"
  }
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  AllTransactionsQuery <- dbSendQuery(con, queryString)
  
  AllTransactions <- dbFetch(AllTransactionsQuery, n = -1)
  
  dbDisconnect(con)
  
  return(AllTransactions)
  
  })


TopTenSubCategoriesPlot <- eventReactive(input$goSubCategories,{
  
  
  if(input$SubCategory == "All")
  {
    queryString = "SELECT SUBCATEGORY_DESC, COUNT(*) AS n 
    FROM AllTransactions 
    LEFT JOIN Products 
    ON AllTransactions.BARCODE = Products.BARCODE
    WHERE (SUBCATEGORY_DESC != 'NULL')
    AND (SUBCATEGORY_DESC != 'Unknown')
    GROUP BY SUBCATEGORY_DESC ORDER BY n DESC"
  }
  else if (input$SubCategory == "HUL")
  {
    queryString = "SELECT SUBCATEGORY_DESC, COUNT(*) AS n 
    FROM AllTransactions 
    LEFT OUTER JOIN Products 
    ON AllTransactions.BARCODE = Products.BARCODE
    WHERE (SUBCATEGORY_DESC != 'NULL')
    AND (SUBCATEGORY_DESC != 'Unknown')
    AND (COMPANY_CODE == 'HUL')
    GROUP BY SUBCATEGORY_DESC ORDER BY n DESC "
  }
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  AllTransactionsQuery <- dbSendQuery(con, queryString)
  
  AllTransactions <- dbFetch(AllTransactionsQuery, n = -1)
  
  dbDisconnect(con)
  
  return(AllTransactions)
  
  })

TopTenCategoryPlot <- eventReactive(input$go2,{
  
  #SELECT COUNT(*) AS n FROM ALLTransactions GROUP BY (BARCODE) ORDER by DESC n;
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  queryString = "SELECT BARCODE ,COUNT(*) AS n FROM ALLTransactions GROUP BY (BARCODE) ORDER by n DESC"
  
  AllTransactionsQuery <- dbSendQuery(con, queryString)
  
  AllTransactions <- dbFetch(AllTransactionsQuery, n = -1)
  
  if(
    (input$Category == "HUL") ||
    (input$Category == "NON_HUL")
  )
  {
    
    returnedDataSet = AllTransactions %>%
      left_join(ProductMasterDistinct) %>%
      filter(COMPANY_CODE == input$Category) %>%
      head(10) %>%
      mutate(ProductCodeDesc = paste0(BARCODE,"-",BASEPACK_DESC)) %>%
      mutate(ProductCodeDesc = reorder(ProductCodeDesc,n)) 
  }
  else
  {
    returnedDataSet = AllTransactions %>%
      left_join(ProductMasterDistinct) %>%
      head(10) %>%
      mutate(ProductCodeDesc = paste0(BARCODE,"-",BASEPACK_DESC)) %>%
      mutate(ProductCodeDesc = reorder(ProductCodeDesc,n)) 
  }
  
  dbDisconnect(con)
  
  return( returnedDataSet)
})

output$BrandPlot = renderPlot({
  
  TopTenBrandsPlot() %>%
    head(10) %>%
    mutate(ProductCodeDesc = paste0(BRAND_DESC)) %>%
    mutate(ProductCodeDesc = reorder(ProductCodeDesc,n))  %>%
    ggplot(aes(x = ProductCodeDesc,y = n)) +
    geom_bar(stat='identity',colour="white", fill =fillColor2) +
    geom_text(aes(x = ProductCodeDesc, y = 1, label = paste0("(",n,")",sep="")),
              hjust=0, vjust=.5, size = 4, colour = 'black',
              fontface = 'bold') +
    labs(x = 'Barnd Code', y = 'Count of Brands Sold', 
         title = 'Count of Brands Sold ') +
    coord_flip() + 
    theme_bw() + theme(text=element_text(size=16))
  
},height="auto")

##########################################################################################

output$SubCategoriesPlot = renderPlot({
  
  TopTenSubCategoriesPlot() %>%
    head(10) %>%
    mutate(ProductCodeDesc = paste0(SUBCATEGORY_DESC)) %>%
    mutate(ProductCodeDesc = reorder(ProductCodeDesc,n))  %>%
    ggplot(aes(x = ProductCodeDesc,y = n)) +
    geom_bar(stat='identity',colour="white", fill =fillColor2) +
    geom_text(aes(x = ProductCodeDesc, y = 1, label = paste0("(",n,")",sep="")),
              hjust=0, vjust=.5, size = 4, colour = 'black',
              fontface = 'bold') +
    labs(x = 'SubCategory', y = 'Count of  SubCategory Sold', 
         title = 'Count of SubCategory Sold') +
    coord_flip() + 
    theme_bw() +  theme(text=element_text(size=16))
  
})

##########################################################################################



##########################################################################################

output$plot <- renderPlot({ 
  
  TopTenCategoryPlot()  %>%
    ggplot(aes(x = ProductCodeDesc,y = n),environment=environment()) +
    geom_bar(stat='identity',colour="white", fill =fillColor2) +
    geom_text(aes(x = ProductCodeDesc, y = 1, label = paste0("(",n,")",sep="")),
              hjust=0, vjust=.5, size = 4, colour = 'black',
              fontface = 'bold') +
    labs(x = 'Item Code', y = 'Count of Items Sold',
         title = 'Count of Items Sold') +
    coord_flip() +
    theme_bw() + theme(text=element_text(size=16))
  
})

######################################################################################
