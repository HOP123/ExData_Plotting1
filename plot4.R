#read file and save to myData
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))
myData <- read.table(file="household_power_consumption.txt", sep=";", skip=66637, nrow=2880)

#save myData to usethis file (I can play with use this file)
usethis <- myData

#combine Date and Time and convert it to POSIXtl object
dateTime <- as.character(paste(usethis[,1], usethis[,2], sep=" "))
dateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")

#combine dateTime and usethis and order it by dateTime col
usethis1 <- cbind(dateTime, usethis)
usethis2 <- usethis1[order(usethis1$dateTime),]
colnames(usethis2) <- c("dateTime", "Date", "Time", "GAP","GRP", "Vol", "GI", "SM1","SM2","SM3")

#plot4
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(usethis2$dateTime,usethis2$GAP, type="l", ylab="Global Active Power", xlab="")
plot(usethis2$dateTime,usethis2$Vol, type="l",ylab="Voltage", xlab="datetime")		
plot(usethis2$dateTime,usethis2$SM1, type="l", col="grey", ylab="Energy and metering", xlab="")
lines(usethis2$dateTime,usethis2$SM2, type="l", col="blue")
lines(usethis2$dateTime,usethis2$SM3, type="l", col="red")
inboxlegend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", bty="n", legend= inboxlegend, lty=1, col=c("grey","red","blue"))
plot(usethis2$dateTime,usethis2$GRP, type="l", ylab="Global_rective_power", xlab="datetime")
dev.off()
