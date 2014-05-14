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
GAP <- subset( EPC, ( EPC$DateNTime >= startDate & EPC$DateNTime < endDate & EPC$Global_active_power != '?')  )
GAP["Weekday"] <- format(GAP$DateNTime, "%a")
GAP <- subset( GAP, select=c(Global_active_power, DateNTime, Weekday))
GAP$Global_active_power <- as.numeric(GAP$Global_active_power)

#make png file
png(file="plot2.png", bg="white", width=480, height=480)
#make line plot
plot( GAP$DateNTime , GAP$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)" )
#png device off
dev.off()
