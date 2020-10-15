# Plot6 

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California
# (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which 
# city has seen greater changes over time in motor vehicle emissions?

library("data.table")
library("ggplot2")

# Read the data
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# "Clean" the data
# NEI vs vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# vehicles vs city name.
vehiclesBaltimoreNEI <- vehiclesNEI[fips == "24510",]
vehiclesBaltimoreNEI[, city := c("Baltimore City")]

vehiclesLANEI <- vehiclesNEI[fips == "06037",]
vehiclesLANEI[, city := c("Los Angeles")]
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# Construct the plot and save it to a PNG file
png("plot6.png")

ggplot(bothNEI, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(aes(fill = year),stat = "identity") +
  facet_grid(scales = "free", space = "free", .~city) +
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()