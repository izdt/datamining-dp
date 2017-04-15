library(ggmap)
bj <- c(left = 116.2, bottom = 39.8, right = 116.53, top = 40.02)
map <- get_stamenmap(bj, zoom = 12, maptype = "toner-lite")
ggmap(map)
#map <- get_googlemap("beijing", zoom = 11) 
#ggmap(map)

topShop <- read.table('data/topshopList.txt', header = TRUE, encoding = 'UTF-8' )
library(sqldf)
#totalSoldLL <- sqldf("select lng, lat, sum(sold), count(*) from topShopWithLL group by lng,lat",row.names=TRUE)
totalSoldLL <- sqldf("select lng, lat, sum(sold) as totalSold, count(*) as shopNum from topShopWithLL group by lng,lat order by lat desc")
top100SoldLL <- totalSoldLL[order(totalSoldLL$totalSold,decreasing=TRUE),][c(1:100),]

topShopProcessData <- topShop[which(topShop$minFee<100 & topShop$minDeliverFee<50),]
qplot(minFee,minDeliverFee,data=topShopProcessData)
ggplot(data=topShopProcessData,aes(x=minFee,y=minDeliverFee,color=factor(extraService))) + geom_point()

#minFeeCount <- tapply(topShopProcessData$minFee, topShopProcessData$minFee, length)  
qplot(minFee, data=topShopProcessData, geom = "bar") 
ggplot(data=topShopProcessData,aes(x=minFee))+geom_bar(aes(fill = minFee,position = "stack"))
p<-ggplot(topShopProcessData,aes(x=factor(1),fill=factor(class)))+geom_bar(width=1)  
p+coord_polar(theta="y") 
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