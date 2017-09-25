TrendDetails <- eventReactive(input$go4,{
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  if(input$StoreID == "All")
  {
    query = "SELECT CREATED_STAMP_Week, COUNT(*) AS n FROM AllTransactions WHERE BARCODE = '"
    
    BillNo = input$BarCode
    
    queryEnd = "' GROUP BY CREATED_STAMP_Week"
    
    queryString = paste0(query,BillNo,queryEnd,"")
    
    AllTransactionsQuery <- dbSendQuery(con, queryString)
    
    returnedDataSet <- dbFetch(AllTransactionsQuery, n = -1)
    
  }
  else
  {
    
    query = "SELECT CREATED_STAMP_Week, COUNT(*) AS n FROM AllTransactions WHERE BARCODE = '"
    
    BillNo = input$BarCode
    
    queryEnd = "' AND STOREID = '"
    
    StoreID = input$StoreID
    
    queryEnd2 = "' GROUP BY CREATED_STAMP_Week"
    
    queryString = paste0(query,BillNo,queryEnd,StoreID,queryEnd2,"")
    
    AllTransactionsQuery <- dbSendQuery(con, queryString)
    
    returnedDataSet <- dbFetch(AllTransactionsQuery, n = -1)
    
  }
  
  if(input$TrendForecasting == "Trend")
  {
    returnedDataSet$CREATED_STAMP_Week = as.integer(returnedDataSet$CREATED_STAMP_Week)
    returnedDataSet = returnedDataSet %>% arrange(CREATED_STAMP_Week)
  }
  
  dbDisconnect(con)
  
  return(returnedDataSet)
  
})

output$TrendPlot <- renderPlot({
  
  if(input$TrendForecasting == "Trend")
  {
    TrendDetails() %>%
      ggplot(aes(x=CREATED_STAMP_Week,y=n)) + 
      geom_line(size=.5, color="red")+geom_point(size=2, color="red")+theme_bw()
    
  }
  else
  {
    Trend = TrendDetails()
    
    CountOfItems = ts(Trend$n)
    
    fit = auto.arima(CountOfItems,stepwise=FALSE, approximation=FALSE)
    
    predictions = fit %>% forecast(h=4)
    
    predictions %>% autoplot(include=10) +theme_bw()
  }
  
})
