install.packages("wordcloud")
library(RColorBrewer) 
library(wordcloud)

#display.brewer.all()


jpeg(file="r/images/shopWordCloud.jpeg", width = 900, height = 600)
wordcloud(words = top200Shop$name, freq = top200Shop$sold,
          col = brewer.pal(9, "Dark2"), min.freq = min(top200Shop$sold), random.color = T,   
          max.words = max(top200Shop$sold), random.order = T,  scale = c(2,0.5))  
dev.off()

jpeg(file="r/images/menuWordCloud.jpeg", width = 900, height = 600)
wordcloud(words = top200Menu5$spuName, freq = top200Menu5$saleVolume/80,
          col = brewer.pal(9, "Dark2"), min.freq = min(top200Menu5$saleVolume), random.color = T,   
          max.words = 100, random.order = T,  scale = c(2,.2))  
dev.off()