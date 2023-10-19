//const writeText = require("mylib/core.io.file/write-text");
const puppeteer = require("puppeteer");

const fs = require('fs');

//const path = require("path");
const common = require("./common");
console.log(common.fnSettings);

(async () => {
    const launch_options = {
        args: ['--disable-features=site-per-process'],
        headless: false,
        devtools: false,
        defaultViewport: {width: 1200, height: 1000},
        userDataDir: common.userDataDir
    };
    const browser = await puppeteer.launch(launch_options);
    const wsEndpoint = browser.wsEndpoint();
    fs.writeFile(common.fnSettings, JSON.stringify({wsEndpoint}), function(err) {
        if(err) {
            return console.log(err);
        }
        console.log("The file was saved!");
    });
    return ;
})();
