library(ggplot2)
library(plyr)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile="exploreProject2",method="curl")
unzip("exploreProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 4
# Across the United States, 
# how have emissions from coal combustion-related sources changed from 1999–2008?
NEISCC<-merge(NEI,SCC, by="SCC")
coalVector<-grep("Coal",NEISCC$EI.Sector)
yearlyCoalCountry<-ddply(NEISCC[coalVector,],
                            .(year),
                            summarize,cnt=sum(Emissions))


png("plot4.png")
plot(yearlyCoalCountry$year,yearlyCoalCountry$cnt,type="l")
dev.off()