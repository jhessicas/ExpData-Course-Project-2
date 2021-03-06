# Plot2

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

library(data.table)

# Read the data
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# "Clean" the data
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[fips =='24510', lapply(.SD, sum, na.rm = TRUE)
                , .SDcols = c("Emissions")
                , by = year]

# Construct the plot and save it to a PNG file
png(filename = 'plot2.png')

barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()