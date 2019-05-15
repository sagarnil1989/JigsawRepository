## ANOVA ##

#One way ANOVA#

#Create a data set with three groups
mpg = c(34,35,34.3,35.5,35.8,35.3,36.5,36.4,37,37.6,33.3,34,34.7,33,34.9)
brand = factor(c("A","A","A","A","A","B","B","B","B","B","C","C","C","C","C"))
mileage = data.frame(mpg = mpg,brand = brand)
mileage

anova<-aov(mpg~brand,data = mileage )

summary(anova)

#Two way ANOVA#
setwd("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Stats")
tw<-read.csv("TW.csv")
res<-aov(Satisfaction~Format+Subject+Format:Subject,data=tw)
summary(res)

#Chi-Square test of goodness of fit#
#Create a data set with observations and expectations#
Obs=c(195,165,47,15,30,35,8,5)
pct=c(0.374,0.357,0.085,0.034,0.066,0.063,0.015,0.006)
dat<-data.frame(Blood_type=c("O+","A+","B+","AB+","O-","A-","B-","AB-"),pct,Obs,Exp=sum(Obs)*pct)

chisq.test(x = dat$Obs,p=dat$pct)

#Chi-Square test of factor independence#
Monthly<- c(91,150,109)
Occasionally<-c(90,200,198)
Never<-c(51,155,172)
dat<-data.frame(Monthly,Occasionally,Never)
row.names(dat)<-c("under 45","45-59","60 and over")
dat

chisq.test(dat)
