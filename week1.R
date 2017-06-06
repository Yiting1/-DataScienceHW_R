#week1

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="./week1/1.csv")

#1
data <- read.csv("./week1/1.csv")
data_1 <- data[which(is.na(data['VAL'])==FALSE),"VAL"]
length(which(data_1==24))

#2
head(data["FES"])

#3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",destfile = "./week1/3.xlsx")
library(readxl)
dat <- read_excel("./week1/3.xlsx",sheet="NGAP Sample Data")
dat <- dat[17:22,7:15]
colnames(dat) <- dat[1,]
dat <- as.data.frame(dat)
dat <- dat[-1,]
sum(as.numeric(dat$Zip)*as.numeric(dat$Ext),na.rm=T)

#4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",destfile = "./week1/4.xml")
library(XML)
doc <- xmlTreeParse("./week1/4.xml",useInternal=TRUE)
rootNode <- xmlRoot(doc)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(which(zipcode=="21231"))


#5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "./week1/5.csv")
library(data.table)
DT <- fread("./week1/5.csv")
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1])
system.time(rowMeans(DT)[DT$SEX==2])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
