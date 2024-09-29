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
    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh
      case "$1" in
          *.tar*) tar tf "$1";;
          *.zip) unzip -l "$1";;
          *) bat --style=full --color=always "$1";;
      esac
    '';
  };

  # programs.broot = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };

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

  programs.bat = {
    enable = true;
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
