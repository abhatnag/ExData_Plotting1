this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
library(data.table)
library(dplyr)
plot_data<-fread(("./data/household_power_consumption.txt"),
                 select=c("Sub_metering_1","Sub_metering_2","Sub_metering_3",
                          "Date", "Time"))

# references: https://www.r-bloggers.com/date-formats-in-r/
# http://rdpeng.github.io/RProgDA/working-with-large-datasets.html

plot_data<-plot_data %>%
  mutate(Sub_metering_1=as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2=as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3=as.numeric(Sub_metering_3)) %>%
  mutate(Date=as.Date(Date, format= "%d/%m/%Y")) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#format into Time 
strptime(plot_data$Time, "%H:%M:%S")

#merge Date and Time columns
#plot_data$Date<-as.POSIXct(paste(plot_data$Date, plot_data$Time), format="%Y-%m-%d %H:%M:%S")
dates<-as.POSIXct(paste(plot_data$Date, plot_data$Time), format="%Y-%m-%d %H:%M:%S")

#png("plot3.png")
#reference: https://rpubs.com/euclid/343644
library(ggplot2)
#Group sub_metering into a new dataframe
plot_new = data.frame(plot_data)
p = ggplot() + 
  geom_line(data = plot_data, aes(x = dates, y = Sub_metering_1, color = 'black')) +
  geom_line(data = plot_data, aes(x = dates, y = Sub_metering_2, color = 'red')) +
  geom_line(data = plot_data, aes(x = dates, y = Sub_metering_3, color = 'blue')) +
  xlab('Dates') +
  ylab('Energy sub metering')

p + theme(strip.background = element_rect(colour="white", fill="white"),
          legend.position=c(.9,.75))
print(p)
