library(data.table)
library(dplyr)

plot_data<-fread(("./data/household_power_consumption.txt"),
  select=c("Global_active_power","Date", "Time"))

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