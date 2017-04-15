#Set workspace to the path
setwd('d:/Projects/Github/iZDT/datamining-dp')

#use ggmap library
library(ggmap)
#use sqldf library
library(sqldf)
#use ggplot2 library
library(ggplot2)

#load data
topShop <- read.table('data/topShopWithLL.txt',  header = T, encoding = 'UTF-8')
#set to Beijing
bj <- c(left = 116.2, bottom = 39.8, right = 116.53, top = 40.02)
#set map format
map <- get_stamenmap(bj, zoom = 12, maptype = "toner-lite")
#use the map
ggmap(map)
totalSoldLL <- sqldf("select lng, lat, sum(sold) as totalSold, count(*) as shopNum from topShop group by lng,lat order by lat desc")
top100SoldLL <- totalSoldLL[order(totalSoldLL$totalSold,decreasing=TRUE),][c(1:100),]
topShopProcessData <- topShop[which(topShop$minFee<100 & topShop$minDeliverFee<50),]

qplot(minFee,minDeliverFee,data=topShopProcessData)
ggplot(data=topShopProcessData,aes(x=minFee,y=minDeliverFee,color=factor(extraService))) + geom_point()

qplot(minFee, data=topShopProcessData, geom = "bar") 
ggplot(data=topShopProcessData,aes(x=minFee))+geom_bar(aes(fill = minFee,position = "stack"))

#minFee
qplot(minFee, data=topShopProcessData, geom = "density", color=factor(brand)) 
#minDeliverFee 5
qplot(minDeliverFee, data=topShopProcessData, geom = "density", color=factor(brand)) 
#deliverTime brand 20/30
qplot(deliverTime, data=topShopProcessData, geom = "density", color=factor(brand)) 

shopmap <- ggmap(map) + 
  geom_point(aes(x = lng, y = lat, size = round(totalSold), color= round(totalSold/50)), data = totalSoldLL, alpha = .6)
shopmap +scale_color_gradientn(colours = rainbow(7))

ggmap(map) + 
  geom_point(aes(x=lng, y=lat), data=totalSoldLL, col="orange", alpha=0.6, size=totalSoldLL$totalSold*0.00008) + 
  scale_size_continuous(range=range(totalSoldLL$totalSold))

ggmap(map) + 
  geom_point(aes(x=lng, y=lat), data=top100SoldLL, col="red", alpha=0.3, size=top100SoldLL$totalSold*0.00009) + 
  scale_size_continuous(range=range(top100SoldLL$totalSold))

