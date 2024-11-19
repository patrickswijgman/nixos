{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    systemd.user.services = {
      "clear-downloads" = {
        Unit = {
          Description = "Clear Downloads folder before shutdown";
          Before = [ "poweroff.target" ];
          DefaultDependencies = "no";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "/bin/sh -c 'rm -rf $HOME/Downloads/*'";
        };
        Install = {
          WantedBy = [ "poweroff.target" ];
        };
      };
    };
  };
}
