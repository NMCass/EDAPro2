#sets working directory, therefore files must be located here
setwd("~/")
SCC<-readRDS(file="~/exdata-data-NEI_data/Source_Classification_Code.rds")
NEI<-readRDS(file="~/exdata-data-NEI_data/summarySCC_PM25.rds")
#sum the toal emission per year
summed<-tapply(NEI$Emissions, NEI$year, sum)
#create year vector
yr<-c(1999, 2002,2005,2008)
# Open png device
png(filename="plot1.png", width=480, height=480, units="px")
#plot the data as line
plot(yr,summed, xlab="year", ylab="total emissions", type='l')
#close png device
dev.off()