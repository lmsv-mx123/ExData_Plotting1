##This function fetches the zip file from internet and extracts its contents to wd
##if not already present. It assumes  extracted file_name is the same as the ziped file name.

fetch_remote_data <- function(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip") {
  
  library(tools)
  
  decoded_url <- URLdecode(url)
  file <- basename(decoded_url)
  file_name <- file_path_sans_ext(file)
  file_ext <- file_ext(file)
  
  ##Download and extract only if this has not been done.
  if(file_ext == "zip" && !file.exists(file)) {
    
    download.file(url, file, method = "curl")
    unzip(file)
    
  }
  
  ##Performs the listing of the files extracted
  extracted <- unzip(file, list = TRUE)
  ##Return only the file matching the file_name
  index <- grep(file_name,extracted$Name)
  return(extracted$Name[index])
  
}