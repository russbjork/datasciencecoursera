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
rawdata <- read.csv(temp, nrows=250000)
## rawdata <- read.csv(temp)

##
## Explore the raw data identify any potential issues
##
head(rawdata)
str(rawdata)
summary(rawdata)
unique(rawdata$STATE)[1:52]
states <- c("AL","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA",
            "ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND", 
            "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY")

##
## Transform the data limited to continental US only - NEW DATASET
## Data filtered/grouped and summarized for Fatalities and Injuries
##
datafatal <- rawdata %>% select(STATE,EVTYPE,FATALITIES,INJURIES) %>% filter(STATE %in% states) %>%
    select(EVTYPE,FATALITIES,INJURIES) %>% group_by(EVTYPE) %>% 
    summarize(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES)) %>%
    arrange(desc(FATALITIES),desc(INJURIES)) %>% filter(FATALITIES!=0) %>% top_n(10)
summary(datafatal)
str(datafatal)
datafatal

datainjury <- rawdata %>% select(STATE,EVTYPE,FATALITIES,INJURIES) %>% filter(STATE %in% states) %>%
  select(EVTYPE,FATALITIES,INJURIES) %>% group_by(EVTYPE) %>% 
  summarize(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES)) %>%
  arrange(desc(INJURIES),desc(FATALITIES)) %>% filter(INJURIES!=0) %>% top_n(10)
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
          labs(title="Top 10 Fatalities by Event Type",x="Event Type",y="Fatatilies") +
          theme(plot.title.position='plot',plot.title=element_text(hjust=0.5)) +
          theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))
  
# Basic scatter plot of injuries by event type
iplot <- ggplot(datainjury, aes(reorder(EVTYPE, -INJURIES), y=INJURIES)) +
          geom_line(color="blue",group=1) +
          geom_point(color="black",size=2) +
          geom_text(aes(label=INJURIES),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
          labs(title="Top 10 Injuries by Event Type",x="Event Type",y="Injuries") +
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
  select(EVTYPE,PROPDMG,PROPDMGEXP) %>% group_by(EVTYPE) %>% 
  summarize(PROPDMG=sum(PROPDMG)) %>%
  arrange(desc(PROPDMG)) %>% filter(PROPDMG!=0) %>% top_n(10)
summary(dataprop)
str(dataprop)
dataprop

datacrop <- rawdata %>% select(STATE,EVTYPE,CROPDMG,CROPDMGEXP) %>% filter(STATE %in% states) %>%
  select(EVTYPE,CROPDMG,CROPDMGEXP) %>% group_by(EVTYPE) %>% 
  summarize(CROPDMG=sum(CROPDMG)) %>%
  arrange(desc(CROPDMG)) %>% filter(CROPDMG!=0) %>% top_n(10)
summary(datacrop)
str(datacrop)
datacrop

##
## Graph and plot the transformed data US continental event data
##
## Basic scatter plot of property damage by event type
pplot <- ggplot(dataprop, aes(reorder(EVTYPE, -PROPDMG), y=PROPDMG)) +
  geom_line(color="blue",group=1) +
  geom_point(color="black",size=2) +
  geom_text(aes(label=PROPDMG),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
  labs(title="Top 10 Property Damage by Event Type",x="Event Type",y="Property Damage USD") +
  theme(plot.title.position='plot',plot.title=element_text(hjust=0.5)) +
  theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Basic scatter plot of crop damage by event type
cplot <- ggplot(datacrop, aes(reorder(EVTYPE, -CROPDMG), y=CROPDMG)) +
  geom_line(color="blue",group=1) +
  geom_point(color="black",size=2) +
  geom_text(aes(label=CROPDMG),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
  labs(title="Top 10 Crop Damage by Event Type",x="Event Type",y="Crop Damage USD") +
  theme(plot.title.position='plot',plot.title=element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Combine the two seperate plots
ggarrange(pplot, cplot, ncol = 1, nrow = 2)

# Output the plot to file
dev.copy(png, file="plot2.png", height=640, width=720)
dev.off()
