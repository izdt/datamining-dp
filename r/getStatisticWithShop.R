#Set workspace to the path
setwd('../')

#use sqldf library
library(sqldf)
#use ggplot2 library
library(ggplot2)
#use gridExtra library
library(gridExtra)

#load data
#topShopWithLL <- read.table('data/topShopOfBJWithLL.txt',  header = T, encoding = 'UTF-8', fileEncoding = "UTF-8")
topShopWithLL <- read.csv('data/topShopOfBJWithLL.csv')

#getDataWithoutLL and remove reduplicate shop:
topShop <- unique(topShopWithLL[,c(3:12)])

#show density of minFee
jpeg(file="r/images/minFeeDensity.jpeg", width = 900, height = 600)
qplot(minFee, data=topShop[which(topShop$minFee<50),], geom = "density", color=factor(brand)) 
dev.off()

#show density of minDeveliverFee
jpeg(file="r/images/deliverFeeDensity.jpeg", width = 900, height = 600)
qplot(minDeliverFee, data=topShop[which(topShop$minDeliverFee<20),], geom = "density", color=factor(brand)) 
dev.off()

#Analyse deliver fee:
p1 <- qplot(minFee, data=topShop[which(topShop$minFee<50),], geom = "density", color=factor(brand)) 
p2 <- qplot(minFee, data=topShop[which(topShop$minFee<50),], geom = "density", color=factor(extraService)) 
p3 <- qplot(minDeliverFee, data=topShop[which(topShop$minDeliverFee<20),], geom = "density", color=factor(brand)) 
p4 <- qplot(minDeliverFee, data=topShop[which(topShop$minDeliverFee<20),], geom = "density", color=factor(extraService)) 
grid.arrange(p1, p2, p3, p4, nrow=2)
fee <- arrangeGrob(p1, p2, p3, p4, nrow=2)
ggsave(file="r/images/fee.jpeg", fee, width = 9, height = 6)
#ggsave(file="r/images/fee.jpeg", width = 3, height = 2)

bt<-theme(legend.position = "bottom")
t1<-qplot(deliverTime, data=topShop[which(topShop$deliverTime<60),], geom = "density", color=factor(brand)) 
t2<-qplot(deliverTime, data=topShop[which(topShop$deliverTime<60),], geom = "density", color=factor(extraService)) 
grid.arrange(t1+bt, t2+bt, nrow=2)
time <- arrangeGrob(t1+bt, t2+bt, nrow=2)
ggsave(file="r/images/time.jpeg", time, width = 9, height = 6)

#get top 200 shop from Beijing:
uniqueSold <- unique(topShopWithLL[,c("mtWmPoiId","sold")])
top200Sold <- uniqueSold[order(uniqueSold$sold,decreasing = T),][c(1:200),]
write.csv(file="data/top200ShopId.csv",top200Sold)

uniquedShop <- unique(topShopWithLL[,c(4:6,10:14)])
topOrderedShop <- uniquedShop[order(uniquedShop$sold,decreasing = T),]
top200Shop <- subset(topOrderedShop,select = c(name,sold,star,brand,extraService,mtWmPoiId))[c(1:200),]

jpeg(file="r/images/top200Brand.jpeg", width = 900, height = 600)
isBrand<-tapply(top200Shop$name,top200Shop$brand,length)
pie(isBrand,col=rainbow(7),labels=c("False","True"),main="Top 200 shop brand analyse")
dev.off()
table(top200Shop$brand)

jpeg(file="r/images/top200MtService.jpeg", width = 900, height = 600)
isMtService<-tapply(top200Shop$name,top200Shop$extraService,length)
pie(isMtService,col=rainbow(2),labels=c("False","True"),main="Top 200 shop Meituan Service analyse")
dev.off()
table(top200Shop$extraService)
table(top200Shop$extraService,top200Shop$brand)
table(topShopWithLL$extraService,topShopWithLL$brand)

#split(top200Shop,top200Shop$brand)

#pie <- ggplot(top200Shop, aes(x = "", y=extraService,fill = factor(brand),label=star)) + geom_bar(stat="identity",width = 1)
#pie + coord_polar("y",direction=1)

