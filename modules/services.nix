{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    systemd.user.services = {
      "clear-downloads" = {
        Unit = {
          Description = "Clear Downloads folder before shutdown";
          DefaultDependencies = "no";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "/bin/sh -c 'rm -rf /home/patrick/Downloads/*'";
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
      };
    };
  };
}
