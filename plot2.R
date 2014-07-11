## this function plots the second graph in the project and saves it to plot2.png
## dataDestination : give the destination of the dataset
library(data.table)
plot2 <- function(dataDestination){
    # read the Data
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
    png(filename  = "plot2.png", bg = "transparent")
    with(data, plot(datetime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))
    dev.off()
}