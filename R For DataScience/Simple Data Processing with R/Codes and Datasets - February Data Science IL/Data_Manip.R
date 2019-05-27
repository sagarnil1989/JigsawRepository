getwd()
setwd("C:\\Users\\User10\\Desktop\\Jigsaw\\Intro & manipulation in R")
oj <- read.csv("oj.csv")
oj
View(oj)

str(oj)
nrow(oj)
ncol(oj)
dim(oj)
names(oj)

#dataframe[rows,columns]
oj[3,3]

oj[c(1,2,8,456),c(1,3,6)]


oj[c(1:5),"brand"]


#Logical Subseting

#Selecting only those rows where brand bought is tropicana
dat<-oj[oj$brand=='tropicana',]


#Using Or condition, brand bought is tropicana or dominicks
dat1<-oj[oj$brand=='tropicana'|oj$brand=='dominicks',]
head(dat1)
tail(dat1)


#Using And condition, brand bought is tropicana and no feature advertisement is run
dat2<-oj[oj$brand=='tropicana' & oj$feat==0,]
head(dat2,10)



#Subsetting using which() operator
ind<-which(oj$brand=="dominicks")
ind
class(ind)
head(ind)
dat3<-oj[ind,]


#Selecting Columns
dat4<-oj[,c("week","brand")]
head(dat4)


#Selecting+Subsetting
dat5<-oj[oj$brand=='tropicana' & oj$feat==0,
         c("week","store")]
head(dat5)



#Adding new columns
oj$logInc<-log(oj$INCOME)

dim(oj)
View(oj)


oj1 <- oj[,-c(18,1,2)]
View(oj1)

names(oj1)

#Revenue Column
head(oj$logmove)
head(exp(oj$logmove))
oj$revenue<-exp(oj$logmove)*oj$price


oj$revenue
View(oj$revenue)
head(oj$revenue,10)



#Sorting data
numbers<-c(10,100,5,8)
order(numbers)
order(-numbers)


dat6<-oj[order(oj$week),]
head(dat6)
min(oj$week)


dat7<-oj[order(-oj$week),]
head(dat7)
max(oj$week)

##Group by summaries

class(oj$brand)
unique(oj$brand)

summary(oj$INCOME)

#Summarize-Price
#Summarize by-Brand (factor)
#Summarize how-Mean

#Syntax aggregate(variable to be summarized, 
#by=list(variable by which grouping is to be done),function)



class(aggregate(oj$price,by=list(oj$brand),mean))
aggregate(oj$price,by=list(oj$brand,oj$feat),sd)

tapply(oj$price,oj$brand,mean)
class(tapply(oj$price,oj$brand,mean))


#Mean income of people by brand
#Summarize-Income
#Summarize by-Brand
#Summarize how-Mean
aggregate(oj$INCOME,by=list(oj$brand),mean)
class(aggregate(oj$INCOME,by=list(oj$brand),mean))
tapply(oj$INCOME[oj$INCOME<=10.5&oj$brand!='dominicks']
       ,oj$brand[oj$INCOME<=10.5&oj$brand!='dominicks'],mean)
class(tapply(oj$INCOME,oj$brand,mean))




#dplyr
#install.packages("dplyr")

library(dplyr)

dat8<-filter(oj,brand=="tropicana")
dim(filter(oj,brand=="tropicana"))
dim(dat8)


dat9<-filter(oj,brand=="tropicana"|brand=="dominicks")
dim(filter(oj,brand=="tropicana"|brand=="dominicks"))


#Selecting Columns
dat10<-select(oj,brand,INCOME,feat)
View(dat10)


dat11<-select(oj,-brand,-INCOME,-feat)



#Creating a new column
dat12<-mutate(oj,logIncome=log(INCOME),sqrtInc=sqrt(INCOME))
View(dat12)



#Arranging data 
dat13<-arrange(oj,INCOME)
View(dat13)
head(dat13)
min(dat13$INCOME)

dat14<-arrange(oj,desc(INCOME))
View(dat14)
head(dat14,1)
max(dat14$INCOME)


dat14<-arrange(oj,-INCOME)


#Group Wise summaries
gr_brand<-group_by(oj,brand)
class(gr_brand)

summarize(gr_brand,mean(INCOME),sd(INCOME))

group<-as.data.frame(gr_brand)
class(group)


#Pipelines
#Base R code
mean(oj[oj$INCOME>=10.5,"price"])
#dplyr code
summarize(filter(oj,INCOME>=10.5),mean(price))


