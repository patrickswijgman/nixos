{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fish.nix
    ./gdu.nix
    ./git.nix
    ./helix.nix
    ./htop.nix
    ./lf.nix
    ./sway.nix
  ];
}
