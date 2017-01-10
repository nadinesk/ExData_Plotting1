#read in the data file
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#get a subset of the data for only the dates, 2/1/2007 and 2/2/2007
hpc.full_subset <- subset(hpc, Date == '1/2/2007' | Date == '2/2/2007')

#concatenate Date adn Time, and convert to POSIXlt
hpc.full_subset$date_time <- strptime(paste(hpc.full_subset$Date,hpc.full_subset$Time, sep=" " ),'%e/%m/%Y %H:%M:%S')

#convert Date variable to date_time variable, formatted as Date type
hpc.full_subset$Date <- as.Date(hpc.full_subset$date_time)

#drop levels with no data 
hpc.full_subset.dl <- droplevels(hpc.full_subset)

#add new variable with day of the week from date_time variable
hpc.full_subset.dl$weekday <- weekdays(hpc.full_subset.dl$date_time)

#convert Global_active_power variable to numeric
hpc.full_subset.dl$Global_active_power <- as.numeric(levels(hpc.full_subset.dl$Global_active_power))[hpc.full_subset.dl$Global_active_power]


#create line chart
plot(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(hpc.full_subset.dl$date_time, hpc.full_subset.dl$Global_active_power, lwd=1.5)

#save to png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

