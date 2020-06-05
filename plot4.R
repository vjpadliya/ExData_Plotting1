## R script to plot multiple graphs in a 2x2 grid arrangement for a certain 
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
png("plot4.png", height = 480, width = 480)

# Set plot grid layout of 2x2
par(mfcol=c(2,2))

# Plot Graph1 - Global Active Power and DateTime
with(energydata, plot(datetime, Global_active_power, type = "l",
                      xlab = "", ylab = "Global Active Power"))

# Plot Graph2 - Energy sub metering (1,2,3) and DateTime
with(energydata, {plot(datetime, Sub_metering_1, type = "l", 
                       xlab = "", ylab = "Energy sub metering")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Plot Graph3 - Voltage and DateTime
with(energydata, plot(datetime, Voltage, type = "l"))

# Plot Graph4 - Global Reactive Power and DateTime
with(energydata, plot(datetime, Global_reactive_power, type = "l"))

# Close graphics file device
dev.off()



