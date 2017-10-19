library(Hmisc)
library(plyr)
datos<-read.csv2("household_power_consumption.txt",header = TRUE,sep = ";") ##reading the data
date<-as.Date(datos$Date,format = "%d/%m/%Y")
datos<-mutate(datos,Date=date) ## transforming the dates into Date
datos2<-subset(datos,datos$Date>="2007-02-01" & datos$Date<="2007-02-02") ## subsetting the data with the dates to be used
datetime<-paste(datos2$Date,datos2$Time,sep = " ")
datetime<-strptime(datetime,format = "%Y-%m-%d %H:%M:%S") ## transforming Date and Time into POSIXlt
datos2<-mutate(datos2,DateTime = datetime) ## creating a column with Date and Time
png("plot4.png",width = 480,height = 480)
par(mfrow=c(2,2))
plot(datos2$DateTime,datos2$Global_active_power,type = "l",xlab = " ",ylab="Global Active Power (kilowatts)")
plot(datos2$DateTime,as.numeric(as.character(datos2$Voltage)),xlab="datetime",ylab="Voltage",type="l")
plot(datos2$DateTime,as.numeric(as.character(datos2$Sub_metering_1)),type = "l",xlab=" ",ylab="Energy sub metering")
lines(datos2$DateTime,as.numeric(as.character(datos2$Sub_metering_2)),col="red")
lines(datos2$DateTime,as.numeric(as.character(datos2$Sub_metering_3)),col="blue")
legend("topright",pch="____",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(datos2$DateTime,as.numeric(as.character(datos2$Global_reactive_power)),xlab="datetime",ylab="Global_reactive_power",type="l")
dev.off()