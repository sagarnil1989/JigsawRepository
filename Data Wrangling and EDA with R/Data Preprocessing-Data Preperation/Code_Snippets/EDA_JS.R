# To access the quality of data -  GIGO 
# EDA - it helps in identifying right modeliing technique for underlying data

# Good Quality data - ?
# Without missing values 
# Without outlier 
# Without Incomplete value ( Data should be complete)
# Without Incorrect Value ( Data should be correct)
# Without Invalid Values
# Without Duplicate Values 
# Cover entire population - check for data sufficiency
                   # Compare summary statistics with Data Dictionary 
  # Marketing_Camp_Type -> DD says 5 value - Email, Call, Direct, Instore, Text_Based 
  # During EDA, you find out there are only 4 values - Email, Call, Direct, Instore
  # During EDA, you find out there are 6      values - Email, Call, Direct, Instore, Text_Based, Inperson

# What is Invalid Value & Incorrect 
 # Age - 215 years ( Invalid value)
 # My age is 25 but in system 35 - Incorrect value

# What is outlier ?
  # Time spent by different people in the shopping mall - 20, 18, 130, 12, 15 
  # Age of the person                                   - 32, 35,  35, 28, 21 
  # WithKids/WithoutKids                                -  N,  N,   Y, N,  N 

# Missing Values ? "NA"
#  Treatment of missing values ? - "AFTER TREATMENT YOU SHOULD HAVE SIZEABLE AMOUNT OF DATA FOR MODELLING"
#                                - "DEFAULT IS IGNORE, If problem - Impute 
#  1) Impute - 
#  2) Ignore - (delete the row having missing value)
#  3) Delete the col having missing values - 

#   I have 10000 records & 20% of records are missing - Impute
#   I have    1   million records & 20% is missing    - Ignore 

# How to check the effectiveness of treatment 
# When to check mean, median and mode ?
# If data is not skewed (not having extreme values) - Mean 
# else check median 
# MODE is only for categories 

# Task in EDA
# Transformation of variable 
# Separate numeric & non-numeric features 
# Univariate Analysis , Bivariate analysis, Multivariate Analysis 
# Derived variables 
# Dummy variables 
# Cross tabulation 
# Correlation 

# How to create section in R 

# CTRL + SHIFT + R

# EDA  --------------------------------------------------------------------
salaries <- read.csv("C:\\JS\\Data Exploration and Preparation\\Salaries.csv")
head(salaries)
str(salaries)

# How to convert lgID column into a character col 
salaries_1 <- salaries
salaries_1$teamID <- as.character(salaries_1$teamID)
str(salaries_1)

salaries_2 <- read.csv("C:\\JS\\Data Exploration and Preparation\\Salaries.csv", stringsAsFactors = FALSE)
str(salaries_2)

# Unique values in a col - teamID 
unique(salaries$teamID)
unique(salaries$lgID)  # AL, NL
table(salaries$lgID)

table(salaries$lgID) / nrow(salaries)

table(salaries$teamID)
prop.table(table(salaries$teamID))  # Percentage for every category 

table(salaries$teamID) / nrow(salaries)


table(salaries$teamID)
sort(table(salaries$teamID))
sort(table(salaries$teamID), decreasing = TRUE)

plot(sort(table(salaries$teamID)))
barplot(sort(table(salaries$teamID)))
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds")
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
                  col = "red")
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))

# You want to change the background color ?
par(bg="yellow")
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))

par(bg="white")
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))

# To see more than one plot in the plotting area 
par(mfrow = c(2,2)) # Two rows and Two cols 
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))
barplot(sort(table(salaries$teamID)), main = "Count by Team", xlab = "Team Name", ylab = "Number of recoreds", 
        col = c("red", "green", "blue"))


par(mfrow = c(1,1))

# Bivariate Analysis 
table(salaries$teamID, salaries$lgID)
table(salaries$teamID, salaries$yearID)

# I want to find out count of player having salary less than avg 
View(salaries)

