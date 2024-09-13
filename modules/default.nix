{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fish.nix
    ./helix.nix
    ./lf.nix
    ./sway.nix
  ];
}
