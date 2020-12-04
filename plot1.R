##
## Read in the data files for the Exploratory Data Analysis - Project 2
##
NEI <- readRDS("Data/summarySCC_PM25.rds")
## SCC <- readRDS("Data/Source_Classification_Code.rds")
##
## Summarize the data by year, calculate total and mean emissions
##
sub0 <- aggregate(NEI[,4], list(NEI$year), mean)
colnames(sub0) <- c("Year", "MeanEms")
## sub0
sub1 <- aggregate(NEI[,4], list(NEI$year), sum)
colnames(sub1) <- c("Year", "TotEms")
## sub1
mrg<-merge(sub0,sub1,by="Year")
## mrg
##
## Plot the data for the yearly emissions
##
plot(mrg$Year,mrg$TotEms/1000,type="b",main="Total Emissions - United States",xlab="Year",ylab="Emissions PM2.5 (Thousands of Tons)",lwd=5,pch=19,col="blue")
##
## Saving Plot 1 to file
##
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()