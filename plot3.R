library(ggplot2)
library(plyr)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile="exploreProject2",method="curl")
unzip("exploreProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
yearlySumBaltimoreType<-ddply(NEI[which(NEI$fips=="24510"),],.(year,type),summarize,cnt=sum(Emissions))

png("plot3.png")
qplot(year,cnt,data=yearlySumBaltimoreType, color=type,geom="line")
dev.off()