const fs = require('fs');
const dataFolder = 'data/shopDate/';
const shopCsvFile = 'data/topShopOfPKU.csv';
const shopJsonFile = /^shop_\d*26\.json$/;
let shopIds = [];
const convertor = {
    appendToShopListCsv(data){
        let shopCsv = "";
        for(let shop of data){
            //if(shopIds.indexOf(shop.mtWmPoiId)>-1) continue;
            shopIds.push(shop.mtWmPoiId);
            shopCsv+="26," //shop.name+","
            //shopCsv+=shop.lng+","+shop.lat+"," //shop.name+","
            +shop.mtWmPoiId+","
            +shop.sold+","
            +shop.star+","
            +shop.deliverTime+","
            +shop.minDeliverFee+","
            +shop.minFee+","
            +shop.brand+","
            +shop.overtimePaymentSupported+","
            +shop.isNewShopPromotion+","
            +(shop.extraService.indexOf(5)>=0)+",\""
            +shop.name+"\"\r\n";
        }
        fs.appendFile(shopCsvFile,shopCsv,'UTF-8',(err)=>{
            if(err) throw err;
        });
    },
    getShopList(callback){
        fs.readdir(dataFolder,(err,files)=>{
           for(let index in files){
               let file = files[index];
               if(shopJsonFile.test(file)){
                   fs.readFile(dataFolder+file,(err,data)=>{
                       if (err) throw err;
                       let shopList = JSON.parse(data);
                       callback(shopList);
                   })
               }
           }
        });
    }
}
module.exports = convertor;