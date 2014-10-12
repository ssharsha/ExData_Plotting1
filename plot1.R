
#Download the zip-file locally
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, "household_power_consumption.zip", method="curl")

#Unzip the zip-file
unzip("household_power_consumption.zip", files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)

#Read the data
origdata<-read.table("household_power_consumption.txt", header=T, sep=";")

#Convert the Date column into class: Date
origdata$Date<-as.Date(origdata$Date, format='%d/%m/%Y')

#Extract only the data for the dates: 02/01/2007 & 02/02/2007
newdata <- origdata[ which(origdata$Date == "2007-02-01" | origdata$Date == "2007-02-02"),]

#Convert the Global_active_power column from class=factor to class=numeric
newdata$Global_active_power<-as.numeric(as.character(newdata$Global_active_power)) 

#Set the margins
par(mar = c(6,6,6,6))

#Plot the histogram
with(newdata, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab = "Frequency", main="Global Active Power"))

#Copy the plot to a PNG file
dev.copy(png, file= "plot1.png", width = 480, height = 480, units = "px")
dev.off()