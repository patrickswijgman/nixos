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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Full disk encryption.
  boot.initrd.luks.devices."luks-d7d0b5ae-7750-4367-bd0f-fe4c4aea239f".device = "/dev/disk/by-uuid/d7d0b5ae-7750-4367-bd0f-fe4c4aea239f";

  # Hostname.
  networking.hostName = "patrick-swijgman-work";

  # Enable home manager.
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "patrick" = import ./home.nix;
    };
  };

  # Enable the stock NixOS power management tool which allows for managing hibernate and suspend states.
  powerManagement.enable = true;

  # A common tool used to save power on laptops.
  services.tlp.enable = true;
}
