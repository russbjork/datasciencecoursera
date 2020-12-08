## 
## Reproducible Data - Project 2
##
library(dplyr)
library(ggplot2)
library(knitr)
opts_chunk$set(echo = TRUE)

##
## Connect to web site and download data
##
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
temp <- tempfile()
download.file(url, temp)

##
## Read in raw data from URL
##
rawdata <- read.csv(temp)
head(rawdata)

##
## Explore the raw data
##
str(rawdata)
summary(rawdata)
unique(rawdata$STATE)[1:52]
states <- c("AL","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA",
            "ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND", 
            "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY")

##
## Transform the data convert date attribute to valid Date - NEW DATASET
##
data <- rawdata %>% select(STATE,EVTYPE,FATALITIES,INJURIES) %>% filter(STATE %in% states) %>%
    select(EVTYPE,FATALITIES,INJURIES) %>% group_by(EVTYPE) %>% 
    summarize(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES)) %>%
    arrange(desc(FATALITIES),desc(INJURIES)) %>% filter(FATALITIES!=0)
summary(data)
str(data)
data

##
## Data filtered/grouped summary and calculations
##


##
## Graph and plot the transformed data
##
# Basic histogram of summarized steps by day
#ggplot(dailysteps, aes(x=steps)) + 
#  geom_histogram(binwidth=1000, color="blue", fill="white") +
#  labs(title = "Histogram of Steps per day", x = "Steps", y = "Frequency") +
#  theme(plot.title.position = 'plot',plot.title = element_text(hjust = 0.5))

# Basic time series of mean steps per day
#ggplot(intvlsteps, aes(x=interval, y=steps)) +
#  geom_line(color = "blue") +
#  labs(title = "Time Series of Steps per Interval", x = "Interval", y = "Steps") +
#  theme(plot.title.position = 'plot',plot.title = element_text(hjust = 0.5))

