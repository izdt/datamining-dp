const fs = require('fs');
const dataFolder = 'data';
const shopJsonFile = /^shopList\d*\.json$/;
const convertor = {
    appendToShopListCsv(data){
        console.log(data.length);
    },
    shopListToCsv(){
        fs.readdir(dataFolder,(err,files)=>{
           for(let index in files){
               let file = files[index];
               if(shopJsonFile.test(file)){
                   fs.readFile(dataFolder+"/"+file,(err,data)=>{
                       if (err) throw err;
                       let shopList = JSON.parse(data);
                       this.appendToShopListCsv(shopList);
                   })
               }
               //console.log(files[index]);
           }
        });
    }
}
convertor.shopListToCsv();
module.exports = convertor;