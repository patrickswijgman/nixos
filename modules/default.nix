{ config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./bluetooth.nix
    ./browser.nix
    ./dev.nix
    ./docker.nix
    ./editor/neovim.nix
    ./git.nix
    ./services.nix
    ./shell.nix
    ./term.nix
    ./theme.nix
    ./window-manager.nix
  ];
}
