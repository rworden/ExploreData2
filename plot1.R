library(ggplot2)
library(plyr)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile="exploreProject2",method="curl")
unzip("exploreProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
yearlySum<-ddply(NEI,.(year),summarize,cnt=sum(Emissions))

png("plot1.png")
plot(yearlySum$year,yearlySum$cnt, type="l")
dev.off()