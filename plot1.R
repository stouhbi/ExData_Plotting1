## this function plots the first graph in the project and saves it to plot1.png
## dataDestination : give the destination of the dataset
library(data.table)
plot1 <- function(dataDestination){
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
    png(filename  = "plot1.png", bg = "transparent")
    hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
    dev.off()
}
