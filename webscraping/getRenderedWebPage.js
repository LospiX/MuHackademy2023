const puppeteer = require('puppeteer');
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
(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://techoverflow.net', {waitUntil: 'domcontentloaded'});
  // Wait for 5 seconds
  console.log(await page.content());
  // Take screenshot
  await browser.close();
})();

console.log("Hello")
