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

##Plot 2
png(file = "plot2.png")

par(mar=c(4.5,4.5,3,3))

plot(EPCdata$datetime1, EPCdata$Global_active_power, ylab = "Global Active Power (Kilowatts)", xlab="", type = "n")
lines(EPCdata$datetime1, EPCdata$Global_active_power,col="black")

dev.off()