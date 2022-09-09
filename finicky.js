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
           "https://www.office.com", 
        ],
      browser: "Microsoft Edge"
    },
  ]
};
