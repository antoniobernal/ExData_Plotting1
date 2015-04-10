##Download the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
download.file(url, zipfile, method = "curl")

##Read in the file
filename <- "household_power_consumption.txt"
x <- read.table(filename, header = TRUE, sep = ";", stringsAsFactors=FALSE)

##Create a variable with Data and Time to plot the X Axis
x$DateTime <- strptime(paste(x$Date,x$Time),"%d/%m/%Y %H:%M:%S")

##Change the class of variable date from Character to Date
x$Date <- as.Date(x$Date, format="%d/%m/%Y")

##Subset the data to inllude only the 2 days of interest
subset <- x[x$Date >= as.Date('2007-02-01', format="%Y-%m-%d") & x$Date <= as.Date('2007-02-02', format="%Y-%m-%d"),]

##Convert the measurements from Character to numeric
subset$Global_active_power <-as.numeric(subset$Global_active_power)
subset$Sub_metering_1 <- as.numeric(subset$Sub_metering_1)
subset$Sub_metering_2 <- as.numeric(subset$Sub_metering_2)
subset$Sub_metering_3 <- as.numeric(subset$Sub_metering_3)
subset$Voltage <- as.numeric(subset$Voltage)     
subset$Global_reactive_power <- as.numeric(subset$Global_reactive_power)

##Create a varibale to store date and time for plotting the x-axis
subset$datetime <- strptime(paste(strptime(subset$Date,"%Y-%m-%d"),subset$Time),"%Y-%m-%d %H:%M:%S")

##open the graphic device to store the plots as a PNG file
png(filename = "plot4.png", width = 480, height = 480)

##Define a 2 x 2 grid
par(mfrow = c(2,2))
with(subset, {
        
        ##Plots Global Active Power
        plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power")

        ##Plots Voltage
        plot(datetime,Voltage,type="l",ylab="Voltage")

        ##Plots Energy Sub metering
        plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
        lines(datetime,Sub_metering_2,  col="red")
        lines(datetime,Sub_metering_3,  col="blue")
        legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
               lty=1, col=c('black','red', 'blue'), bty='n', cex=.75)


        ##Plots Global Reactive Power
        plot(datetime,Global_reactive_power,type="l")
})

##Close the graphic device
dev.off()