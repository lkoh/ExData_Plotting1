## ==============================================================
## This script contstructs plot3  and saves it as file plot3.png,
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

## make plot3 (line graph of each Sub_metering variable vs. datetime)
with(dat3, plot(datetime, Sub_metering_1, ldw=0.5, xlab="", ylab="Energy sub metering", cex.axis=1, cex.lab=1, type="n"))   ## creates the plot
with(dat3, points(datetime, Sub_metering_1, col="black", type="l"))
with(dat3, points(datetime, Sub_metering_2, col="red", type="l"))
with(dat3, points(datetime, Sub_metering_3, col="blue", type="l"))
## add legend
legend("topright", lty=1, y.intersp=0.6, cex=0.65, col=c("black", "red", "blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## make png file
dev.copy(png, file ="plot3.png", width=480, height=480, units="px")
dev.off() 

