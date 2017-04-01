const fs = require('fs');
const dataFloader = 'data';

const convertor = {
    shopListToCsv(){
        fs.readdir(dataFloader,(err,files)=>{
           for(let index in files){
               console.log(files[index]);
           }
        });
    }
}
convertor.shopListToCsv();
module.exports = convertor;