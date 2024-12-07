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

    programs.neovim = {
      catppuccin = {
        enable = false; # Handled in custom Neovim config.
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
        icon = {
          enable = true;
        };
      };
    };
  };
}
