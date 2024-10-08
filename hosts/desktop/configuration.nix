# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname.
  networking.hostName = "patrick-desktop";

  # Options for home manager modules.
  home-manager.users.patrick = {
    # Git.
    programs.git = {
      userName = "Patrick";
      userEmail = "petrik09@live.nl";
    };
  };
}
