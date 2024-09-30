# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Full disk encryption.
  boot.initrd.luks.devices."luks-d7d0b5ae-7750-4367-bd0f-fe4c4aea239f".device = "/dev/disk/by-uuid/d7d0b5ae-7750-4367-bd0f-fe4c4aea239f";

  # Hostname.
  networking.hostName = "patrick-swijgman-work";

  # Options for home manager modules.
  home-manager.users.patrick = {
    # Git.
    programs.git = {
      userName = "Patrick";
      userEmail = "patrick.swijgman@wearespindle.com";
    };
  };
}
