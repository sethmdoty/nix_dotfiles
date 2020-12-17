{ config, lib, pkgs, ... }:

{
  home-manager.users.sethdoty.programs.firefox = {
    enable = true;
    package = pkgs.Firefox;
    profiles.default = {
      settings = {
        "app.update.auto" = false;
        "browser.startup.homepage" = "about:home";
        "signon.rememberSignons" = false;
        "browser.contentblocking.category" = "standard";
        "browser.search.hiddenOneOffs" = "google, bing";
        "browser.search.region" = "US";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.search.countryCode" = "US";
        "browser.search.isUS" = true;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.newtabpage.enabled" = true;
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.uidensity" = 1;
        "browser.urlbar.update1" = true;
        "distribution.searchplugins.defaultLocale" = "en-US";
        "general.useragent.locale" = "en-US";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
      };
    };
  };
}
