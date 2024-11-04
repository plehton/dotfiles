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
          "https://*youtube*",
          "https://webars.*.com/myitportal/*",
      ],
      browser: "Google Chrome"
    },
  ]
};
