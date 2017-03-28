const https = require('https');

const baseUrl = "https://takeaway.dianping.com/waimai/ajax/newm/newIndex";

const dataDownloader = {

    getShopList(data){
        let json = JSON.parse(data);
        let shopList = json.data.shopList;
        return shopList;
    },
    download(startIndex,channel,lat,lng,geoType){
        let fromUrl = baseUrl+"?startIndex="+startIndex+"&channel="+channel+"&lat="+lat+"&lng="+lng+"&geoType="+geoType+"&initialLat="+lat+"&initialLng="+lng;
        console.log(fromUrl);
        https.get(fromUrl,(res)=>{
            let dpData = '';
            res.on('data', (data)=> {
                dpData += data;
            });
            res.on('end', ()=> {
                //console.log(dpData);
                let ShopList = getShopList(dpData);
            });
        });
    }
}

dataDownloader.download("1","6","39.99281","116.31088","2");

module.exports = dataDownloader;