#sets working directory, therefore files must be located here
setwd("~/")
SCC<-readRDS(file="~/exdata-data-NEI_data/Source_Classification_Code.rds")
NEI<-readRDS(file="~/exdata-data-NEI_data/summarySCC_PM25.rds")
#select all rows from SCC dataframe that correspond to vehivle use
mv<-SCC[grep("Vehicle", SCC$EI.Sector),]
#subset NEI dataframe where SCC values correspond to coal combustion SCC values
submv<-NEI[NEI$SCC %in% mv$SCC,]
#load dplyr package
library(dplyr)
#subset only Baltimore data
btm<-filter(submv, fips=="24510")
#sum the total emission per year
mvbtm<-tapply(btm$Emissions, btm$year, sum)
# Open png device
png(filename="plot5.png", width=480, height=480, units="px")
#plot the data as line
plot(x=unique(btm$year), y=mvbtm, type="l", xlab="year", ylab="Baltimore Vehicle Emissions")
#close png device
dev.off()