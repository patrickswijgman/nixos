{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    languagePacks = [
      "en-US"
      "nl"
    ];
    policies = {
      RequestedLocales = [
        "en-US"
        "nl"
      ];
      SearchEngines.Default = "DuckDuckGo";
      DisablePocket = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";
      FirefoxHome.TopSites = false;
      FirefoxHome.SponsoredTopSites = false;
      FirefoxSuggest.WebSuggestions = false;
      FirefoxSuggest.SponsoredSuggestions = false;
      TranslateEnabled = false;
      Preferences = {
        "browser.aboutConfig.showWarning" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
      };
    };
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };
}
