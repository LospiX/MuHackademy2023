const puppeteer = require('puppeteer');
const connect = require('./worker.js');
/*
function run (pagesToScrape) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!pagesToScrape) {
                pagesToScrape = 1;
            }
            const browser = await puppeteer.launch();
            const page = await browser.newPage();
            await page.goto("https://news.ycombinator.com/");
            let currentPage = 1;
            let urls = [];
            browser.close();
            return page.content;
        } catch (e) {
            return reject(e);
        }
    })
}
*/
const arg = process.argv.slice(2);
const pageNum = Number(arg[0]);
const launch_options = {
    args: ['--disable-features=site-per-process','--no-sandbox', '--disable-setuid-sandbox'],
    headless: true,
    devtools: false,
  };


(async () => {
    const browser = await connect();
       // const browser = await puppeteer.launch(launch_options);
  //const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto(`https://www.ebay.it/sch/i.html?_from=R40&_nkw=apple&_sacat=0&LH_Sold=1&_ipg=240&_pgn=${pageNum}&rt=nc`, {waitUntil: 'domcontentloaded'});
  // Wait for 5 seconds
  console.log(await page.content());
    await page.close();
    process.exit(1);
  // Take screenshot
  //await browser.close();
})();

    
