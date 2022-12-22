// ~/.finicky.js

module.exports = {
  defaultBrowser: "Safari",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" }
    }
  ],
  handlers: [
    {
        match: [ 
           "https://*fortum*",
           "https://teams.microsoft.com/*",
           "https://www.office.com/*",
           "https://account.activedirectory.windowsazure.com/*",
        ],
      browser: "Microsoft Edge"
    },
  ]
};
