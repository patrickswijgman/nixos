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
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/docker.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Hostname.
  networking.hostName = "patrick-acer";

  # Enable home manager.
  home-manager.users.patrick = import ./home.nix;

  # Enable the stock NixOS power management tool which allows for managing hibernate and suspend states.
  powerManagement.enable = true;

  # A common tool used to save power on laptops.
  services.tlp.enable = true;
}
