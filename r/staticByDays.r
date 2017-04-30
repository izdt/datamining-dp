setwd('../')
Sys.setlocale(locale = "Chinese")
shopOfPku <- read.csv('data/topShopOfPKU.csv',encoding = 'UTF-8',sep =',',quote = "")
shopSubSet <- subset(shopOfPku,select = c(date,sold,star,brand,extraService,mtWmPoiId,name))
shopDateCount <- tapply(shopOfPku$mtWmPoiId,shopOfPku$mtWmPoiId,length)
shop5days <- shopDateCount[which(shopDateCount==5)]
#match('495',rownames(shop5days))
shopLasted5Days <- shopSubSet[which(is.element(shopOfPku$mtWmPoiId, rownames(shop5days))),]
topShopLasted5Days <- shopLasted5Days[order(shopLasted5Days$sold,decreasing=TRUE),][c(1:25),]
qplot(date,sold,data=topShopLasted5Days,facets = . ~ mtWmPoiId ,color=factor(mtWmPoiId))

ggsave(file="r/images/topshop5Days.jpeg", width = 9, height = 6)
