const lib = require('./libs/shopDownloaderLib');
for(let i=0;i<500;i++){
    setTimeout(()=>{
        lib.download(i,"6","39.99281","116.31088","2");
    },500*i);
}