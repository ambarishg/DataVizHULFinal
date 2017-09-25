#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

actionButton <- function(inputId, label, btn.style = "" , css.class = "") {
  if ( btn.style %in% c("primary","info","success","warning","danger","inverse","link")) {
    btn.css.class <- paste("btn",btn.style,sep="-")
  } else btn.css.class = ""
  
  tags$button(id=inputId, type="button", class=paste("btn action-button",btn.css.class,css.class,collapse=" "), label)
}

# Define UI for application that draws a histogram
shinyUI(
  
  navbarPage(
    "HUL POS Analytics",
    
    source("ui/ProductDetails.R",local = TRUE)$value,
    
    source("ui/BillDetails.R",local = TRUE)$value,
    
    source("ui/InventoryTracking.R",local = TRUE)$value,
    
    source("ui/TopTen.R",local = TRUE)$value,
    
    source("ui/MarketBasketAnalysis.R",local = TRUE)$value,
    
    source("ui/TrendDetails.R",local = TRUE)$value
    ###############################################################################################

    )
)



