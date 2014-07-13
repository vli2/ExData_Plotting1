# Exploratory Data Analysis 
# Porject 1
#
# plot4.R
#
# set working directory
wrkdir <- getwd()
wrkdir

# download and unzip the file.  Be patient - download file will take a while
# the unzipped file is "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
if (!file.exists(wrkdir)) {dir.create(wrkdir)}
download.file(url, file.path(wrkdir, zipfile))
unzip(zipfile)

# read data
f <- "household_power_consumption.txt"
df <- read.table(f, header=TRUE, sep=";", colClasses="character",
                 na.strings="?")
# subset data
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, format="%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
# we only need data from the dates 2007-02-01 and 2007-02-02
plot_dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
plot_df <- subset(df, Date %in% plot_dates)
# convert data to numeric
plot_df$Global_active_power <- as.numeric(plot_df$Global_active_power)

# make Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#Subplot 1 (upper left figure)
plot(plot_df$DateTime, plot_df$Global_active_power, 
     ylab="Global Active Power", xlab="", type="l")

#subplot 2 (upper right figure)
plot(plot_df$DateTime, plot_df$Voltage, ylab="Voltage", xlab="datetime", type="l")

#Subplot 3 (bottom left figure )
plot(plot_df$DateTime, plot_df$Sub_metering_1, 
     ylab="Energy sub metering", xlab="", type="l")
lines(plot_df$DateTime, plot_df$Sub_metering_2, col="red")
lines(plot_df$DateTime, plot_df$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", 
  "Sub_metering_3"), bty="n", lty=1, col=c("black", "red", "blue"))

#Subplot 4 (bottom right figure)
plot(plot_df$DateTime, plot_df$Global_reactive_power, 
     ylab="Global_reactive_power", xlab="datetime", type="l")

# close the device file
dev.off()
