#Class 04 - Importing & Exporting Data in R
#Topic 4 - Working with excel workbooks

###Dataset Details
##Customer data with information related to first name, last name, 
##city, country, state and zip
##Filenames: customers.xlsx and customers.xls
##Filetype: Excel Workbooks
##Sheets: newyork, california, others

###Using XLConnect R package
##Reading from excel files
#Loading Library
library(XLConnect)

#Loading Excel Workbook
wb<-loadWorkbook("customers.xlsx")

#Reading "newyork" sheet from workbook connection
newyork<-readWorksheet(wb,
                       "newyork",
                       header=T)

#Reading "california" sheet from workbook connection
california<-readWorksheet(wb,
                          "california",
                          header=T)

#Reading "newyork" sheet directly from excel file
newyork<-readWorksheetFromFile("customers.xlsx",
                               "newyork",
                               header=T)

#Using .xls excel file
newyork<-readWorksheetFromFile("customers.xls",
                               "newyork",
                               header=T)

##Writing to excel files
#Using createSheet for creating a new worksheet in excel file
createSheet(wb,"new sheet")

#Writing R data frame object 
writeWorksheet(wb,newyork,"new sheet")

#Saving the workbook
saveWorkbook(wb,"customers.xlsx")

###Using xlsx R package
##Reading from excel files
#Loading Library
library(xlsx)

#Reading a sheet from .xlsx excel file into R data frame
newyork<-read.xlsx("customers.xlsx",
                   sheetName="newyork")

#Reading a sheet from .xls excel file into R data frame
newyork<-read.xlsx("customers.xls",
                   sheetName="newyork")

##Writing to excel files
#Export a data frame into excel file
write.xlsx(newyork,
           "customers_newyork.xlsx",
           sheetName="newyork",
           row.names=F)

###Using gdata R package
##Reading from excel files
#Loading Library
library(gdata)

#Reading a sheet from .xlsx excel file
newyork<-read.xls("customers.xlsx",
                  sheet="newyork")

#Reading a sheet from .xls excel file
newyork<-read.xls("customers.xls",
                  sheet="newyork")