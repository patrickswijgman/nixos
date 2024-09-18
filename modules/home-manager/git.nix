{ config, pkgs, ... }:

{
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
}
