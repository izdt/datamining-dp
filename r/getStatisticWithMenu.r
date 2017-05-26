#Set workspace to the path
setwd('../')

#use ggplot2 library
library(ggplot2)
Sys.getlocale()
Sys.setlocale(locale = "Chinese")
#options(encoding = "utf-8")
menuTable <- read.csv('data/menuList.csv',encoding = 'UTF-8',sep =',',quote = "")
#write.csv(menuTable, 'data/menu.csv', fileEncoding='UTF-8',quote = F)
#menuTable <- read.csv('data/menuList.csv',encoding = 'UTF-8',fileEncoding = 'UTF-8',sep =',',quote = "")
write.csv(menuTable,'data/menu.csv',quote=F)
menuData <- read.csv('data/menu.csv')

#plot(menuData$originPrice,menuData$saleVolume)
qplot(originPrice, data=menuData[which(menuData$saleVolume>0 & menuData$originPrice>3 & menuData$originPrice<100),], geom = "density")
qplot(originPrice,saleVolume,data=menuData[which(menuData$saleVolume>500 & menuData$originPrice>0 & menuData$originPrice<100),],geom = c("point","smooth"),color=I("#FFCC00"))

set.seed(10)
#menuData[sample(c(1:50)),]
top200Menu<-menuData[order(menuData$saleVolume,decreasing=TRUE),][c(1:200),]
qplot(originPrice,saleVolume,data=top200Menu)
qplot(originPrice, data=top200Menu, geom = "density", color=factor(spuPromotionInfo==""))
ggsave(file="r/images/top200MenuPro.jpeg", width = 9, height = 6)
top200MenuPS <- top200Menu[,c(5:7)]
k2 <- kmeans(na.omit(top200MenuPS),2)
#table(top200Menu$originPrice,k2$cluster)
plot(top200Menu$originPrice,top200Menu$saleVolume,col=k2$cluster)
#table(top200MenuPS$saleVolume,k2$cluster)
qplot(saleVolume,data=top200Menu)
qplot(originPrice,data=top200Menu)

#menuPS <- menuData[,c(5:7)]
#kA <- kmeans(na.omit(menuPS),2)
#plot(menuPS$originPrice,menuPS$saleVolume,col=kA$cluster)

#qplot(originPrice,saleVolume,data=top200Menu,facets = .(spuPromotionInfo=="") )

menuThan5<-menuData[which(menuData$originPrice>5 & menuData$originPrice<50 & !is.na(menuData$spuName)),]
top200Menu5<-menuThan5[order(menuThan5$saleVolume,decreasing=TRUE),][c(1:200),]
qplot(top200Menu5$originPrice,top200Menu5$saleVolume,data=top200Menu5,color=praiseNum)


