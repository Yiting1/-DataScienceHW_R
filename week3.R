#week3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="./week3/1.csv")

#1
data <- read.csv("./week3/1.csv")
data <- data %>% mutate(agricultureLogical=ifelse(ACR==3 & AGS==6,1,0)) 
head(which(data$agricultureLogical==1),3)

#2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",destfile="./week3/2.jpg", mode = "wb")
library(jpeg)
img <- readJPEG("./week3/2.jpg",native=TRUE)
quantile(img,probs = c(0.3,0.8))

#3 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="./week3/Gross_Domestic_Product.csv",mode="wb")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="./week3/educational.csv",mode="wb")
gross <- read.csv("./week3/Gross_Domestic_Product.csv",skip=4,nrows = 215)
educational <- read.csv("./week3/educational.csv")

gross <- gross %>% select(X,X.1,X.3,X.4)
colnames(gross) <- c("CountryCode", "rankingGDP", "Long.Name", "gdp")
combine <- left_join(gross,educational,by=c("CountryCode"))
length(unique(combine$rankingGDP))

combine$rankingGDP
combine[order(combine$rankingGDP, decreasing = TRUE)][13]


dtGDP <- read.csv("./week3/Gross_Domestic_Product.csv",skip=4,nrows = 215)
dtGDP <- dtGDP[which(dtGDP$X != ""),]
dtGDP <- dtGDP %>% select(X,X.1,X.3,X.4)
colnames(dtGDP) <- c("CountryCode", "rankingGDP", "Long.Name", "gdp")


dtEd <- read.csv("./week3/educational.csv")
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))
dt[order(dt$rankingGDP, decreasing = TRUE),c("Long.Name.x", "Long.Name.y")][13,]

#4
dt %>% filter(!(is.na(Income.Group)),!(is.na(rankingGDP))) %>% group_by(Income.Group) %>% summarize(n_mean=mean(rankingGDP))

#5
breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
unique(dt$quantileGDP)
dt %>% group_by(quantileGDP) %>% summarize(num=n())

dt %>% filter(Income.Group=="Lower middle income") %>% select(Income.Group,quantileGDP) %>% dim
