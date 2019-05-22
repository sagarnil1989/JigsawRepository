#Class 04 - Importing & Exporting Data in R
#Topic 3 - Working with large text files

###Dataset Details
##Customer data with information related to first name, last name, city, country, state and zip
##Filename: customers_million.csv
##Filetype: comma delimiter
##Filesize: 42 MB
##Rows:1000000
##Columns:6

##Reading large data into R
#Using read.csv function
#Takes more time as the size of file increases even more
system.time(customers.big<-read.csv("customers_million.csv",
                                    header=T,
                                    sep=","))

#Using fread function
library(data.table)
system.time(customers.big<-fread("customers_million.csv",
                                 header=T,
                                 sep=","))   

#Using read.csv.ffdf function
library("ff")

varTypes = 
  c(first_name="factor",last_name="factor",
    city="factor",county="factor",
    state="factor",zip="factor")

system.time(customers.ffdf<-read.csv.ffdf(file="customers_million.csv",
                                         header=F,
                                         VERBOSE=T, 
                                         first.rows=500000, 
                                         next.rows=500000,
                                         col.names=names(varTypes),
                                         colClasses=varTypes))

#Using optimized read.table function
varTypes = 
  c(first_name="character",last_name="character",
    city="character",county="character",
    state="character",zip="character")

system.time(customers.big<-read.table("customers_million.csv",
                                  nrows=1000000,
                                  header=F,
                                  sep=",",
                                  as.is=T,
                                  col.names=names(varTypes),
                                  colClasses=varTypes,
                                  comment.char=""))
#Using read.csv.sql function
library(sqldf)
system.time(customers.big<-read.csv.sql("customers_million.csv",
                                        header=T,
                                        sep=","))

#Using read.csv.sql function with SQL option
system.time(customers.NY<-read.csv.sql("customers_million.csv",
                                       sql=" select * from file where state='NY' ",
                                       header=T,
                                       sep=","))

###Writing large objects from R
##Using write.table function
system.time(write.table(customers.big,
                        "customers_output.csv",
                        sep=",",
                        row.names=F))

##Using write.table.ffdf function
system.time(write.table.ffdf(customers.ffdf,
                             "customers_output.csv",
                             sep = ",",
                             row.names = F,
                             col.names = T))