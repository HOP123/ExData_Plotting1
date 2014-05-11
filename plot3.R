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

#plot3 
png(file="plot3.png", width=480, height=480)
plot(usethis2$dateTime,usethis2$SM1, type="l", col="grey",ylab="Energy sub metering",xlab="")
lines(usethis2$dateTime,usethis2$SM2, type="l", col="blue")
lines(usethis2$dateTime,usethis2$SM3, type="l", col="red")

inboxlegend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", bty="y", legend= inboxlegend, lty=1, col=c("grey","red","blue"))
dev.off()
