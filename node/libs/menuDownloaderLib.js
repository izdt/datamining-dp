const https = require('https');
const fs = require('fs');

const folder = 'data/menu/';
const baseUrl = "https://takeaway.dianping.com/waimai/ajax/newm/menu?mtWmPoiId=";
const menuDownloader = {
    saveShopMenuFile(shopId,data){
        fs.writeFile(folder+shopId+".json",data,(err)=>{
           if(err) throw err;
        });
    },
    downloadShopMenu(shopId){
        if(fs.existsSync(folder+shopId+".json")) return;
        let url = baseUrl + shopId;
        https.get(url,(res)=>{
            let dpData = '';
            res.on('data', (data)=> {
                dpData += data;
            });
            res.on('end', ()=> {
                console.log("downloaded menu:"+shopId);
                let shopMenu = dpData;
                this.saveShopMenuFile(shopId,shopMenu);
            });
        });
    }
}

module.exports = menuDownloader;