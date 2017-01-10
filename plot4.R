#read in the data file
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#get a subset of the data for only the dates, 2/1/2007 and 2/2/2007
hpc.full_subset <- subset(hpc, Date == '1/2/2007' | Date == '2/2/2007')

str(hpc.full_subset)

#concatenate Date adn Time, and convert to POSIXlt
hpc.full_subset$date_time <- strptime(paste(hpc.full_subset$Date,hpc.full_subset$Time, sep=" " ),'%e/%m/%Y %H:%M:%S')

#convert Date variable to date_time variable, formatted as Date type
hpc.full_subset$Date <- as.Date(hpc.full_subset$date_time)

#drop levels with no data 
hpc.full_subset.dl <- droplevels(hpc.full_subset)

#add new variable with day of the week from date_time variable
hpc.full_subset.dl$weekday <- weekdays(hpc.full_subset.dl$date_time)

#convert Sub_metering_1 and Sub_metering_2 variables to numeric
hpc.full_subset.dl$Global_active_power <- as.numeric(levels(hpc.full_subset.dl$Global_active_power))[hpc.full_subset.dl$Global_active_power]

hpc.full_subset.dl$Global_reactive_power <- as.numeric(levels(hpc.full_subset.dl$Global_reactive_power))[hpc.full_subset.dl$Global_reactive_power]

hpc.full_subset.dl$Voltage <- as.numeric(levels(hpc.full_subset.dl$Voltage))[hpc.full_subset.dl$Voltage]

hpc.full_subset.dl$Sub_metering_1 <- as.numeric(levels(hpc.full_subset.dl$Sub_metering_1))[hpc.full_subset.dl$Sub_metering_1]

hpc.full_subset.dl$Sub_metering_2 <- as.numeric(levels(hpc.full_subset.dl$Sub_metering_2))[hpc.full_subset.dl$Sub_metering_2]

str(hpc.full_subset.dl)


#create plot4 (4 graphs)

par(mfrow = c(2, 2))
par(mar = c(4,4,2,2))
with(hpc.full_subset.dl, {
  plot(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Global_active_power, type="n", xlab = "", ylab = "Global Active Power")
  lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Global_active_power)
  plot(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Voltage, type="n", xlab = "datetime", ylab = "Voltage")
  lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Voltage)
  plot(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
  lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Sub_metering_1 )
  lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Sub_metering_2,  col="red")
  lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Sub_metering_3, col="blue")
  legend("topright", bty = "n", lty = "solid", col=c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
  plot(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
  lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Global_reactive_power)
})


#save to png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

