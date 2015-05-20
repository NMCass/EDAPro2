#sets working directory, therefore files must be located here
setwd("~/")
SCC<-readRDS(file="~/exdata-data-NEI_data/Source_Classification_Code.rds")
NEI<-readRDS(file="~/exdata-data-NEI_data/summarySCC_PM25.rds")
#load package dplyr
library(dplyr)
#subset only Baltimore data
btm<-filter(NEI, fips=="24510")
#sum the total emission per year
smbtm<-tapply(btm$Emissions, btm$year, sum)
#create year vector
yr<-c(1999, 2002,2005,2008)
# Open png device
png(filename="plot2.png", width=480, height=480, units="px")
#plot the data as line
plot(yr,smbtm, xlab="year", ylab="total emissions in Baltimore", type='l')
#close png device
dev.off()