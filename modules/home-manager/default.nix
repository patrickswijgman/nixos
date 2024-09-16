{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./gdu.nix
    ./git.nix
    ./helix.nix
    ./htop.nix
    ./lf.nix
    ./ripgrep.nix
    ./sway.nix
  ];
}
