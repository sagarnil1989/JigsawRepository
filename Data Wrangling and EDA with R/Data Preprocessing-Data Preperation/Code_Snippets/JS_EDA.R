# Good Quality Data - 
# Without Outliers 
# Without Missing Value 
# Without incomplete Values
# Without Incorrect Values 
# Without Invalid values
# Without Duplicate values 
# Covering entire population - Check for data sufficiency 
  # Marketing_Campagin - DD says 5 values - Email, Call, Direct, Instore, Text_based
  # During EDA, you find out there are only 4 values - Email, Call, Direct, Instore
  # During EDA, you find out there are only 6 values - Email, Call, Direct, Instore, Text_based, InPerson

# Query_Log

# Data Dictionary 

# Incorrect & Invalid 
# Age - 215 years (Invalid value)
# Age - 35 (actual age is 25) - Incorrect 

# Invalid is like outliers ?
# Outliers 
  # Time spent by different persons in a shopping mall - 20, 18, 130, 12, 25
  # Age of the person                                  - 32, 25, 32 , 26, 30
  # Person - With Kids/Without Kids                    -  N,  N,  Y, N, N 

# Treatment of missing values - AFTER TREATMENT OF MISSING VALUES YOU SHOULD HAVE GOOD AMOUNT OF DATA FOR MODELLING.
# Impute - MISSING VALUES IMPUTATION TAKES TIME AND MONEY 
# Ignore 
# Drop the entire col 

# Task in EDA - Never ending ex
# 1 - Separate Numeric & Non-numeric features 
# 2 - For Numeric cols - summary, scatter plot, outlier test, box plot 
# 3 - For non-numeric cols - Frequency distribution, convert them into quantitaive 
# 4 - You will explore combination of cols - 
#          Between numeric cols - Scatter plot , xy plot , correlation matrix
#          Between numeric & non-numeric -> Box-plot ( Cities Vs salary), GroupBy 
#          Between non-numeric cols -> cross-tabulation (pivot table)
# 5 - Dervied Variables 
# 6 - Dummy Variables 

salaries <- read.csv("C:\\JS\\Data Exploration and Preparation\\Salaries.csv")
str(salaries)

salaries$lgID_1 <- as.character(salaries$lgID)
str(salaries)

unique(salaries$lgID)
table(salaries$lgID)
table(salaries$lgID) / nrow(salaries)

unique(salaries$teamID)  # It will give you the unique(distinct) values in the col
length(unique(salaries$teamID))  # Count of unique values 
table(salaries$teamID)

sort(table(salaries$teamID))  # ascending order 
sort(table(salaries$teamID), decreasing = TRUE)

plot(sort(table(salaries$teamID)))
barplot(sort(table(salaries$teamID)), main = "Count By team", xlab = "Team Name", ylab = "Count")
barplot(sort(table(salaries$teamID)), main = "Count By team", xlab = "Team Name", ylab = "Count", col = "red")

# Rcolorbrewer 

# Bivariate Analysis - on two categorical cols - LgID & TeamID 
table(salaries$lgID, salaries$yearID) # cross-tabulation 

# Number of players having salary less than avg 
mean(salaries$salary)
salaries_less_than_mean <- subset(salaries, salaries$salary <= 1864357)
nrow(salaries_less_than_mean)

summary(salaries$salary)
fivenum(salaries$salary)

# Missing Value treatment 
data("airquality")
head(airquality)
is.na(airquality$Ozone)

# At what position we have missing value 
which(is.na(airquality$Ozone))
length(which(is.na(airquality$Ozone)))
length(which(is.na(airquality$Solar.R)))

# Count of missing values in every col ?
colSums(is.na(airquality))
colSums(is.na(airquality)) / nrow(airquality)

# Treatement of missing value 
# 1 - I want to create a new DF in which there shouldn't be any missing records

airquality_1 <- na.omit(airquality)  # It will drop a record if the record is having atleast one missing value 
colSums(is.na(airquality_1))

# How many records have been dropped ?
nrow(airquality) - nrow(airquality_1)

# 2 - I want to impute missing values with avg value of that col 
mean(airquality$Ozone)
mean(airquality$Ozone, na.rm = TRUE)
mean(na.omit(airquality$Ozone))

which(is.na(airquality$Ozone))

airquality$Ozone[c(26,27,32)] <- mean(na.omit(airquality$Ozone))

airquality$Ozone[which(is.na(airquality$Ozone))] <- mean(na.omit(airquality$Ozone))

colSums(is.na(airquality))
airquality$Solar.R[which(is.na(airquality$Solar.R))] <- mean(na.omit(airquality$Solar.R))
colSums(is.na(airquality))

# How to treat missing value when it is in a non-numeric col ?
# RandomForest - na.roughfix 
# MICE         - MICE 
??na.roughfix
??MICE

# DF1$COL1 <- na.roughfix(DF1$COL1)

# Outliers # Mechanical way to find outliers 
boxplot(mtcars$mpg)
mtcars1 <- edit(mtcars)
View(mtcars1)

boxplot(mtcars1$mpg)
summary(mtcars1$mpg)

# IQR -> Diff between 3rd Qu - 1st Qu
23.20 - 15.20

IQR(mtcars1$mpg)

# Any obs >=  3rd quartile + 1.5*IQR
23.20 + (1.5*8)
# Any obs <=  1st quartile - 1.5*IQR
15.20 - (1.5*8)

b1 <- boxplot(mtcars1$mpg)
b1$out

# Correlation - Meaningful only for numeric data 
# Strength of relationship between two variable 

# Positive - If var1 is increasing var2 will also increase 
#            If var1 is decreasing var2 will also decrease
#            saleries with experience, age vs maturity, slaes vs offers, Height & weight, Sales Vs Profit

# Negative - If var1 is increasing var2 will also decrease 
#            If var1 is decreasing var2 will also increase
#            price and demand, crime_rate & prop price, Age and memory, Pollution Vs housing price 

# Correlation is a number between -1 to +1. 

head(mtcars)
cor(mtcars$mpg, mtcars$disp)

plot(mtcars$mpg, mtcars$disp)

cor(mtcars) # Only numeric cols 
# Correlation matrix 

# Visualization of correlation 
library(corrgram)
corrgram(mtcars)

# Red - Negative correlation 
# Blue - Positive correlation 

# Darker the color stronger the correlation 
# Weaker the color weaker the correaltion 


# More the 0.80 (-0.8) strong correlation 
# (0 - 0.2) --> Weak correlation


































