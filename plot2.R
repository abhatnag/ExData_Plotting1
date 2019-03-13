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
  mutate(Date=as.Date(Date, format= "%d/%m/%Y")) %>%
 filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#format into Time 
strptime(plot_data$Time, "%H:%M:%S")

#merge Date and Time columns
df<-as.POSIXct(paste(plot_data$Date, plot_data$Time), format="%Y-%m-%d %H:%M:%S")

png("plot2.png")
plot(df, plot_data$Global_active_power, type="l",xlab="",
     ylab="Global Active Power(kilowatts)" )
dev.off()