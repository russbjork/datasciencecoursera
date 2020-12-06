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
SCC <- readRDS("Data/Source_Classification_Code.rds")
##
## Summarize the data by fuel type Coal
##
sub0coal <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector),  ];
sub0coal.list <- unique(sub0coal$SCC);
sub1coal <- subset(NEI, SCC %in% sub0coal.list);
sub1coal <- sub1coal %>% group_by(type, year) %>% summarize(Annual.Total = sum(Emissions))
sub1coal.total <- sub1coal %>% group_by(year) %>% summarize(Annual.Total = sum(Annual.Total)) %>% mutate(type = "TOTAL");
sub1coal <- sub1coal %>% select(Annual.Total, type, year);
sub1coal <- bind_rows(sub1coal, sub1coal.total);
# Order the factor levels to they plot in the correct order
sub1coal$type <- factor(sub1coal$type, levels = c("TOTAL", "ON-ROAD", "NON-ROAD", "POINT", "NONPOINT")); 
##
## Plot the data by year for the coal specific emissions
##
ggplot(sub1coal, aes(x = factor(year), y = Annual.Total/1000, fill = type)) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ type, labeller = label_wrap_gen(width = 25, multi_line = TRUE)) +
  xlab("Year") +
  ylab(expression("Emissions PM2.5 (Thousands of Tons)")) + 
  ggtitle(expression(atop("Total Emissions - United States", paste("Coal Combustion Related Sources")))) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  # Center the plot title
  theme(plot.margin = unit(c(1,1,1,1), "cm")) + 
  # Adjust plot margins
  scale_fill_brewer(palette = "Set1") +
# Dark2, Accent or Paired are nice palettes for future reference
  guides(fill = FALSE)
##
## Saving Plot 4 to file
##
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
