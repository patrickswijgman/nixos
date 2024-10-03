{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    home.packages = with pkgs; [
      spotify
      slack
      aseprite
    ];
  };
}
