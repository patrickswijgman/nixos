{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  virtualisation.docker = {
    enable = true;
  };

  users.users.patrick = {
    extraGroups = mkOptionDefault [
      "docker"
    ];
  };
}
