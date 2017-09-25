#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(tidyverse)
library(data.table)
library(lubridate)
library(forecast)
library(DBI)
library(RSQLite)
library(stringr)

rm(list=ls())

fillColor = "#FFA07A"
fillColor2 = "#F1C40F"




ProductMaster = read.csv(file="../input/ProductMaster404b8b3.csv",stringsAsFactors = FALSE)

ProductMasterDistinct = ProductMaster %>% distinct()


# Define server logic 
shinyServer(function(input, output) 
  {
  
  source("server/ProductDetails.R",local = TRUE)
  
  source("server/BillDetails.R",local = TRUE)
  
  source("server/TopTen.R",local =TRUE)
  
  source("server/MarketBasketAnalysis.R",local =TRUE)
      
  source("server/TrendDetails.R",local =TRUE)
      
  source("server/InventoryDetails.R",local = TRUE)
 
  }
)
  
  

