## unzip the file if not done so already
unzip("household_power_consumption.zip",overwrite=FALSE)

## load enough lines to include the specified dates
somedata <- read.table("household_power_consumption.txt", nrows = 80000, sep=";", header=TRUE, na.strings = "?")
## convert the date...necessary?
somedata$Date <- as.Date(somedata$Date,format="%d/%m/%Y")
## subset for the required dates
usedata <- somedata[somedata$Date == "2007-02-01" | somedata$Date == "2007-02-02",]
##usedata <- somedata[somedata$Date == "1/2/2007" | somedata$Date == "2/2/2007",]

library(graphics)
library(grDevices)

usedata$n <- c(1:2880) ##number the rows for axis creation

png(filename = "plot4.png", width = 480, height = 480) #open the device

## PLOT 4
par(mfrow=c(2,2)) ##set rows

plot(usedata$n, usedata$Global_active_power, type="l", main="", ylab = "Global Active Power", xlab = "", xaxt="n")
axis(side=1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))

plot(usedata$n, usedata$Voltage, type="l", main="", ylab = "Voltage", xlab="datetime", xaxt="n")
axis(side=1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))

with(usedata, plot(n, Sub_metering_1, type="l", main="", ylab = "Energy sub metering", xlab = "", xaxt="n"))
with(usedata, lines(n,Sub_metering_2, col="red"))
with(usedata, lines(n,Sub_metering_3, col="blue"))
axis(side=1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
legend("topright", lwd=1, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

plot(usedata$n, usedata$Global_reactive_power, type="l", main="", ylab = "Global_reactive_power", xlab="datetime", xaxt="n")
axis(side=1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))

dev.off() #close the graphics device