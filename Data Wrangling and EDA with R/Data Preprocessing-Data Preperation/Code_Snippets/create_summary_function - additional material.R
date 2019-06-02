setwd("D:\\Classes\\Data Exploration")
##-------------Data Exploration and Preparation------------------------#


#Load Data
cars<-read.csv("insurance.csv",header=TRUE,
               stringsAsFactors=TRUE)

#getting the data type,summaries and missing values
lists<-1
maxs<-1
mins<-1
average<-1
sd<-1
u<-1

variable<-names(cars)

for(i in 1:length(variable))
{
  x<-variable[i]
  y<-cars[,x] #all the values present in a given column
  
  lists[i]<-class(y)
  maxs[i]<-ifelse((class(y)=="integer" | class(y)=="numeric"),max(y,na.rm=TRUE),0)
  mins[i]<-ifelse((class(y)=="integer" | class(y)=="numeric"),min(y,na.rm=TRUE),0)
  average[i]<-as.integer(ifelse((class(y)=="integer" | class(y)=="numeric"),mean(y,na.rm=TRUE),0))
  sd[i]<-ifelse((class(y)=="integer" | class(y)=="numeric"),sd(y,na.rm=TRUE),0)
  u[i]<-ifelse(class(y)=="factor" ,unique(y),0)
  print(i)
}

lists
maxs
mins
average
u
sd

#missing value
missing_count<-colSums(is.na(cars))

final_summary<-data.frame(variable=names(cars),data_type=lists,min=mins,maxs=maxs,average=average,
                          sd=sd,unique=u,missing=missing_count)
final_summary

