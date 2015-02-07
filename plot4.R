##This function makes Plot4, 4 different subplots with x-axis datetime.

source("fetch_remote_data.R")

plot4 <- function() {
  
  ## fetch file used
  file <- fetch_remote_data()
  data <- read.table(file,header=TRUE,sep=";",colClasses="character")
  
  ## Convert date and time to Date/Time class
  data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  ## Use data from the dates 2007-02-01 and 2007-02-02
  dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
  data_subset <- subset(data, Date %in% dates)
  
  ## Convert columns 3-9 in the dataset to be numeric
  for(i in c(3:9)) {
    data_subset[,i] <- as.numeric(data_subset[,i])
  }
  
  ## Create PNG graphics
  png("plot4.png", width = 480, height = 480, units = "px")
  
  ## Set a grid of 2x2 for plots, fill out row by row
  par(mfrow = c(2,2))
  
  ## Plot for Global Active Power
  plot(data_subset$Time, data_subset[,3], type = "l", 
       xlab = " ", ylab = "Global Active Power")
  
  ## Plot for Voltage vs datetime
  plot(data_subset$Time, data_subset[,5], type = "l", 
       xlab = "datetime", ylab = "Voltage")
  
  ## Plot for Energy sub metering
  plot(data_subset$Time, data_subset[,7], type = "l",
       xlab = " ", ylab = "Energy sub metering")
  lines(data_subset$Time, data_subset[,8], col="red")
  lines(data_subset$Time, data_subset[,9], col="blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col = c("Black","Red","Blue"), lwd = c(1, 1, 1), bty = "n")
  
  ## Plot for Global_reactive_power vs datetime
  plot(data_subset$Time, data_subset[,4], type = "n", 
       xlab = "datetime", ylab = "Global_reactive_power")
  lines(data_subset$Time, data_subset[,4])
  
  ## Close device graphics
  dev.off()
  
}