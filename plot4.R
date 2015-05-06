## ==============================================================
## This script contstructs plot4  and saves it as file plot4.png,
## after reading the data from directory:
## "./data/household_power_consumption.txt" which is
## located in the working directory.

## Because the file is very large, this script only reads the rows
## for the specified dates: Feb 1st 2007 and Feb 2nd 2007.
## ==============================================================

## Note that this script uses the "sqldf" and "dplyr" packages.
library(sqldf)
library(dplyr)

## This section reads the data from the text file for the specified
## dates.
dat1 <- read.csv.sql (file="./data/household_power_consumption.txt", 
        header=TRUE, sep=";", sql = "select * from
        file where Date in ('1/2/2007','2/2/2007') ")

## Change "Date" (which is currently a character) to the "date" class
dat2 <- transform(dat1, Date = as.Date(Date, "%d/%m/%Y"))
## Add column "datetime" which includes: weekday, date, and time
dat3 <- mutate(dat2, datetime = paste(weekdays(dat2$Date), dat2$Date, dat2$Time))
dt <- strptime(dat3$datetime, "%A %Y-%m-%d %H:%M:%S")   ##converts to POSIXlt
dat3$datetime <- dt  ## replaces datetime column with dt

## make plot4 (4 graphs)
par(mfrow=c(2,2), mar=c(4,4,2,2))
with(dat3, {
        plot(datetime, Global_active_power,lwd=0.5, xlab="", ylab="Global Active Power", cex.lab=1, cex.axis=1,type="l")
        plot(datetime, Voltage, ldw=0.5, cex.axis=1, cex.lab=1, type="l")
        plot(datetime, Sub_metering_1,ldw=0.5, xlab="", ylab="Energy sub metering", col="black", cex.lab=1, cex.axis=1, type="l")
        points(datetime, Sub_metering_2, col="red", type="l")
        points(datetime, Sub_metering_3, col="blue", type="l")
        legend(x=quantile(datetime, c(0.3)), y=max(Sub_metering_1)+3, lty=1, col=c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n",cex=0.75, y.intersp=0.5)
        plot(datetime, Global_reactive_power,ldw=0.5, cex.lab=1, cex.axis=1, type="l")

})

## make png file
dev.copy(png, file ="plot4.png", width=480, height=480, units="px")
dev.off() 

