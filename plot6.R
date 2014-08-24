library(ggplot2)
library(plyr)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile="exploreProject2",method="curl")
unzip("exploreProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



# 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
NEISCC<-merge(NEI,SCC, by="SCC")
yearlyMotorBaltimoreLA<-ddply(NEISCC[which((NEISCC$fips=="24510" | NEISCC$fips=="06037") & 
                                               (NEISCC$EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
                                                    NEISCC$EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
                                                    NEISCC$EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | 
                                                    NEISCC$EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")),],
                              .(year, fips),
                              summarize,cnt=sum(Emissions))

png("plot6.png")
qplot(year,cnt,data=yearlyMotorBaltimoreLA,geom="line")+facet_wrap(~fips)
dev.off()