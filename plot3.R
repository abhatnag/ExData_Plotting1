if( !("dplyr" %in% (.packages())) || !("data.table" %in% (.packages())) )
  source("setEnvironment.R")

if(is_empty(plot_data) || !is.data.frame(plot_data))
  plot_data<-populate_data("./data/household_power_consumption.txt",
                           c("Voltage","Global_active_power",
                             "Global_reactive_power",
                             "Sub_metering_1","Sub_metering_2","Sub_metering_3",
                             "Date", "Time"))
# references: https://www.r-bloggers.com/date-formats-in-r/
# http://rdpeng.github.io/RProgDA/working-with-large-datasets.html

plot_data<-plot_data %>%
  mutate(Sub_metering_1=as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2=as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3=as.numeric(Sub_metering_3)) %>%
  mutate(Date=as.Date(Date, format= "%d/%m/%Y")) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#merge Date and Time columns
df<-as.POSIXct(paste(plot_data$Date, plot_data$Time), format="%Y-%m-%d %H:%M:%S")

Y <- data.matrix(plot_data[1:3])
png("plot3.png")
plot(df, plot_data$Sub_metering_1,type="l",lty=1,
     col = "black", ylab = "Energy sub metering", xlab=" ")
points(df, plot_data$Sub_metering_2, type='l', col="red")
points(df, plot_data$Sub_metering_3,type="l",lty=1,
       col = "blue")
legend("topright", colnames(Y),col=c("black","red", "blue"),lty=1) # optional legend

dev.off()

# format into Time 
# plot_data <-within(plot_data, {timestamp=as.POSIXct(paste(Date, Time),format="%Y-%m-%d %H:%M:%S")})

# matplot(plot_data$timestamp, Y,type="l",lty=1,xaxt="n",
#         col = c("black","red", "blue"), ylab = "Energy sub metering", xlab=" ") #plot
# axis.POSIXct(1, at=seq(plot_data$timestamp[1], 
#                        plot_data$timestamp[length(plot_data$timestamp)], by= "day"), format="%a")
# legend("topright", colnames(Y),col=c("black","red", "blue"),lty=1) # optional legend


