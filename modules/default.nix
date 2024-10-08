{ config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./bluetooth.nix
    ./browser.nix
    ./dev.nix
    ./docker.nix
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./term.nix
    ./windowManager.nix
  ];
}
