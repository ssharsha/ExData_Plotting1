
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

#Merge the Date & Time entries into a single entry and store this in a data-frame
dattimdata<-as.data.frame(paste(newdata$Date,newdata$Time))

#Give a column-name to the merged-data column
colnames(dattimdata)[1]<-"combDateTime"

#Join the sub-set data with this new data-frame
newdata2<-cbind(newdata, dattimdata)

#Convert the merged data-time column to class "POSIXlt" "POSIXt" 
newdata2$combDateTime<-strptime(newdata2$combDateTime, format='%Y-%m-%d %H:%M:%S')

#Convert the 3 sub_metering columns from class=factor to class=numeric
newdata2$Sub_metering_1<-as.numeric(as.character(newdata2$Sub_metering_1))
newdata2$Sub_metering_2<-as.numeric(as.character(newdata2$Sub_metering_2))
newdata2$Sub_metering_3<-as.numeric(as.character(newdata2$Sub_metering_3))

#Set the margins
par(mar = c(5,5,5,5))

#Plot the Overlay-Plot
plot(newdata2$combDateTime, newdata2$Sub_metering_1, type = 'l', col="black", xlab = "", ylab = "Energy sub metering")
points(newdata2$combDateTime, newdata2$Sub_metering_2, type = 'l', col="red")
points(newdata2$combDateTime, newdata2$Sub_metering_3, type = 'l', col="blue")

#Define the legends for the plot
legend("topright", lty =1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#Copy the plot to a PNG file
dev.copy(png, file= "plot3.png", width = 480, height = 480, units = "px")
dev.off()