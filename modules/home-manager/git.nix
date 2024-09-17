{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

let
  cfg = config.git;
in
{
  options.git = {
    name = mkOption {
      type = types.str;
      default = "Joe";
      description = ''
        The Git user name.
      '';
    };

    email = mkOption {
      type = types.str;
      default = "default@example.com";
      description = ''
        The Git user email.
      '';
    };
  };

  config = {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig = {
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
        };
        core = {
          editor = "hx";
        };
      };
    };

    programs.lazygit = {
      enable = true;
    };
  };
}
