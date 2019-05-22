#Class 04 - Importing & Exporting Data in R
#Topic 7 - Working with web data

###File Details
##Information: Customer data with information related to first name, last name, city, county, state and zip
##File Details: customersJSON.txt, customers.xml
##URL Links: 1) http://www.gutenberg.org/cache/epub/2701/pg2701.txt
##           2) http://www.bio.ic.ac.uk/research/mjcraw/therbook/data/taxon.txt      

###Using file and url options to directly read data from URL links
##Using readLines function
data<-url("http://www.gutenberg.org/cache/epub/2701/pg2701.txt")
webText<-readLines(data,n=50)

##Using read.table function
plants<-read.table("http://www.bio.ic.ac.uk/research/mjcraw/therbook/data/taxon.txt",
                      sep="",
                      header=T,
                      stringsAsFactors=F)

dim(plants)
str(plants)
head(plants)

##Downloading files from URL links
download.file("http://www.bio.ic.ac.uk/research/mjcraw/therbook/data/taxon.txt",
              "sample.txt")

###Handling json files
##Loading jsonlite library
library(jsonlite)

##Reading json files to R
customers<-fromJSON("customersJSON.txt")
class(customers)
head(customers)

##Writing json files from R
output<-toJSON(customers, pretty=TRUE)
cat(output)
writeLines(output,"customers_json.txt")

###Handling xml files
##Loading XML library
library(XML)

##XML file
xmlfile<-"customers.xml"

##Use the xmlTreePares-function to parse xml file
xmlparse<-xmlTreeParse(xmlfile)
class(xmlparse)

##Use the xmlRoot-function to access the top node
xmltop<-xmlRoot(xmlparse)

##Extract the XML-values from the document, use xmlSApply
customers<-xmlSApply(xmltop, function(x) xmlSApply(x, xmlValue))
customers

##Get the data in a data-frame
customers_df<-data.frame(t(customers),row.names=NULL)
head(customers_df)

###Web scraping using RCurl and XML packages
###Website: https://stat.ethz.ch/pipermail/r-help/2009-January/date.html
###The site consists of January 2009 R help Archives sorted by date
###The goal is to extract Authors info and identify the biggest contributor

##Loading library
library(RCurl)
library(XML)

##Getting the html content from URL
htmlContent<-getURL("https://stat.ethz.ch/pipermail/r-help/2009-January/date.html",
                    ssl.verifypeer = FALSE)

##Parsing the html tree structure from html content
htmlParsed<-htmlTreeParse(htmlContent,
                          useInternal = TRUE)
authorsOuput<-unlist(xpathApply(htmlParsed, '//i', xmlValue))
authorsOuput<-gsub('\\n',' ',authorsOuput)

##Converting the output to data frame object
output<-data.frame(table(authorsOuput))
output<-output[order(-output$Freq),]
head(output)
