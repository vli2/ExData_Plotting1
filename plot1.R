# Exploratory Data Analysis 
# Porject 1
#
# plot1.R
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

# make Plot 1
png("plot1.png", width=480, height=480)

hist(plot_df$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     col="red")

# close the device file
dev.off()
