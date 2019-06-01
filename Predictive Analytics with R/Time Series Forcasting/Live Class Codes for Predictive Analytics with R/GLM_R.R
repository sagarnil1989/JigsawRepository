#Read the data 
#skin Normal thickness in males is 12 mm; in females, 23 mm

library(MASS)
data("Pima.te")
data<-Pima.te
?Pima.te
View(data)
#read.csv("Pima.te.csv")
#data <- read.csv("Pima.te.csv",header = TRUE,sep = ',')
View(data)

View(Titanic)

#Split the data into 70 and 30 

data("Titanic")
install.packages("caTools")
library(caTools)

split <- sample.split(data,SplitRatio = 0.7)
split
#Assign the dataset to train and test 

train <- subset(data,split=="TRUE")
test <- subset(data,split == "FALSE")
nrow(data)
nrow(train)
nrow(test)
model <- glm(type ~ .,train,family = "binomial")
summary(model)

model <- glm(type ~. -age,train,family = "binomial")
summary(model)

model <- glm(type ~.-skin,train,family = "binomial")

#Do -(minus) for all INsignificant variable and note down the residual and AIC values



#Predict the model using test data set 

nrow(test)
predictvalues <- predict(model,test,type = "response")
View(predictvalues)

test$
#Create a Confusion Matrix 

table(ActualValue=test$type,predictvalue=predictvalues>0.5)

#Calculate the accuracy of the model 

(66+20)/(66+11+14+20)

#How to calculate the teshold and this can be done from the ROC curve 
install.packages("ROCR")
library(ROCR)

#To calculate the the teshold first change the Test to train in the predict
#We do this to calculate the treshold before the testing/validation 
predictvalues <- predict(model,train,type = "response") 

#Next run the ROC command 

ROCPRED <- prediction(predictvalues,train$type)
Performancecheck <- performance(ROCPRED,"tpr","fpr")

plot(Performancecheck,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))

#From graph decrease FPR and increase TPR and the best point is 0.3 

#Choose the treshold as 0.3 and re check with test data 

predictvalues <- predict(model,test,type = "response")

#Draw the confusion matrix 

table(ActualValue=test$type,predictvalue=predictvalues>0.5)
table(ActualValue=test$type,predictvalue=predictvalues>0.3)

#Accuracy for model for 0.5 

(66+20)/(66+11+14+20)

#accuracy for model for 0.3 

(57+27)/(57+27+20+7)
