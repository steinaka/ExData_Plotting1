# 
# Preliminaries
# Load packages.

packages <- c("data.table", "reshape2")
library('knitr')
library('markdown')

sapply(packages, require, character.only = TRUE, quietly = TRUE)

path <- getwd()
path

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- "Dataset.zip"
if (!file.exists(path)) {
  dir.create(path)
}
download.file(url, file.path(path, f))

executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, 
                                                                                f), "\""))

pathIn <- file.path(path, "UCI ML Dataset")
list.files(pathIn, recursive = TRUE)


dataFile <- "./household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]


#str(subSetData)
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
