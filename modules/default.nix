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
    ./services.nix
    ./shell.nix
    ./term.nix
    ./theme.nix
    ./window-manager.nix
  ];
}
