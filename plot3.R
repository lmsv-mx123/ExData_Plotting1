##This function makes Plot3, a graph of the Energy submeterings 1,2,3 vs datetime

source("fetch_remote_data.R")

plot3 <- function() {
  
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
  png("plot3.png", width = 480, height = 480, units = "px")
  
  ## Create plot
  plot(data_subset$Time, data_subset[,7], type = "l",
       xlab = " ", ylab = "Energy sub metering")
  lines(data_subset$Time, data_subset[,8], col="red")
  lines(data_subset$Time, data_subset[,9], col="blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col = c("Black","Red","Blue"), lwd = 1)
  
  ## Close device graphics
  dev.off()
  
}