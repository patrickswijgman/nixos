{ config, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  # Git.
  programs.git = {
    userName = "Patrick";
    userEmail = "petrik09@live.nl";
  };
}
