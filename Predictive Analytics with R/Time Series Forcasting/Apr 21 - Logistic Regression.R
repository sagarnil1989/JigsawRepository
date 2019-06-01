setwd("D:\\ML\\Decision Tree\\Data")

data=read.csv("credit_history.csv")
head(data)
colSums(is.na(data))
summary(data$years)

data$years[is.na(data$years)]=median(data$years,na.rm=TRUE)
str(data)

#Create dummies
library(dummies)
grade=dummy(data$grade)
own=dummy(data$ownership)

#Binding dummies into the data
data=cbind(data[,-c(3,5)],grade,own)

#Split the data into train and test
set.seed(123)
index<- sort(sample(nrow(data),nrow(data)*0.8))
train<-data[index,]
test<-data[-index,]

#Glm model
model=glm(default~amount+years+income+age+gradeA+gradeB+gradeC+gradeD+gradeE+gradeF+ownershipMORTGAGE+ownershipOWN+ownershipRENT,family="binomial",data=train)
summary(model)

model=glm(default~amount+years+income+age+gradeA+gradeB+gradeC+gradeD+gradeE+gradeF+ownershipMORTGAGE+ownershipOTHER+ownershipRENT,family="binomial",data=train)
summary(model)

model=glm(default~amount+years+income+age+gradeA+gradeB+gradeC+gradeD+gradeE+gradeF,family="binomial",data=train)
summary(model)

model=glm(default~amount+years+income+gradeA+gradeB+gradeC+gradeD+gradeE+gradeF,family="binomial",data=train)
summary(model)

model=glm(default~years+income+gradeA+gradeB+gradeC+gradeD+gradeE+gradeF,family="binomial",data=train)
summary(model)

model=glm(default~years+income+gradeA+gradeB+gradeC+gradeD+gradeG+gradeF,family="binomial",data=train)
summary(model)

model=glm(default~years+income+gradeA+gradeB+gradeC+gradeG+gradeF,family="binomial",data=train)
summary(model)

final=glm(default~income+gradeA+gradeB+gradeC+gradeF,family="binomial",data=train)
summary(final)

#Stepwise Algorithm: Optional
model=glm(default~amount+years+income+age+gradeA+gradeB+gradeC+gradeD+gradeE+gradeF+gradeG+ownershipMORTGAGE+ownershipOWN+ownershipRENT+ownershipOTHER,family="binomial",data=train)
step(model,direction = "both")

#Prediction and accuracy
prob=predict(final,newdata=test,type="response") #response returns predicted probs
head(prob)

library(ROCR)
pred=prediction(prob,test$default)
roc=performance(pred,"tpr","fpr")
#What is tpr=tp/n and fpr=fp/n
plot(roc)
abline(0,1)

#Area under the curve.
auc=performance(pred,"auc")
auc=unlist(slot(auc,"y.values"))
auc
