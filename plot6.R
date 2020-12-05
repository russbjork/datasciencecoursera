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
## Summarize the data by motor vehicle source and location
##
sub0vehicles <- SCC[grep("Mobile.*Vehicles", SCC$EI.Sector),  ]; # Pattern match mobile vehicles in SCC description
sub0vehicles.list <- unique(sub0vehicles$SCC); # Create motor vehicle lookup list by SCC
sub1vehicles <- subset(NEI, SCC %in% sub0vehicles.list); # Filter for motor vehicle sources
sub1vehicles <- sub1vehicles %>% filter(fips == "24510"| fips == "06037"); # Filter for Baltimore City or Los Angeles County
sub1vehicles$fips[sub1vehicles$fips == "24510"] <- "Baltimore";
sub1vehicles$fips[sub1vehicles$fips == "06037"] <- "Los Angeles";
sub1vehicles <- merge(x = sub1vehicles, y = sub0vehicles[, c("SCC", "SCC.Level.Two")], by = "SCC"); # Join in descriptive data on SCC codes
sub1vehicles <- sub1vehicles %>% group_by(fips, year, SCC.Level.Two) %>% summarize(Annual.Total = sum(Emissions));
sub1vehicles.total <- sub1vehicles %>% group_by(fips, year) %>% summarize(Annual.Total = sum(Annual.Total)) %>% mutate(SCC.Level.Two = "Total");
sub1vehicles <- bind_rows(sub1vehicles, sub1vehicles.total);
sub1vehicles$SCC.Level.Two <- factor(sub1vehicles$SCC.Level.Two, levels = c("Total", "Highway Vehicles - Diesel", "Highway Vehicles - Gasoline"))
##
## Plot the data by year for the vehicle and location specific emissions
##
ggplot(sub1vehicles, aes(x = factor(year), y = Annual.Total, fill = SCC.Level.Two)) +
  geom_bar(stat = "identity") +
  facet_grid(fips ~ SCC.Level.Two, labeller = label_wrap_gen(width = 25, multi_line = TRUE)) + 
  xlab("Year") +
  ylab(expression("Emissions PM2.5 (Total Tons)")) + 
  ggtitle(expression(atop("Total Emissions from Motor Vehicle Sources", paste("Baltimore City & Los Angeles County")))) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  # Center the plot title
  theme(plot.margin = unit(c(1,1,1,1), "cm")) + 
  # Adjust plot margins
  scale_fill_brewer(palette = "Set1") +
  # Dark2, Accent or Paired are nice palettes for future referenc
  guides(fill = FALSE)
##
## Saving Plot 6 to file
##
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()