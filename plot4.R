if( !("dplyr" %in% (.packages())) || !("data.table" %in% (.packages())) )
  source("setEnvironment.R")

if(is_empty(plot_data) || !is.data.frame(plot_data))
  plot_data<-populate_data("./data/household_power_consumption.txt",
                           c("Voltage","Global_active_power",
                             "Global_reactive_power",
                             "Sub_metering_1","Sub_metering_2","Sub_metering_3",
                             "Date", "Time"))
plot_data<-plot_data %>%
  mutate(Global_active_power=as.numeric(Global_active_power)) %>%
  mutate(Global_reactive_power=as.numeric(Global_reactive_power)) %>%
  mutate(Sub_metering_1=as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2=as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3=as.numeric(Sub_metering_3)) %>%
  mutate(Date=as.Date(Date, format= "%d/%m/%Y")) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

  #format into Time 
  strptime(plot_data$Time, "%H:%M:%S")
  
  #merge Date and Time columns
  df<-as.POSIXct(paste(plot_data$Date, plot_data$Time), format="%Y-%m-%d %H:%M:%S")
  
  png("plot4.png")
  par(mfrow=c(2,2))

  #plot1
  plot(df, plot_data$Voltage, type="l",xlab="",
       ylab="Voltage" )
  
  #plot2
  plot(df, plot_data$Global_active_power, type="l",xlab="",
       ylab="Global Active Power(kilowatts)" )
  #format into Time 
  plot_data <-within(plot_data, {timestamp=as.POSIXct(paste(Date, Time),format="%Y-%m-%d %H:%M:%S")})
  
  mycols <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  Y <- data.matrix(plot_data[mycols]) 
  matplot(plot_data$timestamp, Y,type="l",lty=1,
          col = c("black","red", "blue"), ylab = "Energy sub metering", xlab=" ") #plot
  legend("topright", colnames(Y),col=c("black","red", "blue"),lty = 1, bty="n") # optional legend
  
  plot(df, plot_data$Global_reactive_power, type="l",xlab="",
       ylab="Global_reactive_power" )
  
  dev.off()
  
  