#Class 04 - Importing & Exporting Data in R
#Topic 6 - Working with databases

###File Details
##Database Engine: SQLite
##Database Name: customersDB
##Tables: newyork, california, others
##Information: Customer data with information related to first name, last name, city, county, state and zip

###Using RSQLite Package - A specific SQLite related database package
##Interacting with SQLite database tables
##Loading Library
library(RSQLite)

##Database connectivity
sqlite<-dbDriver("SQLite")
customersdb<-dbConnect(sqlite,"customersDB.db")

##Listing tables
dbListTables(customersdb)

##Listing fields from a table
dbListFields(customersdb,"newyork")

##Running SQL queires
dbGetQuery(customersdb,
           "select count(*) from newyork")

dbGetQuery(customersdb,
           "select * from newyork limit 10")

dbGetQuery(customersdb,
           "select city,count(*) as cnt from newyork group by city order by cnt desc")

##Reading data from SQLite to R
newyork<-dbReadTable(customersdb, "newyork")
head(newyork)

##Writing data from R to SQLite
dbWriteTable(customersdb,"newyork1",newyork)

##Disconnecting database connection
dbDisconnect(customersdb)

###Using RODBC Package - A general purpose database package
##Interacting with SQLite database tables
##Loading Library
library(RODBC)

##Create a data source name on system under ODBC connections
##Install SQLite driver
##Update SQLite db details under ODBC connections

##Database connectivity
##Opening ODBC connection
customers<-odbcConnect("customersdb",
                       believeNRows = FALSE,
                       rows_at_time = 1)

##Information about current database connection
odbcGetInfo(customers)

##Listing the tables present in the database
sqlTables(customers)

##Running SQL queries
sqlQuery(customers,
         "select count(*) from newyork")

sqlQuery(customers,
           "select * from newyork limit 10")

sqlQuery(customers,
           "select city,count(*) as cnt from newyork group by city order by cnt desc")

##Closing ODBC connection
odbcClose(customers)