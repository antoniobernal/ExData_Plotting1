
##Download the ZIP file to working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
download.file(url, zipfile, method = "curl")

##Unzip the file
unzip(zipfile)

##Read in the file
filename <- "household_power_consumption.txt"
x <- read.table(filename, header = TRUE, sep = ";", stringsAsFactors=FALSE)

##Convert the class of Date variable from Character to Date
x$Date <- as.Date(x$Date, format="%d/%m/%Y")

##Subset the file to keep only the two days of interes for analysis
subset <- x[x$Date >= as.Date('2007-02-01', format="%Y-%m-%d") & x$Date <= as.Date('2007-02-02', format="%Y-%m-%d"),]

##Convert the GLobal_Active_power variable from Character to number
subset$Global_active_power <-as.numeric(subset$Global_active_power, format="")

##Open the Graphic device to store the plot as a PNG file
png(filename = "plot1.png", width = 480, height = 480)

##Create the Histogram
hist(subset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power")

##Closes the Graphic Device
dev.off()


