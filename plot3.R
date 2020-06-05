## R script to plot Energy Sub Metering (1, 2, 3) for a certain 
## household energy consumption dataset over a period of 2 days : 2007-02-01 to 2007-02-02

# The dataset contains 2,075,259 rows and 9 columns. To reduce memory consumption by dataset
# readin only data corresponding to the required date range.

# Search for rows in date range 1/2/2007 to 2/2/2007
skip<-(grep("^[1-2]/2/2007", readLines("household_power_consumption.txt")))

# Read dataset into dataframe. 
# Read only a subset of data in the required date range. 
energydata<-read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?", 
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"))[(skip[1]-1):(skip[1]+length(skip)-2),]

# Add new variable of Date/Time class to dateframe using Date and Time variables
energydata$datetime<-strptime(paste(energydata$Date, energydata$Time), "%d/%m/%Y %H:%M:%S")

# PLOT THE REQUIRED GRAPH
# Open Graphics file device png. 
png("plot3.png", height = 480, width = 480)

# Plot line graphs over required date range.
# 1st sub metering_1
plot(energydata$datetime, energydata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

# Add line graph for sub metering_2
lines(energydata$datetime, energydata$Sub_metering_2, col = "red")

# Add line graph for sub metering_3
lines(energydata$datetime, energydata$Sub_metering_3, col = "blue")

# Add legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close graphics file device
dev.off()
