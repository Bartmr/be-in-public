## Import Chrome passwords into Firefox

- Export your chrome passwords to csv
- In firefox, go to about:config and set signon.management.page.fileImport.enabled to true
- In firefox, go to passwords | 3 dots icon | import from file and import the csv file that you had exported from chrome

## Export bookmarks on exit

Set browser.bookmarks.autoExportHTML to true in about:config or user.js. This will generate a bookmarks.html file in your Firefox profiles' root directory eg. /home/snowman/.mozilla/firefox/0uffvdebh.default whenever the browser is closed.

See the Mozilla Support page for more information. [Export all the bookmarks from a loads of profiles from a script](https://support.mozilla.org/mk/questions/1374791)

This file can be copied and imported as expected.

## Firefox sync won't save imported passwords, but will save passwords manually entered

I resolved this issue with the following steps:

- Browsing to: https://accounts.firefox.com/settings
- Clicking on 'Show' for 'Devices and apps'
- Clicking disconnect next to all devices
- Clicking Done
- Closing Firefox
- Re-adding just the machine with the passwords 

It immediately auto-synced all passwords and then I reconnected the other machines, they synced as well.

I guess maybe there were some hiccups between devices... I don't know.
