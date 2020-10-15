# Plot5

#How have emissions from motor vehicle sources changed from 1999–2008
# in Baltimore City?

library("data.table")
library("ggplot2")

# Read the data
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# "Clean" the data
# NEI vs vehicles
vehiclesSCC <- SCC[grepl("vehicle", SCC.Level.Two, ignore.case = TRUE), SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Baltimore vs vehicles
baltimoreVehiclesNEI <- vehiclesNEI[fips == "24510",]

# Construct the plot and save it to a PNG file
png("plot5.png")

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill = "#FF9999" ,width = 0.75) +
  labs(x= "year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()