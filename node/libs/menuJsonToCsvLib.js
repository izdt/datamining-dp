const fs = require('fs');
const dataFolder = 'data/menu/';
const menuCsvFile = 'data/menuList.csv';
const menuJsonFile = /^\d*\.json$/;
const convertor = {
    appendToMenuListCsv(data){
        let menuCsv = "";
        let categoryCounnt = data.data.categoryList.length;
        for(let category of data.data.categoryList){
            for(spu of category.spuList){
                menuCsv += spu.spuName+","
                +category.categoryName+","
                +spu.originPrice+","
                +spu.praiseNum+","
                +spu.saleVolume+","
                +spu.sellStatus+","
                +(spu.skuList[0]?spu.skuList[0].boxFee:0)+","
                +(spu.skuList[0]?spu.skuList[0].currentPrice:0)+","
                +(spu.skuList[0]?spu.skuList[0].minPurchaseNum:0)+","
                +(spu.skuList[0]?spu.skuList[0].realStock:0)+","
                +spu.spuPromotionInfo+","
                +spu.skuList.length+","
                +category.spuList.length+","
                +categoryCounnt+","
                +spu.spuId+","
                +data.data.mtWmPoiId+"\r\n";
             
            }
        }
        console.log(menuCsv);
        fs.appendFile(menuCsvFile,menuCsv,(err)=>{
            if(err) throw err;
        }); 
    },
    getMenuDataList(callback){
        fs.readdir(dataFolder,(err,files)=>{
           for(let file of files){
               if(menuJsonFile.test(file)){
                   //let shopId = file.substr(0,c.indexOf('.json'));
                   //console.log(file);
                //    fs.readFile(dataFolder+file,(err,data)=>{
                //        console.log("HI");
                //        let menuData = JSON.parse(data);
                //        console.log(menuData);
                //        if(menuData.code==0)
                //        callback(menuData);
                //    });
                   let data = fs.readFileSync(dataFolder+file);
                   let menuData = JSON.parse(data);
                   if(menuData.code==0)
                   callback(menuData);
               }
           }
        });
    }
}
module.exports = convertor;