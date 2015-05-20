#sets working directory, therefore files must be located here
setwd("~/")
SCC<-readRDS(file="~/exdata-data-NEI_data/Source_Classification_Code.rds")
NEI<-readRDS(file="~/exdata-data-NEI_data/summarySCC_PM25.rds")
#select all rows from SCC dataframe that correspond to vehicle use
mv<-SCC[grep("Vehicle", SCC$EI.Sector),]
#subset only baltimore and Los Angeles County data
cty<-subset(NEI, fips %in% c("24510","06037"))
#subset NEI dataframe where SCC values correspond to motor vehicle SCC values
submv<-cty[cty$SCC %in% mv$SCC,]
#take a total for each year for each city
sums<-aggregate(submv$Emissions, by=list(year=submv$year, city=submv$fips), sum)
sums$city<-gsub("06037", "Los Angeles County", x=sums$city)
sums$city<-gsub("24510", "Baltimore City", x=sums$city) 
# Open png device
png(filename="plot6.png", width=480, height=480, units="px")
#plot time on x axis and emissions on y axis
library(ggplot2)
q<-ggplot(sums, aes(x=sums$year, y=sums$x, colour=sums$city))
q+geom_point()+geom_smooth(size=.8, method=loess, se=FALSE)+theme_bw()+labs(x="year", y="Motor Car Emissions", colour="city", na.rm=TRUE)
#close png device
dev.off()