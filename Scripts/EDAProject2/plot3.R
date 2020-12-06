##
## Load library files for the Exploratory Data Analysis - Project 2
##
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)
##
## Read in the data files for the Exploratory Data Analysis - Project 2
##
NEI <- readRDS("Data/summarySCC_PM25.rds")
## SCC <- readRDS("Data/Source_Classification_Code.rds")
##
## Summarize the data by the Baltimore City area
##
sub0 <- NEI %>% filter(fips == "24510") %>% group_by(type, year) %>% summarize(Annual.Total = sum(Emissions));
## sub0
# Re-order factor levels so they plot in the order specified
sub0$type <- factor(sub0$type, levels = c("ON-ROAD", "NON-ROAD", "POINT", "NONPOINT"))
## sub0
##
## Plot the data for the yearly emissions
##
ggplot(sub0, aes(x = factor(year), y = Annual.Total, fill = type)) + 
  geom_bar(stat = "identity") + 
  facet_grid(. ~ type) + 
  xlab("Year") + 
  ylab("Emissions PM2.5 (Total Tons)") + 
  ggtitle("             Total Emissions by Source Type - Baltimore City") +
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  scale_y_continuous(labels = comma) +
  guides(fill = FALSE)
##
## Saving Plot 3 to file
##
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
