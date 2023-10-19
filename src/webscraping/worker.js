const puppeteer = require("puppeteer");
const cp = require('child_process');
const common = require("./common");
const fs = require('fs');

let browser = null;


async function launch () {
  cp.spawn('node', ['chromiumLauncher.js'], {
    detached: true,
    shell: true,
    cwd: __dirname
  });
}

function getSettings() {
    try {
        let content = fs.readFileSync( common.fnSettings, {encoding: 'utf-8'});
        return JSON.parse(content);

    } catch (e) {
        if (e.code !== 'ENOENT') throw e;
        return null;
    }
}

async function connect () {
    if (browser) return browser;
    let settings = await getSettings();
    if (!settings) {
        await launch();
        settings = getSettings();
    }
    try {
        browser = await puppeteer.connect({browserWSEndpoint: settings.wsEndpoint});
    } catch (e) {
        const err = e.error || e;
        if (err.code === "ECONNREFUSED") {
            console.log("con ref");
            await launch();
            settings = await getSettings();
            browser = await puppeteer.connect({browserWSEndpoint: settings.wsEndpoint});
        }
    }
    return browser;
}
// (async () => { const brw = await connect(); const page = await brw.newPage(); })();

module.exports = connect;
