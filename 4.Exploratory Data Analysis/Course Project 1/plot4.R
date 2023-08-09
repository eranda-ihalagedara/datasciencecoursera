# Load tidyverse and related libraries
library(tidyverse)
library(dplyr)
library(readr)
library(janitor)
library(lubridate)



# Loading the dataset and clean column names
power_data = read_delim("household_power_consumption.txt", delim=";", col_names = TRUE, na="?") %>% 
  clean_names()

# Convert date column to date type and filter the dates 2007-02-01 and 2007-02-02
power_data = power_data %>% 
  mutate(date_time = as.POSIXct(paste(date,time), format = "%d/%m/%Y %H:%M")) %>% 
  filter(date_time >= "2007-02-01" & date < "2007-02-03")
  


# Plot4 save to a .png file
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(power_data$date_time, power_data$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(power_data$date_time, power_data$voltage, type="l", xlab="", ylab="Voltage")


plot(power_data$date_time, power_data$sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_data$date_time, power_data$sub_metering_2,col="red")
lines(power_data$date_time, power_data$sub_metering_3,col="blue")
legend("topright", legend=c("sub_metering_1","sub_metering_2", "sub_metering_3"), col=c("black","red","blue"), lty = 1)

plot(power_data$date_time, power_data$global_reactive_power, type="l", xlab="", ylab="Global_reactive_power")


dev.off()