{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      keyboard.bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
    };
  };

  programs.lf = {
    enable = true;
    settings = {
      hidden = true;
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.htop = {
    enable = true;
  };

  home.packages = with pkgs; [
    unzip
    tree
    gdu
  ];
}
