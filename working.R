## 
## Reproducible Data - Project 2
##

## 
## Setup the environment and load library files
##
library(dplyr)
library(ggplot2)
library(ggpubr)
library(knitr)
opts_chunk$set(echo = TRUE)

##
## Connect to web site and download the raw data
##
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
temp <- tempfile()
download.file(url, temp)

##
## Read in raw data from URL
##
## Loading a smaller subset for development, comment out for final build
## rawdata <- read.csv(temp, nrows=250000)
rawdata <- read.csv(temp)

##
## Explore the raw data identify any potential issues
##
head(rawdata)
str(rawdata)
summary(rawdata)
unique(rawdata$STATE)
unique(rawdata$FATALITIES)
unique(rawdata$INJURIES)
sort(unique(rawdata$PROPDMG),decreasing = TRUE)
unique(rawdata$PROPDMGEXP) #Many values outside the specification, those will all be set to factor = 1
sort(unique(rawdata$CROPDMG),decreasing = TRUE)
unique(rawdata$CROPDMGEXP) #Many values outside the specification, those will all be set to factor = 1
## Create the Continenal United States Vector
states <- c("AL","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA",
            "ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND", 
            "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY")

##
## Transform the data limited to continental US only - NEW DATASET
## Data filtered/grouped and summarized for Fatalities and Injuries
##
datafatal <- rawdata %>% select(STATE,EVTYPE,FATALITIES,INJURIES) %>% filter(STATE %in% states) %>%
    select(EVTYPE,FATALITIES) %>% group_by(EVTYPE) %>% 
    summarize(FATALITIES=sum(FATALITIES)) %>%
    arrange(desc(FATALITIES)) %>% filter(FATALITIES!=0) %>% top_n(10)
summary(datafatal)
str(datafatal)
datafatal

datainjury <- rawdata %>% select(STATE,EVTYPE,FATALITIES,INJURIES) %>% filter(STATE %in% states) %>%
    select(EVTYPE,INJURIES) %>% group_by(EVTYPE) %>% 
    summarize(INJURIES=sum(INJURIES)) %>%
    arrange(desc(INJURIES)) %>% filter(INJURIES!=0) %>% top_n(10)
summary(datainjury)
str(datainjury)
datainjury

##
## Graph and plot the transformed data US continental event data
##
## Basic scatter plot of fatalities by event type
fplot <- ggplot(datafatal, aes(reorder(EVTYPE, -FATALITIES), y=FATALITIES)) +
    geom_line(color="blue",group=1) +
    geom_point(color="black",size=2) +
    geom_text(aes(label=FATALITIES),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
    labs(title="Fatalities by Event Type - (Top 10)",x="Event Type",y="Fatatilies") +
    theme(plot.title.position='plot',plot.title=element_text(hjust=0.5)) +
    theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Basic scatter plot of injuries by event type
iplot <- ggplot(datainjury, aes(reorder(EVTYPE, -INJURIES), y=INJURIES)) +
    geom_line(color="blue",group=1) +
    geom_point(color="black",size=2) +
    geom_text(aes(label=INJURIES),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
    labs(title="Injuries by Event Type - (Top 10)",x="Event Type",y="Injuries") +
    theme(plot.title.position='plot',plot.title=element_text(hjust = 0.5)) +
    theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Combine the two seperate plots
ggarrange(fplot, iplot, ncol = 1, nrow = 2)

# Output the plot to file
dev.copy(png, file="plot1.png", height=640, width=720)
dev.off()

##
## Transform the data limited to continental US only - NEW DATASET
## Data filtered/grouped and summarized for Property and Crop damage
##
dataprop <- rawdata %>% select(STATE,EVTYPE,PROPDMG,PROPDMGEXP) %>% filter(STATE %in% states) %>%
    mutate(MULTI = if_else(PROPDMGEXP == "", 1, if_else(PROPDMGEXP == "K", 1000, 
    if_else(PROPDMGEXP == "M", 1000000, if_else(PROPDMGEXP == "B", 1000000000, as.numeric(NA)))))) %>%
    mutate(PROPDMG2 = PROPDMG * MULTI) %>% select(STATE,EVTYPE,PROPDMG2) %>% group_by(EVTYPE) %>% 
    summarize(PROPDMG2=sum(PROPDMG2)/1000000) %>%
    arrange(desc(PROPDMG2)) %>% filter(PROPDMG2!=0) %>% top_n(10)
dataprop$PROPDMG2 <- round(dataprop$PROPDMG2,digits=2)
summary(dataprop)
str(dataprop)
dataprop

datacrop <- rawdata %>% select(STATE,EVTYPE,CROPDMG,CROPDMGEXP) %>% filter(STATE %in% states) %>%
    mutate(MULTI = if_else(CROPDMGEXP == "", 1, if_else(CROPDMGEXP == "K", 1000, 
    if_else(CROPDMGEXP == "M", 1000000, if_else(CROPDMGEXP == "B", 1000000000, as.numeric(NA)))))) %>%
    mutate(CROPDMG2 = CROPDMG * MULTI) %>% select(STATE,EVTYPE,CROPDMG2) %>% group_by(EVTYPE) %>% 
    summarize(CROPDMG2=sum(CROPDMG2)/1000000) %>%
    arrange(desc(CROPDMG2)) %>% filter(CROPDMG2!=0) %>% top_n(10)
datacrop$CROPDMG2 <- round(datacrop$CROPDMG2,digits=2)
summary(datacrop)
str(datacrop)
datacrop


##
## Graph and plot the transformed data US continental event data
##
## Basic scatter plot of property damage by event type
pplot <- ggplot(dataprop, aes(reorder(EVTYPE, -PROPDMG2), y=PROPDMG2)) +
    geom_line(color="blue",group=1) +
    geom_point(color="black",size=2) +
    geom_text(aes(label=PROPDMG2),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
    labs(title="Financial Property Damage by Event Type - (Top 10)",x="Event Type",y="Property Damage $Millions") +
    theme(plot.title.position='plot',plot.title=element_text(hjust=0.5)) +
    theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Basic scatter plot of crop damage by event type
cplot <- ggplot(datacrop, aes(reorder(EVTYPE, -CROPDMG2), y=CROPDMG2)) +
    geom_line(color="blue",group=1) +
    geom_point(color="black",size=2) +
    geom_text(aes(label=CROPDMG2),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
    labs(title="Financial Crop Damage by Event Type - (Top 10)",x="Event Type",y="Crop Damage $Millions") +
    theme(plot.title.position='plot',plot.title=element_text(hjust = 0.5)) +
    theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Combine the two seperate plots
ggarrange(pplot, cplot, ncol = 1, nrow = 2)

# Output the plot to file
dev.copy(png, file="plot2.png", height=640, width=720)
dev.off()
