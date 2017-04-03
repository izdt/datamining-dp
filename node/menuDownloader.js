const lib = require('./libs/menuDownloaderLib');
const shopLib = require('./libs/jsonToCsvLib');
const fs = require('fs');

const menuFolder = "data/menu/";
let shopIdList = [];
const getShopMenu = ()=>{
    let i = 0;
    for(let shopId of shopIdList){
        if(fs.existsSync(menuFolder+shopId+".json")) continue;
        i++;
        setTimeout(()=>{
            lib.downloadShopMenu(shopId);
        },(2000)*i);  
    }
};
const downloadMenu = ()=>{
    shopLib.getShopList((list)=>{
        //shopIdList.push(...list);
        list.forEach((shop)=>{
            shopIdList.push(shop.mtWmPoiId);
        });
    });
    setTimeout(getShopMenu,1500);
};
downloadMenu();