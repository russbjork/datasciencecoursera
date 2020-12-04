##
## Read in the data files for the Exploratory Data Analysis - Project 2
##
NEI <- readRDS("Data/summarySCC_PM25.rds")
## SCC <- readRDS("Data/Source_Classification_Code.rds")
##
## Summarize the data by year, calculate total and mean emissions
##
sub0 <- subset(NEI, fips=="24510")
## sub0
sub1 <- aggregate(sub0[,4], list(sub0$year), mean)
colnames(sub1) <- c("Year", "MeanEms")
## sub1
sub2 <- aggregate(sub0[,4], list(sub0$year), sum)
colnames(sub2) <- c("Year", "TotEms")
## sub2
mrg<-merge(sub1,sub2,by="Year")
## mrg
##
## Plot the data for the yearly emissions
##
plot(mrg$Year,mrg$TotEms/1000,type="b",main="Total Emissions - Baltimore City",xlab="Year",ylab="Emissions PM2.5 (Thousands of pounds)",lwd=5,pch=19,col="blue")
##
## Saving Plot 2 to file
##
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()