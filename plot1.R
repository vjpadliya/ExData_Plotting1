## R script to plot Histogram for Global Active Power (in kilowatts) for a certain 
## household energy consumption data set over a period of 2 days : 2007-02-01 to 2007-02-02

# The dataset contains 2,075,259 rows and 9 columns. To reduce memory consumption by dataset
# readin only data corresponding to the required date range.

# Search for rows in date range 1/2/2007 to 2/2/2007
skip<-(grep("^[1-2]/2/2007", readLines("household_power_consumption.txt")))

# Read dataset into dataframe. 
# Read only a subset of data in the required date range. 
energydata<-read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?", 
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"))[(skip[1]-1):(skip[1]+length(skip)-2),]

# PLOT THE REQUIRED GRAPH
# Open Graphics file device png. 
png("plot1.png", height = 480, width = 480)
# Plot histogram with Title and labels
hist(energydata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# Close graphics file device
dev.off()
