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


EPCdata$Date <- as.Date(EPCdata$Date, "%d/%m/%Y")

EPCdata$Time <- strptime(EPCdata$Time, "%H:%M:%S")

##Plot 1
png(file = "plot1.png")

par(mar=c(4.5,4.5,3,3))

hist(EPCdata$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()