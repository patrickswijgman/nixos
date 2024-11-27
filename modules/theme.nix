{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    catppuccin = {
      enable = true;

      pointerCursor = {
        enable = true;
        accent = "dark";
      };
    };

    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        size = "standard";
        tweaks = [ "normal" ];
      };
    };
  };
}
