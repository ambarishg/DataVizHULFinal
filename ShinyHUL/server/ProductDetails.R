ProductDetails <- eventReactive(input$goProduct,{
  
  returnedDataSet = ProductMasterDistinct
  
  if (trimws(input$BrandCategoryDesc)  == "" )
  {
    returnedDataSet = NULL
  }
  
  if(trimws(input$BasePackDesc)  != "" )
  {
    returnedDataSet = returnedDataSet %>%
      filter(str_detect(BASEPACK_DESC,
                        fixed(input$BasePackDesc,ignore_case=TRUE)))
    
  }
  
  if (trimws(input$SubCategoryDesc)  != "" )
  {
    returnedDataSet = returnedDataSet %>%
      filter(str_detect(SUBCATEGORY_DESC,fixed(input$SubCategoryDesc,ignore_case=TRUE)))
  }
  
  if (trimws(input$BrandCategoryDesc)  != "" )
  {
    returnedDataSet = returnedDataSet %>%
      filter(str_detect(BRAND_DESC,
                        fixed(input$BrandCategoryDesc,ignore_case = TRUE)
                       )
            )
  }
  
  
  
  
  return(returnedDataSet)
})

output$ProductDetailsTable = DT::renderDataTable({ProductDetails()} ) 