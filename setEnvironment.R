this.dir <- dirname(parent.frame(2)$ofile)
data_file <- "household_power_consumption.txt"
#set the working directory to the location of the source file
#Reference: https://stackoverflow.com/questions/13672720/r-command-for-setting-working-directory-to-source-file-location-in-rstudio
#Answer by User: https://stackoverflow.com/users/982159/bumblebee
initialize<-function(){
  pkgs <- c("data.table", "dplyr")
  setwd(this.dir)
  rm(list=ls()) #remove all environment variables
  lapply(pkgs, require, character.only = TRUE)
  if(!file.exists(data_file))
    unzip(zipfile = "exdata_data_household_power_consumption.zip", unzip = getOption("unzip"))
  }

populate_data <- function(file_path,vec_cols ) {
  print(vec_cols)
  if(missing(file_path))
    stop("'file_path' must be provided")
  if(!file.exists(file_path))
    stop("file does not exists")
  if(!is.vector(vec_cols))
    stop("send a vector of columns")
  plot_data<-fread((file_path),
                   select=vec_cols)
  return(plot_data)
}
initialize()
plot_data<-populate_data(data_file,
                         c("Voltage","Global_active_power",
                           "Global_reactive_power",
                           "Sub_metering_1","Sub_metering_2","Sub_metering_3",
                           "Date", "Time"))