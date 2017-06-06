#week4

#1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "./1.csv")
data <- read.csv("./1.csv")
strsplit(names(data),"wgtp")[[123]]

#2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile = "./2.csv")
data <- read.csv("./2.csv",skip=4,nrow=190)
data[,5] <- gsub(",","",data[,5])
mean(as.numeric(data[,5]))

#3
grep("^United",data[,4])

#4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile = "./educ.csv")
GDP <- read.csv("./2.csv",skip=4,nrow=190)
GDP <- GDP[,c(1,2,4,5)]
colnames(GDP) <- c("CountryCode", "rankingGDP", "Long.Name", "gdp")
education <- read.csv("./educ.csv")
data_merge <- merge(GDP, education, all = TRUE, by = c("CountryCode"))
index <- grepl("fiscal year end", tolower(data_merge$Special.Notes))
data_merge <- data_merge[index,]
length(which(grepl("june", tolower(data_merge$Special.Notes))==TRUE))


#5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sampleTimes <- index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
