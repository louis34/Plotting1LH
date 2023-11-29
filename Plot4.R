#Package dowload
library(tidyverse)

#directory of the file
df <- "household_power_consumption.txt"


memory_available <- memory.size()
cat("Memory available:", memory_available, "Mo\n")

memory_size_df <- (object.size(read.table(df))/ (1024^2))
cat("Size file:", memory_size_df, "Mo\n")

if (memory_available >= memory_size_df){
      print(cat("Computer is OK to analyse the file\n"))
} else {
      print(cat("Computer is not OK to analyse the file\n"))
}


# Dowload only the data with the date between 2007-02-01 and 2007-02-02 with dplyr function

hpc <- read.table(df,header = TRUE, stringsAsFactors = FALSE,sep=";",na.strings = "?",
                  quote = "")%>%
      filter(Date == "1/2/2007" | Date == "2/2/2007")%>%
      mutate(Global_active_power = as.numeric(Global_active_power))

#Create a new factor datatime with Date and Time
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time),format = '%d/%m/%Y %H:%M:%S')


#Plot 4 :

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

#PLOT topleft
plot(x = hpc$datetime, y = hpc$Global_active_power, 
     type = 'l', xlab = NA, ylab = 'Global Active Power (kilowatts)')


#Plot topright
plot(x = hpc$datetime, y = hpc$Voltage, 
     type = 'l', xlab = "datetime", ylab = 'Voltage')

#Plot lowleft
plot(x = hpc$datetime, y =  hpc$Sub_metering_1 , 
     type = 'l', xlab = NA, ylab = 'Energy sub metering')

lines(hpc$datetime, y =  hpc$Sub_metering_2, col="red" )
lines(hpc$datetime, y=hpc$Sub_metering_3, col="blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1,bty = 'n')


#Plot lowright
plot(x = hpc$datetime, y = hpc$Global_reactive_power, 
     type = 'l', xlab = "datetime", ylab = 'Global_reactive_power')

#Dowload the plot
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()