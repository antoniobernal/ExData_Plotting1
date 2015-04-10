##Download the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
download.file(url, zipfile, method = "curl")

##Read the file
filename <- "household_power_consumption.txt"
x <- read.table(filename, header = TRUE, sep = ";", stringsAsFactors=FALSE)

##Create a Data and Time variable to plot the X-axis
x$DateTime <- strptime(paste(x$Date,x$Time),"%d/%m/%Y %H:%M:%S")

##Change the class of variable Date from character to date
x$Date <- as.Date(x$Date, format="%d/%m/%Y")

##Subset the data to keep only the 2 days of interest for analysis
subset <- x[x$Date >= as.Date('2007-02-01', format="%Y-%m-%d") & x$Date <= as.Date('2007-02-02', format="%Y-%m-%d"),]

##Converts the variables to plot from character to numeric
subset$Sub_metering_1 <-as.numeric(subset$Sub_metering_1)
subset$Sub_metering_2 <-as.numeric(subset$Sub_metering_2)
subset$Sub_metering_3 <-as.numeric(subset$Sub_metering_3)
subset$DateTime <- strptime(paste(strptime(subset$Date,"%Y-%m-%d"),subset$Time),"%Y-%m-%d %H:%M:%S")

##open the graphic device to store the plot as a PNG file
png(filename = "plot3.png", width = 480, height = 480)

##Creates the Plot for the 3 variables
plot(subset$DateTime,subset$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(subset$DateTime,subset$Sub_metering_2,  col="red")
lines(subset$DateTime,subset$Sub_metering_3,  col="blue")

##Creates the legend
legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       lty=1, col=c('black','red', 'blue'), bty='o', cex=.75,  border = "black")

##close the graphic device 
dev.off()