{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  home-manager.users.patrick = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-esr;
      languagePacks = [
        "en-US"
        "nl"
      ];
      # Check https://mozilla.github.io/policy-templates for policies.
      policies = {
        RequestedLocales = [
          "en-US"
          "nl"
        ];
        SearchEngines.Default = "DuckDuckGo";
        SearchEngines.PreventInstalls = true;
        DisablePocket = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "default-off";
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        FirefoxHome.TopSites = false;
        FirefoxHome.SponsoredTopSites = false;
        FirefoxHome.Highlights = false;
        FirefoxSuggest.WebSuggestions = false;
        FirefoxSuggest.SponsoredSuggestions = false;
        TranslateEnabled = false;
        ManagedBookmarks = [ ];
        NoDefaultBookmarks = true;
        DownloadDirectory = "~/Downloads";
        PromptForDownloadLocation = false;
        # Check about:config for options.
        # Double check https://mozilla.github.io/policy-templates/#preferences for supported options.
        Preferences = {
          "browser.aboutConfig.showWarning" = false;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
        };
        # Check https://mozilla.github.io/policy-templates/#extensionsettings for options.
        ExtensionSettings = {
          "nl-NL@dictionaries.addons.mozilla.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3776797/woordenboek_nederlands-4.20.19.xpi";
            installation_mode = "normal_installed";
          };
        };
      };
    };

    programs.chromium = {
      enable = true;
    };

    home.sessionVariables = {
      BROWSER = "firefox-esr";
      MOZ_ENABLE_WAYLAND = 1;
    };
  };

  xdg = {
    mime = {
      defaultApplications = mkOptionDefault {
        "application/pdf" = "firefox-esr.desktop";
        "application/json" = "firefox-esr.desktop";
        "x-scheme-handler/http" = "firefox-esr.desktop";
        "x-scheme-handler/https" = "firefox-esr.desktop";
      };
    };
  };
}
