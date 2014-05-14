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
EPC <- subset( EPC, ( EPC$DateNTime >= startDate & EPC$DateNTime < endDate) ,select=c(DateNTime, Global_active_power, Voltage, Sub_metering_1,Sub_metering_2,Sub_metering_3, Global_reactive_power) )

# change to numeric value from character value
EPC$Global_active_power <- as.numeric(EPC$Global_active_power)
EPC$Voltage <- as.numeric(EPC$Voltage)
EPC$Sub_metering_1 <- as.numeric(EPC$Sub_metering_1)
EPC$Sub_metering_2 <- as.numeric(EPC$Sub_metering_2)
EPC$Sub_metering_3 <- as.numeric(EPC$Sub_metering_3)
EPC$Global_reactive_power <- as.numeric(EPC$Global_reactive_power)

#png device
png(file="plot4.png", bg="white", width=480, height=480)
# divide plot window
par( mfrow=c(2,2))

# Global_Active_Power plot
plot( EPC$DateNTime , EPC$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power")

# Voltage plot
plot( EPC$DateNTime , EPC$Voltage, type="l", main="", xlab="datetime", ylab="Voltage")

# Energy sub metering plot
plot( EPC$DateNTime, EPC$Sub_metering_1, type="l", ylab="Energy sub metering", col="black", xlab="" )
lines( EPC$DateNTime, EPC$Sub_metering_2, col="red")
lines( EPC$DateNTime, EPC$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")

# Global_reactive_power plot
plot( EPC$DateNTime, EPC$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
#png device off
dev.off()