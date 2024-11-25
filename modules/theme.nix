{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    catppuccin = {
      enable = true;

      pointerCursor = {
        enable = true;
        accent = "light";
      };
    };
  };
}
