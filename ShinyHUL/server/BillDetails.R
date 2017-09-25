BillDetails <- eventReactive(input$go1,{
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  query = "SELECT * FROM AllTransactions WHERE BILLNO = '"
  
  BillNo = input$BillNumber
  
  queryEnd = "'"
  
  queryString = paste0(query,BillNo,queryEnd,"")
  
  AllTransactionsBillNoQuery <- dbSendQuery(con, queryString)
  
  AllTransactionsBillNo <- dbFetch(AllTransactionsBillNoQuery, n = -1)
  
  returnedDataSet = AllTransactionsBillNo %>%
    left_join(ProductMasterDistinct) %>%
    select(STOREID,BARCODE,BASEPACK_DESC,SUBCATEGORY_DESC,CREATED_STAMP)
  
  dbDisconnect(con)
  
  return(returnedDataSet)
})

#####################################################################################
output$BillDetailsTable = DT::renderDataTable({BillDetails()} ) 