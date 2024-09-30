# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Hostname.
  networking.hostName = "patrick-acer";

  # Options for home manager modules.
  home-manager.users.patrick = {
    # Git.
    programs.git = {
      userName = "Patrick";
      userEmail = "petrik09@live.nl";
    };
  };
}
