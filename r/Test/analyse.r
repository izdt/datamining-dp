setwd('R/ABC')
trCountTable <- read.csv('TrLog.csv')
trTable <- read.csv('Log.csv')
trSummary <- summary(trTable)
trSortCount <- trCountTable[order(trCountTable$count,decreasing=T),]
#tapply(trTable$psg,sum)
apply(trTable,trTable$psg,length)

psgGroup <- split(trCountTable,trCountTable$psg)

psgCount <- tapply(trSortCount$count,trSortCount$psg,sum)
sortedPsg <- sort(psgCount,decreasing=T)
psgAnalyse <- sortedPsg[1:5]
psgAnalyse["OTHER"] <-  sum(sortedPsg[6:17])
pie(psgAnalyse)

trCount <- tapply(trSortCount$count,trSortCount$trcode,sum)
sortedTr <- sort(trCount, decreasing = T)
barplot(sortedTr[c(1:20)])

getKVTable <- function(data){
  dataName <- vector()
  dataValue <- vector()
  n <- as.numeric(0)
  for(i in rownames(data)){
    n <- n+1
    dataName[n] = i
    dataValue[n] = data[i]
  }
  dataFame <- data.frame(key=dataName,value=dataValue)
  return(dataFame)
}
psgCountT <- getKVTable(psgCount)

cityC <- tapply(trTable$psg,trTable$city,length)


