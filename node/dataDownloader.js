const https = require('https');
const fs = require('fs');


const baseUrl = "https://takeaway.dianping.com/waimai/ajax/newm/newIndex";
const jsonFile = "data/shopList";
const offset = 20;

const dataDownloader = {
    fileNum:0,
    toSavedItems:0,
    currentData:[],
    saveShopListJson(data){
        this.currentData=[...this.currentData,...data];          
        this.toSavedItems++;
        if(this.toSavedItems>=offset){
            let saveData = JSON.stringify(this.currentData);
            console.log("save files: "+this.fileNum);
            fs.writeFile(jsonFile+this.fileNum+".json",saveData,(err)=>{
                console.log(err);
            });
            this.fileNum++;
            this.currentData = [];
            this.toSavedItems = 0;
        }
    },
    getShopList(data){
        let json = JSON.parse(data);
        let shopList=[];
        if(json.data&&json.data.shopList)
        shopList = json.data.shopList;
        console.log("get shoplist: "+shopList.length);
        return shopList;
    },
    download(startIndex,channel,lat,lng,geoType){
        startIndex = startIndex*25;
        let fromUrl = baseUrl+"?startIndex="+startIndex+"&channel="+channel+"&lat="+lat+"&lng="+lng+"&geoType="+geoType+"&initialLat="+lat+"&initialLng="+lng;
        console.log(fromUrl);
        https.get(fromUrl,(res)=>{
            let dpData = '';
            res.on('data', (data)=> {
                dpData += data;
            });
            res.on('end', ()=> {
                //console.log(dpData);
                let shopList = this.getShopList(dpData);
                this.saveShopListJson(shopList);
            });
        });
    },
    multiDownload(startIndex,channel,lat,lng,geoType){
        for(let i=0;i<500;i++){
            setTimeout(()=>{
                this.download(i,"6","39.99281","116.31088","2");
            },500*i);
        }
    }
}

dataDownloader.multiDownload("1","6","39.99281","116.31088","2");

module.exports = dataDownloader;