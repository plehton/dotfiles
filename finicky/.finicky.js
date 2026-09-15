// ~/.finicky.js
export default {
  defaultBrowser: "Safari",
  rewrite: [
    {
      // Redirect all urls to use https
      match: (url) => url.protocol === "http:",
      url: (url) => {
        url.protocol = "https:";
        return url;
      },
    },
    {
      // Redirect all localhost urls use http
      match: (url) => url.hostname === "localhost",
      url: (url) => {
        url.protocol = "http:";
        return url;
      },
    },
    {
      // use old.reddit.com
      match: (url) => url.hostname.endsWith("reddit.com"),
      url: (url) => {
        url.hostname = "old.reddit.com";
        return url;
      },
    },
  ],
  handlers: [
    {
      match: [
        "https://webars.*.com/myitportal/*",
        "https://fortum.service-now.com/*",
        "https://arsazureforms.fortum.com/*",
      ],
      browser: "Google Chrome",
    },
    {
      match: ["https://*youtube*"],
      browser: "Brave Browser",
    },
  ],
};
