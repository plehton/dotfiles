// ~/.finicky.js
module.exports = {
  defaultBrowser: "Safari",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" },
    },
    {
      // use old.reddit.com
      match: ({ url }) => url.host.endsWith("reddit.com"),
      url: ({url}) => ({ "host": "old.reddit.com" }),
    },
  ],
  handlers: [
    {
      match: [
          "https://webars.*.com/myitportal/*",
          "https://fortum.service-now.com/*",
          "https://arsazureforms.fortum.com/*",
      ],
      browser: "Google Chrome"
    },
    {
      match: [
          "https://*youtube*",
      ],
      browser: "Brave Browser"
    },
  ]
};