mean(salaries$salary)
salaries_3 <- subset(salaries, salaries$salary < mean(salaries$salary))
nrow(salaries_3)

# Missing Value treatement 
data("airquality")
head(airquality)
is.na(airquality$Ozone)
which(is.na(airquality$Ozone))
length(which(is.na(airquality$Ozone)))

# Count of missing values in each col 
colSums(is.na(airquality))

# Treatment of missing values 
# Ignore all of the missing records 

airquality_1 <- na.omit(airquality)
colSums(is.na(airquality_1))

# How many records have been dropped 
nrow(airquality) - nrow(airquality_1)

# I want to replace the missing values with the avg value of that col
View(airquality)

mean(airquality$Ozone)

mean(airquality$Ozone, na.rm = TRUE)
 
which(is.na(airquality$Ozone))

airquality$Ozone [ 5] <- mean(airquality$Ozone, na.rm = TRUE)
airquality$Ozone [ 5]
airquality$Ozone [ 10] <- mean(airquality$Ozone, na.rm = TRUE)
airquality$Ozone [ 10]
airquality$Ozone [ which(is.na(airquality$Ozone))] <- mean(airquality$Ozone, na.rm = TRUE)
colSums(is.na(airquality))

airquality$Solar.R [ which(is.na(airquality$Solar.R))] <- mean(airquality$Solar.R, na.rm = TRUE)

colSums(is.na(airquality))

# Interested to know about advanced method 
# MICE - MICE 
# na.roughfix - RandomForest 

# Amount_Spent_on_CC - Build a Linear model to predict the missing values 

View(airquality)

# Concept of Dummy variale 
View(iris)
iris_1 <- iris
unique(iris$Species)
iris$Species_Setsoa     <- ifelse(iris$Species == "setosa", 1, 0)
iris$Species_versicolor <- ifelse(iris$Species == "versicolor", 1, 0)
iris$Species_virginica  <- ifelse(iris$Species == "virginica", 1, 0)

library(dummies)
temp1 <- dummy(iris$Species)
View(temp1)

View(iris_1)
iris_1 <- cbind(iris_1, temp1)

iris_1 <- cbind(iris_1, dummy(iris_1$Species))

# Outliers
# Boxplot, Fivenumber summary, IQR 
head(mtcars)
summary(mtcars$mpg)
boxplot(mtcars$mpg)

mtcars_1 <- edit(mtcars)
boxplot(mtcars_1$mpg)

IQR(mtcars_1$mpg)  # Interquartile range 
# Diff between 3rd quartile & 1st quatile 

summary(mtcars_1$mpg)
# If any obs >= 3rd quartile + 1.5*IQR
23.20 + (1.5*8) # 35.2
# If any obs <= 1st quartile - 1.5*IQR
15.20 - (1.5*8) # 3.2 


b1 <- boxplot(mtcars_1$mpg)
names(b1)
b1$out

View(mtcars_1)
mtcars_1$mpg(b1$out)
mtcars_1$mpg == b1$out

# R in Action 

# Correlation 
# Relationship between two variables 
# 1 - Meaningful only for numeric data
# 2 - Types 
    # Positive - If var1 is increasing Var2 is also increasing 
    #            If var1 is decreasing Var2 is also decreasing 
    #            Ex - Sales vs Revenue, Age Vs Income, Exp Vs Salary 
    # Negative - If var1 is increasing Var2 is also Decrease
    #            If var1 is decreasing Var2 is also Increase 
    #            Ex - price incrase and demand decrease, Amount_of_pollution Vs Property price
    #                 crime_Rate Vs Property Price
# 3 - Its a value between -1 to +1 

cor(mtcars$mpg, mtcars$disp)
plot(mtcars$mpg, mtcars$disp)

cor(mtcars)  # Correlation Matrix

library(corrgram)
corrgram(mtcars)

# Red means Negative correlation 
# Blue means positive correaltion 

# Darker the color stronger the correlation


