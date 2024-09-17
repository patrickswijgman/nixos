{ config, pkgs, ... }:

{
  imports = [
    ./browser.nix
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./term.nix
    ./wm.nix
  ];
}
