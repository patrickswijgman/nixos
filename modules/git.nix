{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Patrick";
    userEmail = "petrik09@live.nl";
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
}
