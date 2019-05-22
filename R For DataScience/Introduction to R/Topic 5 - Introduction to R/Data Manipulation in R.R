letters
letters.factor=as.factor(letters)
ls()
rm(letters)

## Numeric Object
Price<-c(100,200)
Price
length(Price)

## Adding NULL value
Price<-c(100,200,NULL)
Price
#Gives the total number of elements in Price object
length(Price)

## Adding a missing value
Price<-c(100,200,NA)
Price
length(Price)

## Checking for missing value
is.na(Price)

#which element
which(is.na(Price))
which(Price==100)


## Character object
Names<-c("John","Robert",NA,"Catherine")
Names
length(Names)

## To view the type of object
class(Names)
class(Price)

## Setting the working directory
setwd("D:\\Data Manipulation with R\\")
getwd()


## More functions
Sequence<-seq(1970,2000)
Sequence

Sequence_By<-seq(from=1,to=5,by=0.5)
Sequence_By
rep(1,5)
rep(1:5,2)
rep(1:5,each=2)

# I want to get this 1,1,1,5,1,5,2,2
new_seq<-rep(seq(1,2,0.5),each=2)

# Both numeric and character data
mixed<-c(1,2,3,"hi")
mixed

class(mixed)

# scan variable
x<-scan()
x

#Saving an object
save(Names,file="Names.rda")
#Saving whole workspace
save.image("all_work.RData")

# How do I load my data back?
load("Names.rda")

## Datastructures in R
#Vector, matrices,dataframes, Lists

#Vector: Most simple strucrure in R. Only one datatype
x<-c(1,2,3,4)
x

#Lists: Recursive vectors. Can handle different data types
y<-list(1,2,3,4)
y

my.list<-list(name=c("Robert","Emma"),age=c(65,54),
              retired=c(TRUE,FALSE))

my.list

my.list$age
my.list["age"]
my.list[["age"]][1]

my.list[[3]]
my.list[[3]][2]

# Matrices : A single table with rows and columns of data

B=matrix(c(2,4,3,1,5,7),
         nrow=3,
         ncol=2)

B
B[1,]
B[,2]
B[1,2]

#Dataframe : A single table with rows and columns of data
#Each column can be a different datatype
#Consider the following vectors:
products=c("Bag","shoes","belt","belt")
total_price=c(500,1000,150,200)
color=c("Blue","red","red","blue")
quantity=c(5,2,3,4)

product_details<-data.frame(product,total_price,color,quantity,
                            stringsAsFactors = FALSE)
product_details
class(product_details)

product_details[,2]
product_details[2,]
product_details[2,2]
product_details$product

# Iris Dataset in the datassets package
library(datasets)
data()

data(iris)

## Getting the list of  variables
names(iris)
colnames(iris)

## Getting the number of rows and columns
dim(iris)
nrow(iris)
ncol(iris)

## To look at top few or bottom few observations
head(iris)
tail(iris)

## Looking at the structure of datasets
str(iris)

# More about the dataset
?iris

## Checking the type of object
class(iris)

## Attach and detach
head(Species)
head(iris$Species)
attach(iris)
head(Species)

## Importing a csv file
iris=read.csv("Iris.csv",header=T,sep=",")
head(iris)

# Importing a text file
iris<-read.table("Iris.txt",header=T,sep="\t")

head(iris,10)

names(iris)

#Summary of dataset
summary(iris)

# We can check if a given variable is character, numeric, factor
# is.character(), is.factor()
is.character(iris$Species)
is.numeric(iris$Petal.Length)

detach(iris)

# Importing a text file