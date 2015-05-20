#sets working directory, therefore files must be located here
setwd("~/")
SCC<-readRDS(file="~/exdata-data-NEI_data/Source_Classification_Code.rds")
NEI<-readRDS(file="~/exdata-data-NEI_data/summarySCC_PM25.rds")
#load ggplot2 package and dplyr package
library(ggplot2)
library(dplyr)
#subset only Baltimore data
btm<-filter(NEI, fips=="24510")
#take total emissions for each type per year
btm2<-aggregate(btm$Emissions, list(type=btm$type, year=btm$year), sum)
# Open png device
png(filename="plot3.png", width=480, height=480, units="px")
#create plot
g<-ggplot(btm2, aes(x=year, y=x, group=type, colour=type))
g+geom_line()+geom_point()+theme_bw()+labs(x="year", y="Total Emissions")
#close png device
dev.off()