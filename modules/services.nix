{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    systemd.user.services = {
      dropbox = {
        Unit = {
          Description = "Dropbox service";
        };
        Service = {
          ExecStart = "${pkgs.dropbox}/bin/dropbox";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      clear-downloads = {
        Unit = {
          Description = "Clear Downloads folder before shutdown";
          DefaultDependencies = "no";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "/bin/sh -c 'rm -rf /home/patrick/Downloads/*'";
        };
        Install = {
          WantedBy = [ "poweroff.target" ];
        };
      };
    };
  };
}
