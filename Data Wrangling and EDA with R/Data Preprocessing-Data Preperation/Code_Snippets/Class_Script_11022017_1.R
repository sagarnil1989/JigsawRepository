# Compare data fields with what you have in Data Dict 
# For any issue, create a issue-log, share with customer, get clarification 
# STMT_TYPE
# A11,A21,A31,A41 -- In dict 
# A11,A31,A41 -- Actual Data

# Quantitative Data 
# Qualitattve Data
# Dates ....

# Prepare data dictionary 
# Query log 

# Missing Values -- NA 
        # Treatment of missing values ?  Impute/replace Values, Ignore Values, Drop column
        # Sit-1 = you have 5% record missing in a column 
                   # Total 1000 records --> Impute/replace values 
                   # Total 1M records  ---> Ignore missing records
        # Sit-2 =  you have 90% record missing in a column 
                   # Drop my column 
# Outliers Values -- some values which are way different than normal values
                   # Time_Spent_In_Super_Market (Mins) = 20, 15, 180, 12, 22 
                   # Age_of_person                     = 31, 24, 35,  27, 32
                   # With_or_without_infants           = N,   N,  Y,  N, N 
# Duplicate columns 
# Duplicate Rows 
# Derived variables (Intermediate variable) = age from dob, Dummy Variable, 
#                                          Sales => Sales_in_last_week, Sales_in_last_month_ Sales_in_last_Q....
# Univariate Analysis - Explore one col at a time -- Summary statistics, Scatter plot, Histograms ...
# Bivariate Analysis - Two variables together -- boxplot, cross tabulation, correlation 
# Multivariate Analysis - More then 2 variables together .. 
# Transform variables -- Qualitative variables into Qunatitaive variables 

# if categorical has lot of levels. how to transform?
# dummy(DF$Cols)

# Data Analysis & Pre-processing 
setwd("C:\\JS")
getwd()
retail <- read.csv("retail_sales.csv")

# How to take a look at the datasets 
head(retail)
tail(retail)
str(retail)

# To ensure char are char during dataload 
retail1 <- read.csv("retail_sales.csv", stringsAsFactors = FALSE)
str(retail1)

# To convert a col into character data type
retail$Supplier <- as.character(retail$Supplier)
str(retail)

colnames(retail)

class(retail)
# City --> Major_City 
class(colnames(retail))

colnames(retail)[1:5]
colnames(retail)[2] <- "Major_City"
colnames(retail)

toupper(colnames(retail))
tolower(colnames(retail))

retail2 <- retail[  , -5 ]
View(retail2)

unique(retail$Item_Category)
length(unique(retail$Item_Category))

reatail[Item_category == "Art & Arch",]

retail[retail$Item_Category == "Art & Architecture", ]

# Subset function 
retail3 <- subset(retail, retail$Item_Category == "Art & Architecture")
View(retail3)

retail4 <- subset(retail, retail$Item_Category == "Art & Architecture" & retail$Unit_Price >= 100)
View(retail4)

unique(retail$Item_Category)
length(unique(retail$Item_Category))

# Univariate Analysis
table(retail$Item_Category)
sort(table(retail$Item_Category))
sort(table(retail$Item_Category), decreasing = TRUE)
plot(table(retail$Item_Category))
barplot(table(retail$Item_Category))
barplot(sort(table(retail$Item_Category), decreasing = TRUE), col = c("green", "yellow", "red", "pink"),
                             xlab = "Categories", ylab = "Count", main = "MY FIRST PLOT")
barplot(sort(table(retail$Item_Category), decreasing = TRUE), col = "red",
        xlab = "Categories", ylab = "Count", main = "MY FIRST PLOT")

# Bivariate Analysis 
table(retail$Item_Category, retail$Month)

# Create new columns in the dataframe 
retail$profit <- retail$Revenue - retail$Cost
View(retail)

# WHICH IS TO LOCATE 
# I WANT TO LOCATE A COLNAME 
# WHERE ?

# getcolumnnumber(retail,"Revenue")
colnames(retail) == "Revenue"
which(colnames(retail) == "Revenue") # 69th (1:69,81,70:80)

# I want to drop profit col 
rm(retail4)
retail$profit <- NULL 

paste("Juhi", "Sanchit", "Anil", sep = "__")

paste("Juhi", "_", "Sanchit", "_", "Anil")
paste0("Juhi", "_", "Sanchit", "_", "Anil")  # To get rid from space

