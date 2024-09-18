{ config, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  # Git.
  programs.git = {
    userName = "Patrick";
    userEmail = "patrick.swijgman@wearespindle.com";
  };
}
