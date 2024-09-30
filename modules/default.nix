{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./browser.nix
    ./dev.nix
    ./docker.nix
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./term.nix
    ./wm.nix
  ];
}
