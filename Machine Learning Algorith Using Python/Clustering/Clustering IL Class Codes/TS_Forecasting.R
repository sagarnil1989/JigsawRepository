library(forecast)
library(tseries)

data("AirPassengers")
class(AirPassengers)
start(AirPassengers)
end(AirPassengers)
frequency(AirPassengers)
cycle(AirPassengers)
AirPassengers


#When the class is not time series
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
class(births)
birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
class(birthstimeseries)
birthstimeseries

#Checking missing values
sum(is.na(AirPassengers))

#Summary
summary(AirPassengers)

#Stationarity
plot(AirPassengers)
abline(reg=lm(AirPassengers~time(AirPassengers)))

#Boxplot to see if any seasonality is there
boxplot(AirPassengers~cycle(AirPassengers))

#Decomposing time series data into trend, seasonality and random

ts_dcomp<- decompose(AirPassengers)
plot(ts_dcomp)
plot(ts_dcomp$trend)
plot(ts_dcomp$seasonal)
plot(ts_dcomp$random)

ts_mod<- AirPassengers- ts_dcomp$seasonal
plot(ts_mod)

ts_mod1<- ts_mod- ts_dcomp$trend
plot(ts_mod1)



#ARIMA model

mod1<- auto.arima(AirPassengers, trace = T)
mod1
#(2,1,1)

plot.ts(mod1$residuals)


#ACF & PACF
acf(mod1$residuals, lag.max = 20)
acf(mod1$residuals, lag.max = 20, plot = F)

pacf(AirPassengers, lag.max = 20)
pacf(AirPassengers, lag.max = 20, plot = F)


#Use the model to forecast for next two years with 95% level of significance
forecast<- forecast(mod1,level= c(95), h = 2*12)
plot(forecast)
forecast


