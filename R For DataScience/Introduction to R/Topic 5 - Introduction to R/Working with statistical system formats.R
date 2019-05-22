#Class 04 - Importing & Exporting Data in R
#Topic 5 - Working with statistical system formats

###File Details
##Filenames: SAS.xpt, SPSS.sav, Stata.dta
##Filetype: SAS (.xpt), SPSS (.sav) and Stata (.dta) file formats

###Using foreign package
##Reading from statistical data formats
##Loading Library
library(foreign)

##Reading SAS files
SAS<-read.xport("SAS.xpt")

##Reading SPPS files
SPSS<-read.spss("SPSS.sav",
                to.data.frame = TRUE)

##Reading Stata files
Stata<-read.dta("Stata.dta")

##Writing R data frames to statistical data formats
##Writing to Stata files
write.dta(Stata,"fromR.dta")


##Writing to SAS, SPSS files            
write.foreign(SPSS,
              codefile="code.sps",
              datafile="data.raw",
              package="SPSS")

write.foreign(SAS[[1]],
              codefile="code.sas",
              datafile="data.raw",
              package="SAS")

