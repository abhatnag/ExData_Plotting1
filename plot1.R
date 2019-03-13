library(data.table)
library(dplyr)

plot_data<-fread(("./data/household_power_consumption.txt"),
  select=c("Global_active_power","Date"))

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