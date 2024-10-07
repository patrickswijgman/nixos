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
      spotify
      slack
      aseprite
    ];
  };

  xdg = {
    mime = {
      defaultApplications = mkOptionDefault {
        "image/png" = "aseprite.desktop";
        "image/jpg" = "aseprite.desktop";
        "image/jpeg" = "aseprite.desktop";
        "x-scheme-handler/slack" = "slack.desktop";
      };
    };
  };
}
