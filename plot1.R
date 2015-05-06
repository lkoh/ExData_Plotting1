## ==============================================================
## This script contstructs plot1  and saves it as file plot1.png,
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

## Make the histogram for Plot 1
hist(dat1$Global_active_power, main="Global Active Power", col="red", 
     xlab="Global Active Power (kilowatts)",cex.axis=1, cex.lab=1, cex.main=1, yaxt="n")
axis(2, yaxp = c(0,1200,5), cex.axis=1)          ## sets the y axis tick marks

## make png file
dev.copy(png, file ="plot1.png", width=480, height=480, units="px")
dev.off() ## Don't forget to close the PNG device!

