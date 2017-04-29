#Set workspace to the path
setwd('../')

#use ggplot2 library
library(ggplot2)
Sys.getlocale()
Sys.setlocale(locale = "Chinese")
menuTable <- read.csv('data/menuList.csv',encoding = 'UTF-8',sep =',',quote = "")
#write.csv(menuTable, 'data/menu.csv', fileEncoding='UTF-8',quote = F)
#menuTable <- read.csv('data/menuList.csv',encoding = 'UTF-8',fileEncoding = 'UTF-8',sep =',',quote = "")
