## Set your working directory
## Please download and unzip the data in your working directory
## Select the following code and run.


library(RSQLite)
con <- dbConnect("SQLite", dbname = "sample_db.sqlite")
dbWriteTable(con, name="EPC_table", value="household_power_consumption.txt", row.names=FALSE, header=TRUE, sep = ";")
EPCData1 <- dbGetQuery(con, 'SELECT * FROM EPC_table where Date == "1/2/2007"')
EPCData2 <- dbGetQuery(con, 'SELECT * FROM EPC_table where Date == "2/2/2007"')
dbDisconnect(con)

EPCdata <- rbind(EPCData1, EPCData2)


EPCdata$datetime <- paste(EPCdata$Date, EPCdata$Time, sep=" ")

EPCdata$datetime1 <- strptime(EPCdata$datetime, "%d/%m/%Y %H:%M:%S")

##Plot 3
png(file = "plot3.png")

plot(EPCdata$datetime1, EPCdata$Sub_metering_1, ylab = "Energy Sub Metering", xlab="", type = "n")
lines(EPCdata$datetime1, EPCdata$Sub_metering_1, col="black")
lines(EPCdata$datetime1, EPCdata$Sub_metering_2, col="red")
lines(EPCdata$datetime1, EPCdata$Sub_metering_3, col="blue")

legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()