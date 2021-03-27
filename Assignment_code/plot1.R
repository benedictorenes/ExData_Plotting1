library(data.table)


# read and organize the data
d=fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
        nrows = 500000, colClasses = c("character","character",rep("numeric",7)))
d$mydate = do.call(paste,  d[ ,c("Date", "Time")])

d$mytime = as.POSIXct(strptime(d$mydate,format = "%d/%m/%Y %H:%M:%S"))

var1=as.POSIXct("2007-02-01 00:00:00")
var2=as.POSIXct("2007-02-03 00:00:00")
dr = d[(d$mytime >= var1) & (d$mytime<=var2)]


# change working directory to save the plot, assuming current wd is code folder
wd <- getwd()
setwd("..")
parent <- getwd()
setwd("Assignment_figures")
png("plot1.png",width = 480, height = 480,
    units = "px")
hist(dr$Global_active_power, breaks = 30, col="red",
     ylim = c(0,1200),
     xlab="Global active power (kilowatts)",main="Globall active power")
ticks = seq(0, 1200, by=200)
axis(side = 2, at = ticks)
dev.off()
