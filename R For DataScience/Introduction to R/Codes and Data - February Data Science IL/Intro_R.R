##----------------------Introduction to R--------------------------------#
getwd()
setwd("C:/Users/User10/Desktop/Jigsaw/Intro & manipulation in R")

#USe # for writing a comment

#Assignment of values to a variable "<-"
x1<- 5
x2 = 7
x3 <- 155

#Can do arithmetic operations
p<-5
p
q<-p+2
q

a<- 5+5
a

pi
sqrt(25)
2^2+5


# Items in R are stored as objects


#Over writing a variable
x<- 5
x<-"Jigsaw"

#deleting the variables
rm(x1)
x1

#Programatically figuring out objects
ls()
data()
data("iris")
class(iris)
class(AirPassengers)
?iris


# How to create a vector?
# It consists of either numbers,strings, or logical values but not all of them together.
# It contains only 1 type of element
# Type of variables : Class of the variables (Integer,character,logical)

# c is the combining operator

# Vector : Most Simplest structure in R .Only one data type


#Integer
z<- c(3L,4L,35L)
class(z)

#Numeric  
x<-5 #it is a numeric vector of 1 element
x<-c(1,2,-5,6) # numeric vector of 4 elements
x
class(x)

a<-3
a1<-c(a,a*4,-7*a)
a1

A<-c(1,2,3,NA*3)
A
class(A)


x<-c(1,2,3,4)
class(x)
x1<-c(1.2,2.4,3.5,4.5)
class(x1)


#Character
string<-c("1","2","2","3","4")
class(string)

B<-c('a','b','c',NA)
B
class(B)

#Logical
sp<-c(TRUE,FALSE,TRUE)  
class(sp)


#Vectors shouldn't have mixed type of data
p<-c(1,2,"g")

class(p)
p<-c(TRUE,FALSE,"G")
class(p)

p<-c(TRUE,FALSE,3)
class(p)
class(c(TRUE,FALSE,1))
class(c(1,2,"G"))
class(c("A","B",4))
class(c("A","B",FALSE))


#Vector,working with vectors

num<-c("a","b","c","d","e")
num
num[1]
num[4]
num[-1]
num[1:3]
num

num1<- num

#assgining names
names(num)<-c("x1","x2","x3","x4","x5")
names(num)[4]
num["x4"]
num[c("x1","x2")]


length(num)

a1<-c(1,2,3)
a2<-c(4,5,6)
a1+a2



#factors
#stores categorical variables.

gender<- c(1,2,1,2,1,2,1,2)
gender <- factor(gender, levels = c(1,2), 
                 labels = c("Male","Female"))
table(gender)
class(gender)

x <- c("yes","no","no","yes","no")
x
class(x)
y <- as.factor(x)
class(y)
table(y)



#dataframes
#Each column can be a different Data types. 
#Consider the following vectors : 

product=c("Bag","shoes","belt","belt")

total_price=c(500,1000,150,10000)

color=c("Blue","red","red","Blue")

quantity=c(5,NA,3,4)


product_details <- data.frame(product,total_price,color,quantity,stringsAsFactors=T)
product_details


class(product_details)

str(product_details)

product_details1 <- data.frame(product,total_price,color,quantity)
str(product_details1)

product_details[,2]
product_details[,"total_price"]

product_details[1:2,]
product_details[2,2]

product_details[2,c("color","quantity")]
product_details[2,-2]

data()
data("iris")
head(iris,10)
tail(product_details,2)


#Lists : Recursive vectors. Can handle different data types
my.list <- list( name = c("Robert", "Emma"), age = c (65, 54,43),retired = c (TRUE, FALSE),product_details)

my.list

my.list$age
my.list["age"]

class(my.list$age)
class(my.list)

class(my.list["age"])

my.list[["age"]][2]

my.list[3]
my.list [[3]][2]

my.list$name


#Data.frames

id<- c(1:100)
id
class<- c(rep("1st-Standard",50),rep("2nd-Standard",50))
class
score<- c(rep(75,50),rep(80,50))
score

mydata<- data.frame(Roll_num =id,
                     Standard = class,
                     Score =score )

mydata

head(mydata)
head(mydata,10)
tail(mydata)
dim(mydata)
str(mydata)
summary(mydata)


#Matrix

mat<- matrix(c(2:10),3,3)
mat

mat1<-  matrix (c(1:15), nrow = 5, ncol = 3)
mat1


#array
ary<- array(c(1:15),dim = c(3,5,1,2))
ary

##Importing tabular data##

#Checks needed to ensure that data is imported correctly


import1<-read.table('sample2.csv',sep=",",header = T)
import1

summary(import1) 
str(import1) #Are column data types correct

import2<-read.table("sample1.txt")#Why error

import2<-read.table("sample1.txt",sep="\t")

import2#What is wrong?

import2<-read.table("sample1.txt",sep="\t",header=TRUE)
import2
summary(import2)
str(import2)

import2<-read.table("sample1.txt",sep="\t",header=TRUE,na.strings = c(NA,"Missing",""))
import2
summary(import2)

str(import2)

class(import1)
class(import2)

##Data import is considered successfull: 1.Delimiters are identified correctly, 2.Missing values in the data are recognized as missing (NA)


import3<-read.csv('sample2.csv',header=F)
import3

## Xlsx file

#install.packages("readxl")
library(readxl)

import4 <- read_excel("sample3.xlsx", sheet = 1)
import5 <- read_excel("sample3.xlsx", sheet = "Data2")
import4


#install.packages("jsonlite")
library(jsonlite)
web1<-fromJSON("http://api.glassdoor.com/api/api.htm?v=1&format=json&t.p=47699&t.k=g9GdVHlQ1eM&action=employers&q=pharmaceuticals&userip=192.168.43.42&useragent=Mozilla/%2F4.0")

class(web1)

str(web1)



kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings

write.csv(import5, "C:\\Users\\User10\\Desktop\\Jigsaw\\export5.txt")
