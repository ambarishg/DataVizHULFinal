InventoryDetails <- eventReactive(input$go5,{

  StartDate = as.character(input$DateRange[1])
  
  EndDate = as.character(input$DateRange[2])
  
  con = dbConnect(SQLite(), dbname="../output/AllTransactions.db")
  
  query = "SELECT * FROM AllTransactions WHERE BARCODE = '"
  
  BarcodeNo = input$BarCodeInv
  
  if(input$StoreIDInv == "All")
  {
    queryEnd = "'"
    
    StoreID = ""
    
    queryEnd2 = " AND CREATED_STAMP BETWEEN '"
  }
  else
  {
    queryEnd = "' AND STOREID = '"
    
    StoreID = input$StoreIDInv
    
    queryEnd2 = "' AND CREATED_STAMP BETWEEN '"
  }
  
  queryEnd3 = "' AND '"
  
  queryEnd4 ="'"
  
  queryString = paste0(query,BarcodeNo,queryEnd,StoreID,queryEnd2,StartDate,queryEnd3,
                       EndDate,queryEnd4,"")
  
  cat("\n"," Query : ",queryString)
  
  InventoryQuery <- dbSendQuery(con, queryString)
  
  InventoryQueryDetails <- dbFetch(InventoryQuery, n = -1)
  
  returnedDataSet = InventoryQueryDetails %>%
    left_join(ProductMasterDistinct) %>%
    select(STOREID,BARCODE,BASEPACK_DESC,SUBCATEGORY_DESC,CREATED_STAMP)
  
  dbDisconnect(con)
  
  return(returnedDataSet)
})

output$InventoryDetailsTable = DT::renderDataTable({InventoryDetails()} ) 