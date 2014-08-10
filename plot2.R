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

png(filename = "plot2.png", width = 480, height = 480) #open the device

usedata$n <- c(1:2880) ##number the rows for axis creation
par(mfrow=c(1,1)) ##clear formatting

## PLOT 2
plot(usedata$n, usedata$Global_active_power, type="l", main="", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt="n")
axis(side=1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))

dev.off() #close the graphics device