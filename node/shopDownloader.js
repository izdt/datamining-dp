const lib = require('./libs/shopDownloaderLib');
// for(let i=0;i<500;i++){
//     setTimeout(()=>{
//         lib.download(i,"6","39.99281","116.31088","0");
//     },500*i);
// }

//Get top 25 shop for 600 dot at Beijing
for(let i=0; i< 20; i++){
    for(let j=0; j<30; j++){
        setTimeout(()=>{
            let lat = 40.00-0.01*i;
            let lng = 116.23+0.01*j;            
            lib.download(0,6,lat,lng,1);
        },(30*i+j)*500);
    }
}
