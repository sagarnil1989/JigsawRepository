# R is Open source 
# R is a statistical tool 
# R is a language 
# R is a collection of library( packages )
# R is a software 

# What is package - It is reuseable piece of code 

# Everything related to R is present at "CRAN" <- Webpage 
# CTRL + SHIFt + C for mulitline comments
library(abind)

library(acepack)

# The datastructures in R 
# Vector, Matrix, Array, List & Dataframes 

# Vector - Element of same type & It is one dimensional 
x <- c(1,2,5,7,10)
x
class(x)
x1 <- c("Kokil", "Shashank", "Swati")
x1
class(x1)
x2 <- c( TRUE, FALSE, FALSE, T, F)
x2
class(x2)

x3 <- c( 10, 20, 40, "Indrajit")
x3
class(x3)

x4 <- c( 10, 20, 40, TRUE)
x4
class(x4)


# Matrix -> 2 D, element of same type 
m1 <- matrix(1:20, nrow=4, ncol=5)
m1


m2 <- matrix(1:20, nrow=4, ncol=5, byrow = TRUE)
m2
m2[3,]
m2[ , 4]
class(m2)
typeof(m2)
# How would I access the element in the 3rd row & 3rd col
m2[3,3]

m2[3,3] <- "Kishore"
m2
class(m2)
typeof(m2)


# Array -> ? Same data type but more than 2 dimesnions 
Samp_array <- array(1:200, c(4,6,3))
Samp_array


Samp_array <- array(1:200, c(4,6,5))
Samp_array

# ARRAY[ ROW, COL, MATRIX]
Samp_array[ ,   , 4]
Samp_array[ 3,   , ]

class(Samp_array[ 3,   , ])

Samp_array[ 4,4, 3] <- 6400
Samp_array

# 4th DS - LIST 
  # Different datatypes 
  # Different DataStructures 
  
list1 <- list(m1, x4, Samp_array)
class(list1)
list1
names(list1) <- c("m1", "x4", "Samp_array")
list1
# 5th DS - Think of XL sheet or Think of Database table 

length(list1)

# How to find out in which directory we are in ?
getwd()
setwd("C:\\JS\\Introduction To R\\New folder\\Intro to R")
getwd()

data1 <- read.csv("cpu.csv")
View(data1)

# read.xlsx 
class(data1)

# Create a dummy application of twitter - 5 mins 
# Load twitteR package 
# Get the access token details from twitter dummy account 
# Pass them in R 
# 

# Work with Dataframes 
head(data1)
head(data1, 10)
tail(data1)
tail(data1, 5)
#   What is datatype of each cols ?
str(data1)
nrow(data1)
ncol(data1)
dim(data1)
colnames(data1)
colnames(data1$MYCT)

data2 <- data1
data2$MYCT <- "myct1"

colnames(data1)[2]
colnames(data1)[2] <- "MYCT1"
View(data1)

colnames(data1)[c(3,6)] <- c("MMIN1","CHMIN1")
View(data1)

# create a new dataframe with only first 5 rows 
data2<-data1[1:5,]
View(data2)

# Create a new dataframe with rows 5,7,17,29,30 
data3<-data1[c(5,7,17,29,30),  ]
View(data3)

# create dataframe contains 1,7,9 col 
data4 <- data1[,c(1,7,9)]
View(data4)

data5 <- data1[15:25 ,c(1,7,9)]
View(data5)

# Use of brackets 
  # SQUARE BRACKET IS TO ACCESS DATA 

data1[ ,3] 

# I want to select all cols but not the 8th col 
data6<-data1[,-8]
View(data6)

data7<-data1[,c("Vendor","CACH","ERP")]
View(data7)

data8<-data1[data1$Vendor =="basf", ]
View(data8)

data8 <- subset(data1, data1$Vendor == "basf")
View(data8)

data9 <- subset(data1, data1$MYCT1 > 200 & data1$CACH < 50)
View(data9)

data1$DIFF <- data1$MMAX - data1$MMIN1
View(data1)

data10 <-data1[ , c(1,2,3,4,10,5,6,7,8,9)]
data11 <-data1[ , c(1:4,10,5:9)]

which(data1$CHMIN1)

which(colnames(data1)=="CHMIN1") 
which(data1$Vendor == "basf")

data1$DIFF <- NULL  
View(data1)

# What is a R workspace 
save.image(file="C:\\JS\\Introduction To R\\New folder\\Intro to R\\Workspace11.RData")

rm(data10,data9)

