const fs = require('fs');
const file = 'data/top200ShopId.csv';
const topShp200Shop = {
    getShopList(){
        let ids = [];
        let content = fs.readFileSync(file,'utf-8');
        for(let line of content.split('\r\n')){
            let id = line.split(',')[0];
            if(id) ids.push(id);
        };
        return ids;
    }
}
module.exports = topShp200Shop.getShopList();