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


ggmap(map) + 
  geom_point(aes(x = lng, y = lat, size = round(totalSold), color= round(totalSold/50)), data = totalSoldLL, alpha = .4)

ggmap(map) + 
geom_point(aes(x=lng, y=lat), data=totalSoldLL, col="orange", alpha=0.6, size=totalSoldLL$totalSold*0.00008) + 
scale_size_continuous(range=range(totalSoldLL$totalSold))
