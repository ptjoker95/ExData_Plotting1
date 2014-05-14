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
SM <- subset( EPC, ( EPC$DateNTime >= startDate & EPC$DateNTime < endDate & EPC$Global_active_power != '?') ,select=c(DateNTime, Sub_metering_1,Sub_metering_2,Sub_metering_3) )
SM$Sub_metering_1 <- as.numeric( SM$Sub_metering_1 )
SM$Sub_metering_2 <- as.numeric( SM$Sub_metering_2 )
SM$Sub_metering_3 <- as.numeric( SM$Sub_metering_3 )

#make png file
png(file="plot3.png", bg="white", width=480, height=480)
plot( SM$DateNTime, SM$Sub_metering_1, type="l", ylab="Energy sub metering", col="black", xlab="" )
lines( SM$DateNTime, SM$Sub_metering_2, col="red")
lines( SM$DateNTime, SM$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()
