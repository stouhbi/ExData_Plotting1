## this function plots the fourth graph in the project and saves it to plot4.png
## dataDestination : give the destination of the dataset
library(data.table)
plot4 <- function(dataDestination){
    # read the data
    colnames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
    data <- read.csv(dataDestination, skip = 66636, na.strings = "?", col.names=colnames, sep=";",nrows = 2880)
    
    ## paste the date and time in one variable
    data$datetime = paste(data$Date,data$Time, sep = " ")
    # convert the new variable into date and time
    data$datetime = strptime(data$datetime, "%d/%m/%Y %H:%M:%S", tz = "UTC")
    ## drop the Date and Time Variables
    drops <- c("Date", "Time")
    data <- data[,!(names(data) %in% drops)]
    
    #create the new png
    
    png(filename  = "plot4.png", bg = "transparent")
    par(mfrow = c(2,2))
    with(data, plot(datetime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))
    with(data, plot(datetime, Voltage, ylab = "Voltage", xlab = "datetime", type = "l"))
    with(data, {
        plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(datetime, Sub_metering_2, col = "red")
        lines(datetime, Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), box.lty = 0)
    })
    with(data, plot(datetime, Global_reactive_power, xlab = "datetime", type = "l"))
    dev.off()
}