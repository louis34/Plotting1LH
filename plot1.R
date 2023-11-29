
#Package dowload
library(tidyverse)


#directory of the file
df <- "household_power_consumption.txt"

#Memory verification
memory_available <- memory.size()
cat("Memory available:", memory_available, "Mo\n")

memory_size_df <- (object.size(read.table(df))/ (1024^2))
cat("Size file:", memory_size_df, "Mo\n")

if (memory_available >= memory_size_df){
      print(cat("Computer is OK to analyse the file\n"))
} else {
      print(cat("Computer is not OK to analyse the file\n"))
      }


# Dowload only the data with the date between 2007-02-01 and 2007-02-02

hpc <- read.table(df,header = TRUE, stringsAsFactors = FALSE,sep=";",na.strings = "?",
                  quote = "")%>%
      filter(Date == "1/2/2007" | Date == "2/2/2007")%>%
      mutate(Global_active_power = as.numeric(Global_active_power))


#Create a new factor datatime with Date and Time
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time),format = '%d/%m/%Y %H:%M:%S')


#Plot 1 : histogram Global Active Power 

hist(hpc$Global_active_power, col="red", xlab="Global Active Power (kilowatts",
     main = "Global Active Power")


#Create a new factor datatime with Date and Time
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