table1<- oj%>%filter(price>=2.5)%>%mutate(logIncome=log(INCOME))%>%summarize(mean(logIncome),median(logIncome),sd(logIncome))

#masterdata -- applying filter --- got a smallerdaset --- 
#adding new column/variable using mutate ---- getting summary for the new variable

##Date
fd<-read.csv("Fd.csv")
str(fd)
dim(fd)
class(fd)

#install.packages("lubridate")
library(lubridate)
fd$FlightDate<-dmy(fd$FlightDate)
class(fd$FlightDate)


head(months(fd$FlightDate))
unique(months(fd$FlightDate))
head(weekdays(fd$FlightDate))
unique(weekdays(fd$FlightDate))

#Finding time interval
fd$FlightDate[60]-fd$FlightDate[900]
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "weeks")
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "days")
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "hours")
difftime(fd$FlightDate[3000],fd$FlightDate[90])

#Subsetting data based on time information

library(dplyr)
#Subset the data for day=Sunday
dim(fd)
fd_s<-fd%>%filter(weekdays(FlightDate)=="Sunday")
dim(fd_s)

#Find the number of flights on Sundays for destination Atlanta
fd%>%filter(weekdays(FlightDate)=="Sunday",
            DestCityName=="Atlanta, GA")%>%nrow()

#Find the number of flights on Sundays by cities
fd%>%filter(weekdays(FlightDate)=="Sunday")%>%group_by(DestCityName)%>%summarize(n())



#Merging data
##Joins using Merge
df1 = data.frame(CustomerId=c(1:6),Product=c(rep("Toaster",3),
                                             rep("Radio",3)))
df1
df2 = data.frame(CustomerId=c(2,4,6),
                 State=c(rep("Alabama",2),rep("Ohio",1)))
df2

merge(x = df1, y = df2, by = "CustomerId", all = TRUE)#Outer join:

merge(x = df1, y = df2, by = "CustomerId", all.x=TRUE)#Left join

merge(x = df1, y = df2, by = "CustomerId", all.y=TRUE)#Right join

merge(x=df1,y=df2,by="CustomerId")#Inner Join/Intersection of both tables

#Missing values
a<-c(1,2,3,4,5,6,NA,NA,NA,7,8,9)
is.na(a)
sum(is.na(a))
mean(a, na.rm=TRUE)

air<-airquality
head(air)

sum(is.na(air$Ozone))

sum(is.na(air$Solar.R))


summary(air)

#Imputing Missing values

air$Ozone[is.na(air$Ozone)]<-45

air$Solar.R[is.na(air$Solar.R)]<-mean(air$Solar.R,na.rm=TRUE)

summary(air)



#Keep in mind the compatibility of the classes returned and accepted by various functions



#String manipulation

a<-"Batman"


substr(a,start=2,stop=6)

nchar(a)

tolower(a)

toupper(a)


b<-c("Bat-Man")

strsplit(b,split="-")

c<-"Bat/Man/"

strsplit(c,split="/")


grep("-",b)

grepl("/",c)


sub("-","/",b)

d<-"Bat-Ma-n"


sub("-","/",d)
gsub("-","/",d)


dat5<-read.csv("Strings.csv")
str(dat5)
head(dat5)#is there something wrong? 
mean(dat5$Income_M)#Why will this happen

#Need to clean the data

dat5$Income_M<-gsub("Rs","",dat5$Income_M)
head(dat5)

dat5$Income_M<-gsub("/-","",dat5$Income_M)
head(dat5)
mean(dat5$Income_M)#Now why an error?

str(dat5)

dat5$Income_M<-as.numeric(dat5$Income_M)
mean(dat5$Income_M)


#sqldf, This is optional
#install.packages("sqldf")
library(sqldf)
#Using SELECT statement
oj_s<-sqldf("select brand, income, feat from oj ")
#Subseting using where statement
oj_s<-sqldf("select brand, income, feat from oj where price<3.8 and income<10")
#Order by statement
oj_s<-sqldf("select store,brand,week,logmove,feat,price, income from oj order by income asc")
#distinct
sqldf("select  distinct brand from oj")
#Demo sql functions
sqldf("select avg(income) from oj")
sqldf("select min(price) from oj")

##dplyr corner cases
#Selecting odd column names

#install.packages("arules")
library(arules)
data("AdultUCI")

names(AdultUCI)

AdultUCI%>%select(capital-gain)%>%dim()#Why this error?


AdultUCI%>%select(`capital-gain`)%>%dim()#Notice the column name specification



