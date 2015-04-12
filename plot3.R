
library(lubridate)

file_url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

## 1. Download: Checks the existance of the data from UCI Machine Learning Repository on Household Power Consumption.
##               If the data does not exist, downloads it and decompresses it.

if(!file.exists("./household_power_consumption.zip")){
    download.file(file_url, destfile="./household_power_consumption.zip")
    unzip("./household_power_consumption.zip",exdir=".")

}else{ if(!file.exists("./household_power_consumption.txt")){
    unzip("./household_power_consumption.zip",exdir=".")}
}

## Reding-in as Data Frame: "?" are read as NA's 
    house_power <- as.data.frame(read.table('household_power_consumption.txt',header=T, sep=";", na.strings="?", stringsAsFactors=F))
## Merging Date and Time into a single variable
    house_power$DateTime <- paste(house_power$Date,house_power$Time, sep=" ")
## Using Lubridate to convert the Character string into date-time calss (POSIXct)
    house_power$DateTime <- dmy_hms(house_power$DateTime)
## Converting $Date -> as.Date to be used for subsetting
    house_power$Date <- as.Date(house_power$Date, format="%d/%m/%Y")
## SUbsetting to capture only dates 2007-02-01 or 2007-02-02
    house_power <- house_power[ (house_power$Date==as.Date("2007-02-01")) | (house_power$Date==as.Date("2007-02-02")), ]

png(filename = "plot3.png", width=480, height=480)

with (house_power, 
        plot(DateTime, Sub_metering_1,
        type="n",
        ylab= "Energy sub metering",
        xlab=""
      ))

with (house_power,lines(DateTime, Sub_metering_1, col="black"))
with (house_power,lines(DateTime, Sub_metering_2, col="red"))
with (house_power,lines(DateTime, Sub_metering_3, col="blue"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=1, lty = c(1, 1, 1), col=c("black","red","blue"))

dev.off() 
