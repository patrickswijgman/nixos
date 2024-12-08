{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  home-manager.users.patrick = {
    home.packages = with pkgs; [
      slack
      aseprite
      font-manager
    ];
  };

  xdg = {
    mime = {
      # https://developer.mozilla.org/en-US/docs/Web/HTTP/MIME_types/Common_types
      defaultApplications = mkOptionDefault {
        "image/png" = "aseprite.desktop";
        "image/jpeg" = "aseprite.desktop";
        "image/bmp" = "aseprite.desktop";
        "x-scheme-handler/slack" = "slack.desktop";
      };
    };
  };
}
