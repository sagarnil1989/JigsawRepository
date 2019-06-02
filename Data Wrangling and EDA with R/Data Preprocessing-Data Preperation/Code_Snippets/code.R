
setwd("D:\\Classes\\Data exploration oct\\")
## Example: Predicting Medical Expenses ----
## Step 2: Exploring and preparing the data ----
insurance <- read.csv("D:\\Classes\\Data exploration oct\\insurance.csv", 
                      stringsAsFactors = TRUE)

str(insurance)

summary(insurance)

#Does the data have any anomolies?
#You take a call based on business domain

#tabulations
table(insurance$sex)
table(insurance$region)
table(insurance$smoker)

table(insurance$sex,insurance$region,insurance$smoker)

#Check for outliers

summary(insurance$age) 
x<-boxplot(insurance$age)
x

#Sepal width
#list of outliers
list<-x$out

#gives the positions in the data where outliers are present
index<-which(insurance$age %in% list)

#---Shortlist the outliers from the dataset and replace
insurance$age[index]

#na.rm=TRUE --> making sure missing values are removed before calculating mean
mean_sw<-mean(insurance$age,na.rm=TRUE)
insurance$age[index]<-mean_sw

#Check for missing values
colSums(is.na(insurance))
insuranceNew<-na.omit(insurance) #omit observations
dim(insurance)
dim(insuranceNew)

insurance$bmi[is.na(insurance$bmi)]<-mean(insurance$bmi,na.rm=TRUE)

#Using mean imputation

M<-c(1,2,NA,3,4,5)
mean(M)
mean(M,na.rm=TRUE)

install.packages("randomForest")
library("randomForest")                   
#Using R package for dealing missing values
insurance$bmi<-na.roughfix(insurance$bmi) 
#Quite useful while working with large datasets##median values

#Data Aggregations

#group by multiple values 
aggregate(charges ~ sex , data=insurance, FUN=mean) #What inference?
aggregate(charges ~ smoker , data=insurance, FUN=mean) #What inference?
aggregate(charges ~ region , data=insurance, FUN=mean) #What inference?

aggregate(charges ~ region + smoker + sex, data=insurance, FUN=mean)#What inference?

#Data Visualisations

# summarize the charges variable
summary(insurance$charges)

# histogram of insurance charges
hist(insurance$charges)

library(ggplot2)
ggplot(insurance,aes(x=charges)) + geom_histogram(aes(fill=as.factor(smoker)),position="dodge")
ggplot(insurance,aes(x=charges)) + geom_histogram(aes(fill=as.factor(smoker)),position="dodge") + facet_grid(region~sex)

#box plots : 
ggplot(insurance,aes(y=charges,x=sex,fill=as.factor(sex)))+ geom_boxplot()
ggplot(insurance,aes(y=charges,x=sex,fill=as.factor(sex)))+ geom_boxplot() +facet_grid(region~smoker)

#scatter plots

#bmi vs charges
p<-ggplot(insurance,aes(x=bmi,y=charges,color=as.factor(sex)))
p+geom_point()
p+geom_point()+facet_grid(.~smoker)
p+geom_point()+facet_grid(smoker~region)

#age vs charges
p<-ggplot(insurance,aes(x=charges,y=age,color=as.factor(sex)))
p+geom_point()
p+geom_point()+facet_grid(.~smoker)
p+geom_point()+facet_grid(smoker~region)

# exploring relationships among features: correlation matrix
cor(insurance[c("age2", "bmi", "children", "charges")])

# visualing relationships among features: scatterplot matrix
pairs(insurance[c("age2", "bmi", "children", "charges")])


#Data Preparation
#Adding new variables

# add a higher-order "age" term
insurance$age2 <- insurance$age^2

# add an indicator for BMI >= 30
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0)

##----------------------------------------Dummy variable creation-----------------------------##
insurance$dummy_r_ne<-ifelse(insurance$region=="northeast",1,0) #Using ifelse
insurance$dummy_r_sw<-ifelse(insurance$region=="southwest",1,0) #Using ifelse


x<-factor(insurance$region) #Using factor and model.matrix combination
dummies<-model.matrix(~x)
class(dummies)

y<-data.frame(dummies)

insurance_new<-cbind(insurance,y)

dim(y)
dim(insurance)
