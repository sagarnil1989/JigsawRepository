#----1----
library(datasets)
data()
data(iris)
summary(iris)
data1<-iris[iris$Species=='setosa',]
head(data1)
summary(data1)
#----2----
library(datasets)
summary(mtcars)
library(dplyr)
gr_brand<-group_by(mtcars,gear)
summarize(gr_brand,mean(mpg),sd(mpg))
#----3+7----
library(arules)
data()
data(AdultUCI)
summary(AdultUCI)
data3<-filter(AdultUCI,AdultUCI$age<50 & AdultUCI$race=='Black')
summary(data3)
data_7=filter(AdultUCI,AdultUCI$`hours-per-week`<25 & AdultUCI$race=='White' & AdultUCI$sex=='Female')
gr_brand<-group_by(data_7,income)
summarize(gr_brand,mean(age))
#----5----
install.packages('lubridate')
library(lubridate)
data(lakers)
summary(lakers)
data4<-filter(lakers,lakers$game_type=='home' & lakers$opponent=='PHX'& weekdays(as.Date(as.character(lakers$date), "%Y%m%d"))=='Wednesday')
count(data4)
data10<-filter(lakers, weekdays(as.Date(as.character(lakers$date), "%Y%m%d"))=='Monday' & time =='12:00')
count(data4)
#----6----
data6<-filter(lakers,(lakers$team=='POR' & lakers$opponent=='LAL') | (lakers$team=='LAL' & lakers$opponent=='POR'))

data6%>%filter(opponent=="LAL",period>0)%>%mean()
#---8---
gr_brand1<-group_by(lakers,month(as.Date(as.character(lakers$date), "%Y%m%d")))
summarize(gr_brand1,n())




