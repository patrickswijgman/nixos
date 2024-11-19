{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    systemd.user.services = {
      "clear-downloads" = {
        Unit = {
          Description = "Clear Downloads folder before shutdown or reboot";
          DefaultDependencies = "no";
          Before = [
            "poweroff.target"
            "reboot.target"
          ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "rm -rf /home/patrick/Downloads/*";
        };
        Install = {
          WantedBy = [
            "poweroff.target"
            "reboot.target"
          ];
        };
      };
    };
  };
}
