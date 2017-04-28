#Set workspace to the path
setwd('../')

#use ggplot2 library
library(ggplot2)

menuTable <- read.csv('data/menuList.csv',encoding = 'UTF-8',fileEncoding = 'UTF-8',sep =',',quote = "")
