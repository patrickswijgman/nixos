{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.git = {
      enable = true;
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
  };
}
