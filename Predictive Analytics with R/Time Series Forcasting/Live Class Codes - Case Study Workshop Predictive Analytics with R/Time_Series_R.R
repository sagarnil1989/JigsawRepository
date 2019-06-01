#############################################################################
#Time Series with R 
###################################################


#Load the data 
data("AirPassengers")
Air <- AirPassengers
class(Air)

#Check the Start of the Time Series 
start(Air)

# Check the end of the time series 

end(Air)

#Check the Summary of the data 

summary(Air)
boxplot(Air)

#Explore the data with plotting 

plot(Air)
abline(reg = lm(Air ~time(Air)))

#Print the cycle of the year 
cycle(Air)

boxplot(AirPassengers~cycle(AirPassengers))

#Check if the data is stationary 
install.packages("tseries")
library(tseries)

#plot the trend of air passanger 
plot(Air)

#Apply Lof func to make sure the variance are equal 

plot(log(Air))

#With LOG the variance is equal but we still see mean difference and in order to contorl mean we apply differrention (Diff)

plot(diff(log(Air)))

#AR I MA 
#P  D  Q (Values will come from the auto corelation function acf graph)
# p is the number of autoregressive terms,
# d is the number of nonseasonal differences needed for stationarity, and.Typically in maths its Differentiation  
# q is the number of lagged forecast errors in the prediction equation.
acf(Air)

acf(diff(log(Air))) #Determine value of Q
#Q = 1
 
pacf(diff(log(Air))) #Determine value of P
#P is 0

#adf.test(diff(log(Air)), alternative="stationary", k=0)

#Predict 10 years Passangers
#c(p,d,q)

(fit <- arima(log(AirPassengers), c(0, 1, 1),seasonal = list(order = c(0, 1, 1), period = 12)))

pred <- predict(fit, n.ahead = 10*12)
ts.plot(AirPassengers,2.718^pred$pred, log = "y", lty = c(1,3))


###Assignment is run the below code and come back with your inferences and how accurate it the model 

#Test the model 

datawide <- ts(Air,frequency = 12,start = c(1949,1),end = c(1959,12))

fit <- arima(log(datawide),c(0,1,1),seasonal = list(order=c(0,1,1),period =12))

pred = predict(fit,n.ahead = 10*12)
pred1 <- 2.718 ^ pred$pred

data1 <- head(pred1,12)

predict_1960 <- round(data1,digits=0)

original_1960<- tail(Air,12)

