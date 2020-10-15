# Plot1

# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot 
# showing the total PM2.5 emission from all sources for each of 
# the years 1999, 2002, 2005, and 2008.

library("data.table")

# Read the data
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Histogram - Total Emission
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

# "Clean" the data
totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

# Construct the plot and save it to a PNG file
png(filename = 'plot1.png')

barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()