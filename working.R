## 
## Reproducible Data - Project 2
##
library(dplyr)
library(ggplot2)
library(ggpubr)
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
rawdata <- read.csv(temp, nrows=500000)
head(rawdata)

##
## Explore the raw data identify any potential issues
##
str(rawdata)
summary(rawdata)
unique(rawdata$STATE)[1:52]
states <- c("AL","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA",
            "ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND", 
            "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY")

##
## Transform the data limited to continental US only - NEW DATASET
## Data filtered/grouped summary and calculations
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
# Basic scatter plot of fatalities by event type
fplot <- ggplot(datafatal, aes(reorder(EVTYPE, -FATALITIES), y=FATALITIES)) +
          geom_line(color="blue",group=1) +
          geom_point(color="black",size=2) +
          geom_text(aes(label=FATALITIES),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
          labs(title="Top 10 Fatalities per Event Type",x="Event Type",y="Fatatilies") +
          theme(plot.title.position='plot',plot.title=element_text(hjust=0.5)) +
          theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))
  
# Basic scatter plot of injuries by event type
iplot <- ggplot(datainjury, aes(reorder(EVTYPE, -INJURIES), y=INJURIES)) +
          geom_line(color="blue",group=1) +
          geom_point(color="black",size=2) +
          geom_text(aes(label=INJURIES),vjust=0,hjust=0,size=3,nudge_x=0.2,nudge_y=0.2) +
          labs(title="Top 10 Injuries per Event Type",x="Event Type",y="Injuries") +
          theme(plot.title.position='plot',plot.title=element_text(hjust = 0.5)) +
          theme(axis.text.x = element_text(angle=20,vjust=1,hjust=1))

# Combine the two seperate plots
ggarrange(fplot, iplot, ncol = 1, nrow = 2)

# Output the plot to file
dev.copy(png, file="plot1.png", height=640, width=720)
dev.off()
##
## Transform the data limited to continental US only - NEW DATASET
## Data filtered/grouped summary and calculations
##


##
## Graph and plot the transformed data
##
# Basic series plot of fatalities and injuries by event type
#ggplot(intvlsteps, aes(x=interval, y=steps)) +
#  geom_line(color = "blue") +
#  labs(title = "Time Series of Steps per Interval", x = "Interval", y = "Steps") +
#  theme(plot.title.position = 'plot',plot.title = element_text(hjust = 0.5))

