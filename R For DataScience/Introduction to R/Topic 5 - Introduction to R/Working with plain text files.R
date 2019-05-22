#Class 04 - Importing & Exporting Data in R
#Topic 2 - Working with plain text files

###Dataset Details
##Customer data with information related to first name, last name, city, country, state and zip
##Filename: 2 files: 1) customers.csv 2) customers.txt
##Filetype: 2 versions: 1) comma delimiter 2) tab delimiter
##Rows:500
##Columns:6

###Reading data into R
##Using scan function

#Complete syntax of scan function
?scan

#Entering data in R console
#Default variable type is numeric
#Use what option for entering character data
x<-scan()
x<-scan(what="")

#Reading data from a plain text file
#Using customers.csv data for comma delimiter
customers<-scan("customers.csv",
           sep=",",
           skip=1)

#Using customers.csv data with what option
customers<-scan("customers.csv",
                what = "",
                sep=",",
                skip=1)

#Using list option to store output as a list
customers<-scan("customers.csv",
                what = list(first_name="",last_name="",city="",county="",state="",zip=0),
                sep=",",
                skip=1)

#Limiting the number of lines to read using nmax option
customers<-scan("customers.csv",
                what = list(first_name="",last_name="",city="",county="",state="",zip=0),
                sep=",",
                nmax=400,
                skip=1)

#Using NULL option for some columns
customers<-scan("customers.csv",
                what = list(first_name="",last_name="",city=NULL,county=NULL,state="",zip=0),
                sep=",",
                skip=1)

#Using customers.txt data for tab delimiter
customers<-scan("customers.txt",
                what = list(first_name="",last_name="",city="",county="",state="",zip=0),
                sep="\t",
                skip=1)

##Using read.table function
#Complete syntax of read.table function
?read.table

#Using the common required options
customers<-read.table("customers.csv",
                      header=TRUE,
                      sep=",")

#Using tab delimited file
customers<-read.table("customers.txt",
                      header=TRUE,
                      sep="\t")

#Using different file path other than working directory
customers<-read.table("C:/Users/sony/Documents/customers.csv",
                      header=TRUE,
                      sep=",")

#Loading string variables as-is without converting them to factors
customers<-read.table("customers.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors=F)

customers<-read.table("customers.csv",
                      header=TRUE,
                      sep=",",
                      as.is=T)

#Declaring variable types separately using colClasses function
varTypes = 
  c(first_name="character",last_name="character",
    city="character",county="character",
    state="character",zip="numeric")

customers<-read.table("customers_noheader.csv",
                      header=F,
                      sep=",",
                      col.names=names(varTypes),
                      colClasses=varTypes)

##Using read.delim function
#Complete syntax of read.delim function
?read.delim

#A wrapper function of read.table useful for reading tab delimited files
customers<-read.delim("customers.txt",
                      header=TRUE,
                      as.is=T)

#Can be used files with different delimiters
#Using comma separated file
customers<-read.delim("customers.csv",
                      header=TRUE,
                      sep=",",
                      as.is=T)

##Using read.csv function
#Complete syntax of read.csv function
?read.csv

#A wrapper function of read.table useful for reading comma delimited files
customers<-read.csv("customers.csv",
                    header=TRUE,
                    as.is=T)

##Using readLines function
#Complete syntax of readLines function
?readLines

#Useful in checking the characteristics of a text file
readLines("customers.csv",
          n=5,
          ok=T,
          warn=T)

##Dealing with missing values while data import in R
#Missing values in numeric variables
#Represented as blanks, even formats like Nan, Inf, -Inf work
customers<-read.table("customers_missing_num.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors=F)

#Missing values in character variables
#Default representation is NA notation in source file
#Can change notation using na.strings() option
customers<-read.table("customers_missing_char1.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors=F)

customers<-read.table("customers_missing_char2.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors=F,
                      na.strings="")

customers<-read.table("customers_missing_char2.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors=F,
                      na.strings=c("","NA","-"))

##Using specific parameters while importing data in R
#Useful while dealing with text data
customers<-read.table("tweet_data.txt",
                      header=F,
                      stringsAsFactors=F,
                      sep="\n",
                      quote="",
                      comment.char="",
                      strip.white=T, 
                      fill=T)

###Writing data from R
##Reading customer data
customers<-read.csv("customers.csv",
                    header=TRUE,
                    as.is=T)

##Using write.table function
write.table(customers,
            "customers_new.csv",
            sep=",")

#To supress row.names output
write.table(customers,
            "customers_new.csv",
            sep=",",
            row.names=F)

##Using write.csv function
write.csv(customers,
          "customers_new1.csv",
          row.names=F)

##Using cat function
#Deals only with character vectors
#Useful for priting output from custom functions
cat(customers$first_name, sep=",")
cat(customers$zip, sep=".")

#Saving output to external file
cat(customers$first_name,
    file="new.txt",
    sep=",")

##Using writeLines function
#Deals only with character vectors
#Similar to cat function
writeLines(customers$first_name,
           "new.txt",
           sep=",")
