# read data from txt file
EPC <- read.table("household_power_consumption.txt", header=TRUE, sep=';', colClasses=c(rep("character",9)))

# date and time value convert to Date format
EPC["DateNTime"] <- as.POSIXct( strptime( paste(EPC$Date, EPC$Time), format="%d/%m/%Y %H:%M:%S"))
# remove duplicate data
EPC["Date"] <- NULL
EPC["Time"] <- NULL

# make date as start and end date as POSIXct
startDate <- as.POSIXct( strptime("2007-2-1", format="%Y-%m-%d"))
endDate <- as.POSIXct( strptime("2007-2-3", format="%Y-%m-%d"))
# extract from 2007/2/1 to 2007/2/2
GAP <- subset( EPC, ( EPC$DateNTime >= startDate & EPC$DateNTime < endDate & EPC$Global_active_power != '?'), select = Global_active_power  )
# GAP is Global Active Power
GAP <- as.numeric(GAP[,1])

#png device
png(file="plot1.png", bg="white", width=480, height=480)
#make histogram plot
hist(GAP, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
#png device off
dev.off()
