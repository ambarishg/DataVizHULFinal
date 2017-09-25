#Market Basket Analysis

TopTenNBACategoryPlot <- eventReactive(input$go3,{
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  if(
    (input$MBACategory == "NBA") ||
    (input$MBACategory == "NBHUL")
  )
  {
    cat("Entered in Common Code Section","\n")
    
    # SELECT DISTINCT(BARCODE), COUNT(*) AS n FROM AllTransactions WHERE BILLNO IN
    # (SELECT BILLNO FROM AllTransactions 
    #   WHERE BARCODE = '8901030341663') GROUP BY BARCODE
    # HAVING (n > 50);
    
    
    queryString = "SELECT DISTINCT(BARCODE), COUNT(*) AS n FROM AllTransactions WHERE BILLNO IN
    (SELECT BILLNO FROM AllTransactions
    WHERE BARCODE = '8901030341663') GROUP BY BARCODE
    HAVING (n > 50)"
    
    AllTransactionsQuery <- dbSendQuery(con, queryString)
    
    AllItems_WithTopProduct_1 <- dbFetch(AllTransactionsQuery, n = -1)
    
    AllItems_WithTopProduct_1Desc = AllItems_WithTopProduct_1 %>% 
      arrange(desc(n))%>%
      left_join(ProductMasterDistinct)   
    
    
  }
  
  ##################################################################################
  
  if(
    (input$MBACategory == "TKA") ||
    (input$MBACategory == "TKHUL")
  )
  {
    
    #8901030534898
    
    queryString = "SELECT DISTINCT(BARCODE), COUNT(*) AS n FROM AllTransactions WHERE BILLNO IN
    (SELECT BILLNO FROM AllTransactions
    WHERE BARCODE = '8901030534898') GROUP BY BARCODE
    HAVING (n > 50)"
    
    AllTransactionsQuery <- dbSendQuery(con, queryString)
    
    AllItems_WithTopProduct_1 <- dbFetch(AllTransactionsQuery, n = -1)
    
    AllItems_WithTopProduct_1Desc = AllItems_WithTopProduct_1 %>% 
      arrange(desc(n))%>%
      left_join(ProductMasterDistinct)
    
    
  }
  
  
  
  
  ##################################################################################
  
  if( (input$MBACategory == "NBA") || (input$MBACategory == "TKA") )
  {
    
    dataSetReturned = AllItems_WithTopProduct_1Desc %>%
      ungroup() %>%
      filter(BASEPACK_DESC != "OTHERS") %>%
      head(10) %>%
      mutate(ProductCodeDesc = paste0(BARCODE,"-",BASEPACK_DESC)) %>%
      mutate(ProductCodeDesc = reorder(ProductCodeDesc,n)) %>%
      select(ProductCodeDesc,n,SUBCATEGORY_DESC,BRAND_DESC)
    
  }
  
  if( (input$MBACategory == "NBHUL") || (input$MBACategory == "TKHUL") )
  {
    
    dataSetReturned = AllItems_WithTopProduct_1Desc %>%
      ungroup() %>%
      filter(COMPANY_CODE == "HUL") %>%
      head(10) %>%
      mutate(ProductCodeDesc = paste0(BARCODE,"-",BASEPACK_DESC)) %>%
      mutate(ProductCodeDesc = reorder(ProductCodeDesc,n)) %>%
      select(ProductCodeDesc,n,SUBCATEGORY_DESC,BRAND_DESC)
  }
  
  dbDisconnect(con)
  
  return(dataSetReturned)
  
})


#######################################################################################


output$MBAplot <- renderPlot({
  
  TopTenNBACategoryPlot() %>%
    ggplot(aes(x = ProductCodeDesc,y = n)) +
    geom_bar(stat='identity',colour="white", fill =fillColor) +
    geom_text(aes(x = ProductCodeDesc, y = 1, label = paste0("(",n,")",sep="")),
              hjust=0, vjust=.5, size = 4, colour = 'black',
              fontface = 'bold') +
    labs(x = 'Item Code', y = 'Count of Items Sold',
         title = 'Count of Items Sold') +
    coord_flip() +
    theme_bw() + theme(text=element_text(size=16))
  
})

###########################################################

output$MBATable  = DT::renderDataTable( {TopTenNBACategoryPlot()} )

######################################################################################