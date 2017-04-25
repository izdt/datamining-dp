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

