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
  mutate(Global_active_power=as.numeric(Global_active_power)) %>%
  mutate(Date=as.Date(Date, format= "%d/%m/%Y")) %>%
 filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
png("plot1.png")
hist(plot_data$Global_active_power, col = "red", 
     xlab = "Global Active Power(kilowatts)", main="Global Active Power")
dev.off()