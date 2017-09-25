library(tidyverse)
library(data.table)
library(lubridate)

rm(list=ls())

fillColor = "#FFA07A"
fillColor2 = "#F1C40F"

BusyTransactions_dump <- tibble(text = read_lines("input/BUSY7246fb6.csv", skip = 1))

BusyTransactions <- BusyTransactions_dump %>%
  separate(text, into = c("POS_Application_Name",
                          "STOREID",
                          "MACID",
                          "BILLNO",
                          "BARCODE",
                          "GUID",
                          "CREATED_STAMP",
                          "CAPTURED_WINDOW",
                          "UPDATE_STAMP"), sep = "\\|")

rm(BusyTransactions_dump)

EasySOLTransactions_dump <- tibble(text = read_lines("input/EASYSOL326dc49.csv", skip = 1))

EasySOLTransactions <- EasySOLTransactions_dump %>%
  separate(text, into = c("POS_Application_Name",
                          "STOREID",
                          "MACID",
                          "BILLNO",
                          "BARCODE",
                          "GUID",
                          "CREATED_STAMP",
                          "CAPTURED_WINDOW",
                          "UPDATE_STAMP"), sep = "\\|")
rm(EasySOLTransactions_dump)

MargTransactions_dump <- tibble(text = read_lines("input/MARGfc72cd7.csv", skip = 1))

#POS_Application_Name|STOREID|MACID|BILLNO|BARCODE|GUID|CREATED_STAMP|CAPTURED_WINDOW|UPDATE_STAMP

MargTransactions <- MargTransactions_dump %>%
  separate(text, into = c("POS_Application_Name",
                          "STOREID",
                          "MACID",
                          "BILLNO",
                          "BARCODE",
                          "GUID",
                          "CREATED_STAMP",
                          "CAPTURED_WINDOW",
                          "UPDATE_STAMP"), sep = "\\|")

rm(MargTransactions_dump)

RetailExPerTransactions_dump <- tibble(text = read_lines("input/RETAIL_EXPERe490dde.csv", skip = 1))

#POS_Application_Name|STOREID|MACID|BILLNO|BARCODE|GUID|CREATED_STAMP|CAPTURED_WINDOW|UPDATE_STAMP

RetailExPerTransactions <- RetailExPerTransactions_dump %>%
  separate(text, into = c("POS_Application_Name",
                          "STOREID",
                          "MACID",
                          "BILLNO",
                          "BARCODE",
                          "GUID",
                          "CREATED_STAMP",
                          "CAPTURED_WINDOW",
                          "UPDATE_STAMP"), sep = "\\|")

rm(RetailExPerTransactions_dump)

SoftGenTransactions_dump <- tibble(text = read_lines("input/SOFT_GENd6661f5.csv", skip = 1))

#POS_Application_Name|STOREID|MACID|BILLNO|BARCODE|GUID|CREATED_STAMP|CAPTURED_WINDOW|UPDATE_STAMP

SoftGenTransactions <- SoftGenTransactions_dump %>%
  separate(text, into = c("POS_Application_Name",
                          "STOREID",
                          "MACID",
                          "BILLNO",
                          "BARCODE",
                          "GUID",
                          "CREATED_STAMP",
                          "CAPTURED_WINDOW",
                          "UPDATE_STAMP"), sep = "\\|")

rm(SoftGenTransactions_dump)

AllTransactions =  rbind(BusyTransactions,EasySOLTransactions,MargTransactions,
                         RetailExPerTransactions,SoftGenTransactions)

#Date Manipulations
AllTransactions$CREATED_STAMP = as.Date(AllTransactions$CREATED_STAMP)
AllTransactions$CREATED_STAMP_Year = year(ymd(AllTransactions$CREATED_STAMP))
AllTransactions$CREATED_STAMP_Month = month(ymd(AllTransactions$CREATED_STAMP))
AllTransactions$CREATED_STAMP_Day = day(ymd(AllTransactions$CREATED_STAMP))
AllTransactions$CREATED_STAMP_Week = week(ymd(AllTransactions$CREATED_STAMP))

AllTransactions = AllTransactions %>% select(-GUID,-UPDATE_STAMP,-CAPTURED_WINDOW)


write.csv(AllTransactions, file = "output/AllTransactions.csv",row.names=FALSE)

AllTransactions2 = fread("output/AllTransactions.csv")

class(AllTransactions2)

AllTransactions2 = as.data.frame(AllTransactions2)

class(AllTransactions2)


ProductMaster = read.csv(file="input/ProductMaster404b8b3.csv",stringsAsFactors = FALSE)

ProductMasterDistinct = ProductMaster %>% distinct()

write.csv(ProductMasterDistinct, file = "output/Products.csv",row.names=FALSE)

ProductMasterDistinct2 = fread("output/Products.csv")

class(ProductMasterDistinct2)

ProductMasterDistinct2 = as.data.frame(ProductMasterDistinct2)

class(ProductMasterDistinct2)


