#
# Script file to create plot 1 for the week 1 assignment of the "Exploratory Data Analysis" course.
# 

# Clear memory

rm(list=ls())

# Set working directory to the correct address

setwd("C:/Users/jchacin72799/Documents/R/Sample Scripts/Coursera/Exploratory Data Analysis/Week 1")

# Read in the file "houselhold_power_consumption.txt"
# The scripts skips the first 66500 rows and then reads the next 4000 rows. This interval 
# brackets the data of interest 

file <- "household_power_consumption.txt"
pwr_data <- read.table(file, sep = ";", header = FALSE, stringsAsFactors = FALSE, skip = 66500, nrows = 4000)

# Assign names to the variables

names(pwr_data) <- c("Date","Time","Glb_Act","Glb_Ina","Volt","Glb_Int","Sub1","Sub2","Sub3")

# Convert the date and time variables to the correct formats with concatenation

temp <- paste(pwr_data$Date,pwr_data$Time)
temp <- strptime(temp,"%d/%m/%Y %H:%M:%S")

# Create new array with the date and time in the right format

pwr_sub <- cbind(temp,pwr_data[3:ncol(pwr_data)])

# Rename columns

names(pwr_sub) <- c("Date","Glb_Act","Glb_Ina","Volt","Glb_Int","Sub1","Sub2","Sub3")

# Subset data for the dates needed

pwr_sub <- pwr_sub[{pwr_sub$Date > "2007-02-1" & pwr_sub$Date < "2007-02-03"},]

# The data is ready. Create plots

png(file = "plot3.png", width = 480, height = 480)
plot(pwr_sub$Date,pwr_sub$Sub1, xlab = "", ylab = "Energy Sub Metering", type = "n")
lines(pwr_sub$Date,pwr_sub$Sub1)
lines(pwr_sub$Date,pwr_sub$Sub2, col = "red")
lines(pwr_sub$Date,pwr_sub$Sub3, col = "blue")
legend("topright", legend = c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"), lty = 1, col = c("black", "red", "blue"))
dev.off()

