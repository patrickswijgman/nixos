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
      # https://mozilla.github.io/policy-templates
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
        # See about:config
        # Double check https://mozilla.github.io/policy-templates/#preferences for supported options.
        Preferences = {
          "browser.aboutConfig.showWarning" = false;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
        };
        # https://mozilla.github.io/policy-templates/#extensionsettings
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
      # https://developer.mozilla.org/en-US/docs/Web/HTTP/MIME_types/Common_types
      defaultApplications = mkOptionDefault {
        "application/pdf" = "firefox-esr.desktop";
        "application/json" = "firefox-esr.desktop";
        "image/svg+xml" = "firefox-esr.desktop";
        "image/gif" = "firefox-esr.desktop";
        "x-scheme-handler/http" = "firefox-esr.desktop";
        "x-scheme-handler/https" = "firefox-esr.desktop";
      };
    };
  };
}
