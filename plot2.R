## ==============================================================
## This script contstructs plot2  and saves it as file plot2.png,
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

## make plot2 (line graph of Global Active Power vs. datetime)
with(dat3, plot(datetime, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)",cex.axis=1, cex.lab=1, type="l"))

## make png file
dev.copy(png, file ="plot2.png", width=480, height=480, units="px")
dev.off() 

