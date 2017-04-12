const https = require('https');
const fs = require('fs');

const baseUrl = "https://takeaway.dianping.com/waimai/ajax/newm/newIndex";
const jsonFile = "data/topShop/shopListBj";
const offset = 20;

const shopDownloaderLib = {
    fileNum:0,
    toSavedItems:0,
    currentData:[],
    saveShopListJson(data){
        this.currentData=[...this.currentData,...data];          
        this.toSavedItems++;
        if(this.toSavedItems>=offset){
            this.fileNum++;
            let saveData = JSON.stringify(this.currentData);
            console.log("save files: "+this.fileNum);
            fs.writeFile(jsonFile+this.fileNum+".json",saveData,(err)=>{
                console.log(err);
            });
            this.currentData = [];
            this.toSavedItems = 0;
        }
    },
    getShopList(data,lat,lng){
        let json = JSON.parse(data);
        let shopList=[];
        if(json.data&&json.data.shopList)
        shopList = json.data.shopList;
        shopList.forEach((s)=> {
           s.lat = lat;
           s.lng = lng;
        });
        console.log("get shoplist: "+shopList.length);
        return shopList;
    },
    download(startIndex,channel,lat,lng,sortId){
        startIndex = startIndex*25;
        let fromUrl = baseUrl+"?sortId="+sortId+"&startIndex="+startIndex+"&initialLat="+lat+"&initialLng="+lng;
        //let fromUrl = baseUrl+"?startIndex="+startIndex+"&channel="+channel+"&lat="+lat+"&lng="+lng+"&initialLat="+lat+"&initialLng="+lng+"&sortId="+sortId;
        console.log(fromUrl);
        https.get(fromUrl,(res)=>{
            let dpData = '';
            res.on('data', (data)=> {
                dpData += data;
            });
            res.on('end', ()=> {
                //console.log(dpData);
                let shopList = this.getShopList(dpData,lat,lng);
                this.saveShopListJson(shopList);
            });
        });
    }
}

module.exports = shopDownloaderLib;