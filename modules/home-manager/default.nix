{ config, pkgs, ... }:

{
  imports = [
    ./browser.nix
    ./dev.nix
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./term.nix
    ./wm.nix
  ];
}
