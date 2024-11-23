{ config, pkgs, ... }:

{
  imports = [
    ./colors.nix

    ./apps.nix
    ./bluetooth.nix
    ./browser.nix
    ./dev.nix
    ./docker.nix
    ./editor.nix
    ./git.nix
    ./services.nix
    ./shell.nix
    ./term.nix
    ./window-manager.nix
  ];
}