# paste(col1, "_", col2, "_", col3)
retail$Supplier_Month <- paste(retail$Supplier, retail$Month, sep = "-")
View(retail)

# How to split a string based upon start and end condition 
x1 <- c("Sachin Tendulkar", "Barak Obama", "Narendra Modi")
x1
substr(x1, -4)
substr(x1, start=-1, stop=-4)
substr(x1, start=length(x1)-4, stop = length(x1))
length(x1)
nchar(x1)  # <----------
substr(x1, start =nchar(x1)-3,stop = nchar(x1)) # To extract the last four 

substr(x1, start = 2, stop = 5)
# position 21 to 37 - Timestamp 
# In a log file last 5 characters represent the application name 

# Substitute command 
# gsub & sub commands 

x2 <- "You are good"
x2
x3 <- sub("good", "great", x2)
x3

x2 <- c("you are good we are good", "we are good all are good")
x2
x3 <- gsub("good", "great", x2)
x3

x2 <- c("you are good we are good", "we are good all are GOOD")
x2
x3 <- gsub("good", "great", x2, ignore.case = TRUE)
x3

retail$Item_Category_Mod <- gsub("Art", "Science", retail$Item_Category)
View(retail)

# How to split a string based upon a separator 
x4 <- "SPlit the sentence into the words"
x4
x5 <- strsplit(x4, " ")
x5
# This command is utterly useful in "Text Analytics"
# result of strsplit command is always a "list data structure"
class(x5)
# to convert list into a vector 
unlist(x5)
class(unlist(x5))

# Missing Values 
# load the dataset which contains missing values 
data("airquality")
head(airquality)
mean(airquality$Ozone)  # Because of missing values in the col 
min(airquality$Ozone) 
class(airquality$Ozone)

mean(airquality$Ozone, na.rm = TRUE) 
mean(na.omit(airquality$Ozone))

# Ozone col has got missing values ??
# I am doing Data Auditing on Ozone column 
is.na(airquality$Ozone)
which(is.na(airquality$Ozone))
length(which(is.na(airquality$Ozone)))
length(which(is.na(airquality$Ozone)))/ nrow(airquality)
length(which(is.na(airquality$Solar.R)))/ nrow(airquality)
length(which(is.na(airquality$Wind)))/ nrow(airquality)

colSums(is.na(airquality))
colSums(is.na(airquality)) /nrow(airquality)

# How to create a new DF by dropping the records having missing items 
airquality1 <- na.omit(airquality)
View(airquality1)
colSums(is.na(airquality1))
nrow(airquality) - nrow(airquality1)

# I want to impute missing values 
which(is.na(airquality$Ozone))
mean(airquality$Ozone, na.rm = TRUE) 
airquality$Ozone[5] <- mean(airquality$Ozone, na.rm = TRUE) 
airquality$Ozone[5] 

airquality$Ozone[10] <- mean(airquality$Ozone, na.rm = TRUE) 
airquality$Ozone[10]

airquality$Ozone[ which(is.na(airquality$Ozone))] <- mean(airquality$Ozone, na.rm = TRUE) 
airquality$Ozone 
colSums(is.na(airquality))

airquality$Solar.R[ which(is.na(airquality$Solar.R))] <- mean(airquality$Solar.R, na.rm = TRUE) 
colSums(is.na(airquality))

# MICE PACKAGE AND FUNCTION 
# na.roughfix funciton inside randomforest package 

# First - during file load specify that "-" is NA 
# na.strings = c("-", " ", "bla", " ---", )
# Second - gsub to replace - with NA

# Outlier 
mtcars
summary(mtcars)

# Boxplot on the col
boxplot(mtcars$mpg)
summary(mtcars$mpg)
fivenum(mtcars$mpg)
IQR(mtcars$mpg)

# Let me induce an outlier 
mtcars1 <- edit(mtcars)
boxplot(mtcars1$mpg)
fivenum(mtcars1$mpg)
IQR(mtcars1$mpg) # Inter Quartile Range 

# Formula for boxplot 
# 3rd quartile + 1.5*IQR -- More than 
# 1st quartile - 1.5*IQR -- less than 

23.60 + (1.5*8)  # 35.6
15.20 - (1.5*8)  # 3.2


b1 <- boxplot(mtcars1$mpg)
b1$out  # Value 1 & 56 are outliers 
# Which command to check the indexes 


