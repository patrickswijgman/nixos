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

    programs.waybar = {
      catppuccin = {
        mode = "createLink";
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
