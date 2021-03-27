library(data.table)


# read and organize the data 
d=fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
        nrows = 500000, colClasses = c("character","character",rep("numeric",7)))
d$mydate = do.call(paste,  d[ ,c("Date", "Time")])

d$mytime = as.POSIXct(strptime(d$mydate,format = "%d/%m/%Y %H:%M:%S"))
var1=as.POSIXct("2007-02-01 00:00:00")
var2=as.POSIXct("2007-02-03 00:00:00")
dr = d[(d$mytime >= var1) & (d$mytime<=var2)]


# generate and save the plot 
wd <- getwd()
setwd("..")
parent <- getwd()
setwd("Assignment_figures")
png("plot3.png",width = 480, height = 480,
    units = "px")
plot(dr$mytime,dr$Sub_metering_1,
     type = "l",ylab="Energy sub metering",xlab = "")
lines(dr$mytime,dr$Sub_metering_2,col="red")
lines(dr$mytime,dr$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("red","black","blue"),lty = c(1,1,1))
dev.off()

setwd(wd)
