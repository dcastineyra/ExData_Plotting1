library(Hmisc)
library(plyr)
datos<-read.csv2("household_power_consumption.txt",header = TRUE,sep = ";") ##reading the data
date<-as.Date(datos$Date,format = "%d/%m/%Y")
datos<-mutate(datos,Date=date) ## transforming the dates into Date
datos2<-subset(datos,datos$Date>="2007-02-01" & datos$Date<="2007-02-02") ## subsetting the data with the dates to be used
datetime<-paste(datos2$Date,datos2$Time,sep = " ")
datetime<-strptime(datetime,format = "%Y-%m-%d %H:%M:%S") ## transforming Date and Time into POSIXlt
datos2<-mutate(datos2,DateTime = datetime) ## creating a column with Date and Time
png("plot2.png",width = 480,height = 480)
plot(datos2$DateTime,datos2$Global_active_power,type = "l",xlab = " ",ylab="Global Active Power (kilowatts)")
dev.off()