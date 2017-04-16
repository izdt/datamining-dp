table <- read.table('data/shopList.txt', header = TRUE, encoding = 'UTF-8')
topShop <- read.table('data/topshopList.txt', header = TRUE, encoding = 'UTF-8' )
topShopWithLL <- read.table('data/topShopWithLL.txt', header = TRUE, encoding = 'UTF-8' )
#topShop <- read.csv('data/topshopList.csv', header = TRUE, encoding = 'UTF-8', sep =',' )

topShopSold <- topShopWithLL[c("lng","lat","sold","star","mtWmPoiId")]
star4brandShop <- topShopWithLL[which(topShopWithLL$star>40 & topShopWithLL$brand=="TRUE"),]

pkusoldStarshop <- subset(table, star>=30, select = c(sold,star,brand))

total <- tapply(topShop$sold, topShop$extraService, sum)
pie(total)
totalWithLL <- tapply(topShopWithLL$sold, list(topShopWithLL$lat,topShopWithLL$lng), sum)
data.class(totalWithLL)
rownames(totalWithLL)
colnames(totalWithLL)
totalWithLL["39.92","116.38"]
totalWithLL[1,]
totalWithLL[,1]
typeof(totalWithLL)
mode(totalWithLL)
#for( i in rownames(totalWithLL)) print(totalWithLL[i,])
for(i in rownames(totalWithLL)){
  for(j in colnames(totalWithLL)) print(c(i,j,totalWithLL[i,j]))
}


library(sqldf)
#totalSoldLL <- sqldf("select lng, lat, sum(sold), count(*) from topShopWithLL group by lng,lat",row.names=TRUE)
totalSoldLL <- sqldf("select lng, lat, sum(sold) as totalSold, count(*) as shopNum from topShopWithLL group by lng,lat order by lat desc")


library(ggplot2)
library(RColorBrewer)
#display.brewer.all()
#head(table)
ggplot(data=table,aes(x=star,y=sold,color=factor(brand))) + geom_point()
ggplot(data=topShop,aes(x=star,y=sold,color=factor(brand))) + geom_point()+geom_smooth()
ggplot(data=totoalWithLL,aes(x=star,y=sold,color=factor(brand))) + geom_point()
ggplot(data=pkusoldStarshop,aes(x=star,y=sold,color=factor(brand))) + geom_point()

sp <- ggplot(data=pkusoldStarshop,aes(x=star,y=sold,color=star)) + geom_point()
sp +scale_color_gradientn(colours = rainbow(5))

#ggplot(data=totalSoldLL,aes(x=lng,y=lat))+geom_point()
pal<-colorRamp(c("yellow","red"))
qplot(lng,lat,data=totalSoldLL,size=round(totalSold),color=round(totalSold/50),alpha=I(0.6))
