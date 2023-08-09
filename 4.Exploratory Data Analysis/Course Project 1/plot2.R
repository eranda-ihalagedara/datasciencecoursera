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
  mutate(date_time = as.POSIXlt(paste(date,time), format = "%d/%m/%Y %H:%M")) %>% 
  filter(date_time >= "2007-02-01" & date_time < "2007-02-03")
  
# Plot2 save to a .png file
png("plot2.png", width=480, height=480)

plot(power_data$date_time, power_data$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
