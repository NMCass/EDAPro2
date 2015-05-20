#sets working directory, therefore files must be located here
setwd("~/")
SCC<-readRDS(file="~/exdata-data-NEI_data/Source_Classification_Code.rds")
NEI<-readRDS(file="~/exdata-data-NEI_data/summarySCC_PM25.rds")
#select all rows from SCC dataframe that correspond to some sort of coal combustion
coal<-SCC[grep("Coal", SCC$EI.Sector),]
#subset NEI dataframe where SCC values correspond to coal combustion SCC values
sst<-NEI[NEI$SCC %in% coal$SCC,]
#sum the total emission per year
clem<-tapply(sst$Emissions, sst$year, sum)
# Open png device
png(filename="plot4.png", width=480, height=480, units="px")
#plot the data as line
plot(y=clem, x=unique(sst$year), type="l", xlab="year", ylab="Coal Emissions")
#close png device
dev.off()