##Load specific data
library(dplyr)
library(readr)   
ag<-read_csv("Data/getdata_data_ss06hid.csv",col_types=cols_only(RT="c",SERIALNO ="n",ACR="n",AGS="n"))
head(agLog)
str(agLog)
agLogic<-filter(ag,ACR==3 & AGS==6)
agLogic<-ag$ACR==3 & ag$AGS==6
##
##
##Load an image file
install.packages("jpeg")
install.packages("magick")
library(jpeg)
library(magick)
image_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
pic <- image_read(image_url)
print(pic)
imgurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
imgpath = 'Data/sample.jpg'
download.file(imgurl, imgpath, mode = 'wb')
Q2 <- readJPEG(imgpath, native = TRUE)
quantile(Q2, probs = c(0.3, 0.8))
##
##
##Load and merge two dataframes
library(dplyr)
library(readr)
library(data.table)
ed<-read_csv("Data/getdata_data_EDSTATS_Country.csv")
gdp<-fread("Data/getdata_data_GDP.csv",skip=5,nrows=190,select=c(1,2,4,5),col.names=c("CountryCode","Rank","Economy","Total"))
str(ed)
str(gdp)
merge(ed,gdp,by="CountryCode")
##
##
##Load and split data frame
library(dplyr)
library(readr)   
data<-read_csv("Data/getdata_data_ss06hid.csv")
split(data,"wgtp")
strsplit(names(data),"^wgtp")
##
##
##Load and remove element from data frame
library(dplyr)
library(readr)
library(data.table)
data<-fread("Data/getdata_data_GDP.csv",skip=5,nrows=190,select=c(1,2,4,5),col.names=c("CountryCode","Rank","Economy","Total"))
head(data)
as.numeric(gsub("[,]", "", data$Total)) %>% mean()
data$Economy[grep("^United",data$Economy)]
##
##
##Load stock price data
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes)
amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