load("C:\\JS\\Introduction To R\\New folder\\Intro to R\\Workspace11.RData")

import1<-read.table("C:\\JS\\Introduction To R\\New folder\\Intro to R\\sample2.csv",sep=",",header = TRUE)
View(import1)

summary(import1) #Focus on the missing values
str(import1) #Are column data types correct

import2<-read.table("C:\\JS\\Introduction To R\\New folder\\Intro to R\\sample1.txt")#Why error

import2<-read.table("C:\\JS\\Introduction To R\\New folder\\Intro to R\\sample1.txt",sep="\t")

import2#What is wrong?
View(import2)

import2<-read.table("C:\\JS\\Introduction To R\\New folder\\Intro to R\\sample1.txt",sep="\t",header=TRUE)
View(import2)

summary(import2)
str(import2)

import2<-read.table("C:\\JS\\Introduction To R\\New folder\\Intro to R\\sample1.txt",sep="\t",header=TRUE,na.strings = c(NA,"Missing",""))
View(import2)
summary(import2)

str(import2)

class(import1)
class(import2)

###Working with web data###

#Working with web objects JSON and XML#
#Sometimes data is not available in tabular formats: csv, sql servers#
#Particuarly when working with API's

#Glassdoor API, https://www.glassdoor.co.in/developer/index.htm
library(jsonlite)
web1<-fromJSON("http://api.glassdoor.com/api/api.htm?v=1&format=json&t.p=47699&t.k=g9GdVHlQ1eM&action=employers&q=pharmaceuticals&userip=192.168.43.42&useragent=Mozilla/%2F4.0")
web1

class(web1)
names(web1)
web1$response

str(web1)

#Getting tables from web pages
#Many web pages contain tabular data as comma separated or tab separated
#UCI Abalone data set
web2<-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data",header=FALSE)

head(web2)# Column names are missing

#Use the documentation on the page to figure out the column names

name<-c("Sex","Length","Diameter","Height","Whole.Weight","Shuclked.Weight","Viscera.Weight","Shell.Weight","Rings")

names(web2)<-name
head(web2)
str(web2)

#Fetching HTML tables from a webpage
library(XML) 
temp1 <-readLines(url("http://www.inflationdata.com/Inflation/Consumer_Price_Index/HistoricalCPI.aspx?reloaded=true"))
web3 <- readHTMLTable(temp1,  asText = TRUE)
class(web3)  # Why the class of HTMLTable is list ???
web3
length(web3)

#If analysis on this data has to be done then it should be converted to a dataframe

web4<-as.data.frame(web3)
View(web4)
class(web4)
head(web4)#What is wrong?

# How to read data from the databases 
# ORACLE - RODBC   
# SQLITE - RSqlite
# MYSQL  - RODBC, RMySql 
# HADOOP  - RHadoop 
# TERADATA - ?

#Working with SQL servers#

#Identify which SQL data base you are working with
#MySql and Postgresql are most popular

#If mysql is the sql engine to be connected then RMySql can be used to connect R to sql

library(RMySQL)
# Database name , What is the location DB, UserID, PWD 

con<-dbConnect(MySQL(),dbname="classicmodels",username="root",password="anil123")
con # credential object 

dbListTables(con)

import.sql1<-dbGetQuery(con,"SELECT * FROM customers")
View(import.sql1)

# Frankfurt
DF2  <-dbGetQuery(con,"SELECT * FROM customers where city = 'Frankfurt' ")
View(DF2)

class(import.sql1)

dbDisconnect(con)

#One way to connect to SQL is using RODBC, this will work with other SQL distribution such as Postgresql, SQL Server and not just MySQL

#library(RODBC)
#connection<-odbcConnect(dsn = MYDSN,"classicmodels",uid="root",pwd="anil123") #dsn has to be specified, this will be linked to only one database in sql server. dsn can be changed by accessing control panel, admnistrative tools, odbc data sources

#myconn <-odbcConnect("MYDSN", uid="root", pwd="anil123")
#sqlTables(connection)

#import.sql2<-sqlFetch(connection,"city")

#close(connection)

#class(import.sql2)


# Connect with Twitter 
#https://apps.twitter.com
library(twitteR)
library(ROAuth)

# You'd need to set global options with an authenticated app
consumerKey <- "xxxxxxxxxxxxxxxxxxxxxx"
consumerSecret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
accessToken <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
accessTokenSecret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)
tweets = searchTwitter("#ANYONE")  # result of this command is a list data structure 
tweets[[3]]
class(tweets)

