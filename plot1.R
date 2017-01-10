
#read in the data file
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#get a subset of the data for only the dates, 2/1/2007 and 2/2/2007
hpc.full_subset <- subset(hpc, Date == '1/2/2007' | Date == '2/2/2007')


#drop levels with no data 
hpc.full_subset.dl <- droplevels(hpc.full_subset)

#convert Global_active_power variable to numeric
hpc.full_subset.dl$Global_active_power <- as.numeric(levels(hpc.full_subset.dl$Global_active_power))[hpc.full_subset.dl$Global_active_power]


#create histogram
hist(hpc.full_subset.dl$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", border = "black", col = "red")


#save to png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

