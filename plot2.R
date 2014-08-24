library(ggplot2)
library(plyr)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile="exploreProject2",method="curl")
unzip("exploreProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
yearlySumBaltimore<-ddply(NEI[which(NEI$fips=="24510"),],.(year),summarize,cnt=sum(Emissions))

png("plot2.png")
plot(yearlySumBaltimore$year,yearlySumBaltimore$cnt, type="l")
dev.off()