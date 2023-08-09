# Load tidyverse and related libraries
library(tidyverse)
library(dplyr)
library(readr)
library(janitor)


# Loading the dataset and clean column names
power_data = read_delim("household_power_consumption.txt", delim=";", col_names = TRUE, na="?") %>% 
  clean_names()

# Convert date column to date type and filter the dates 2007-02-01 and 2007-02-02
power_data = power_data %>% 
  mutate(date = as.Date(date, format="%d/%m/%Y")) %>% 
  filter(date >= "2007-02-01" & date <= "2007-02-02")
  
# Plot1 save to a .png file
png("plot1.png", width=480, height=480)

hist(power_data$global_active_power, col="Red", main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.off()
