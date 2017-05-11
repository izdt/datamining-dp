const fs = require('fs');
const dataFolder = 'data/shop/';
const shopCsvFile = 'data/shopList.csv';
const shopJsonFile = /^shopList\d*\.json$/;
const convertor = {
    appendToShopListCsv(data){
        let shopCsv = "";
        for(let shop of data){
            shopCsv+=shop.name+","
            +shop.sold+","
            +shop.star+","
            +shop.deliverTime+","
            +shop.minDeliverFee+","
            +shop.minFee+","
            +shop.brand+","
            +shop.overtimePaymentSupported+","
            +shop.isNewShopPromotion+","
            +(shop.extraService.indexOf(5)>=0)+","
            +shop.mtWmPoiId+"\r\n";
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