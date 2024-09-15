{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./lf.nix
    ./sway.nix
  ];
}