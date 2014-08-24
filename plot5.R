library(ggplot2)
library(plyr)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile="exploreProject2",method="curl")
unzip("exploreProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 5 
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#unique(SCC$EI.Sector)
#[21] Mobile - On-Road Gasoline Light Duty Vehicles      Mobile - On-Road Gasoline Heavy Duty Vehicles     
#[23] Mobile - On-Road Diesel Light Duty Vehicles        Mobile - On-Road Diesel Heavy Duty Vehicles       
NEISCC<-merge(NEI,SCC, by="SCC")
yearlyMotorBaltimore<-ddply(NEISCC[which(NEISCC$fips=="24510" & 
                                             (NEISCC$EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
                                                  NEISCC$EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
                                                  NEISCC$EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | 
                                                  NEISCC$EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")),],
                            .(year),
                            summarize,cnt=sum(Emissions))

png("plot5.png")
qplot(year,cnt,data=yearlyMotorBaltimore,geom="line")
dev.off()