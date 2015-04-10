##Download the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
download.file(url, zipfile, method = "curl")

##Read the file
filename <- "household_power_consumption.txt"
x <- read.table(filename, header = TRUE, sep = ";", stringsAsFactors=FALSE)

##Create a Date Time variable for plotting the X Axis
x$DateTime <- strptime(paste(x$Date,x$Time),"%d/%m/%Y %H:%M:%S")

##Change the class of variable Date from Character to Date
x$Date <- as.Date(x$Date, format="%d/%m/%Y")

##Subset the data to keep only the 2 days of interest
subset <- x[x$Date >= as.Date('2007-02-01', format="%Y-%m-%d") & x$Date <= as.Date('2007-02-02', format="%Y-%m-%d"),]

##Convert the variables from Charatcer to Numeric for plotting
subset$Global_active_power <-as.numeric(subset$Global_active_power)
subset$DateTime <- strptime(paste(strptime(subset$Date,"%Y-%m-%d"),subset$Time),"%Y-%m-%d %H:%M:%S")

##Opens the Graphics Device to store the plot as a PNG file
png(filename = "plot2.png", width = 480, height = 480)

##Plots the Global Active Power Variable by date and time
plot(subset$DateTime,subset$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

##closes the graphic device
dev.off()