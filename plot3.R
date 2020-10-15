# Plot3

# Of the four types of sources indicated by the \color{red}{\verb|type|}type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? Which
# have seen increases in emissions from 1999–2008? Use the ggplot2 plotting
# system to make a plot answer this question.


library("data.table")

# install.packages("ggplot2")
library("ggplot2")


# Read the data.
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Subset NEI - Baltimore
baltimoreNEI <- NEI[fips=="24510",]

# Construct the plot and save it to a PNG file
png(filename = "plot3.png")

ggplot(baltimoreNEI,aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  theme_bw() + guides(fill = FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()