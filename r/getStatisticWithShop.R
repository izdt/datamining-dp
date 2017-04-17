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
topOrderedShop <- unique(topShopWithLL[,c(4:14)])

